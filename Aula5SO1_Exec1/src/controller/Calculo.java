package controller;

import java.util.concurrent.Semaphore;

public class Calculo extends Thread {

	private int idThread;
	private Semaphore semaforoBD;
	private double tempoCalculo, tempoBD;

	public Calculo(int id, Semaphore semaforoBD) {
		this.idThread = id;
		this.semaforoBD = semaforoBD;
	}

	@Override
	public void run() {
		definirTempos();
	}

	private void definirTempos() {

		if (idThread % 3 == 1) {
			tempoBD = 1000;
			tempoCalculo = (Math.random() * 800) + 200;
			Calcula();
			Grava();
			tempoCalculo = (Math.random() * 800) + 200;
			Calcula();
			Grava();
		} else if (idThread % 3 == 2) {
			tempoBD = 1500;
			tempoCalculo = (Math.random() * 1000) + 500;
			Calcula();
			Grava();
			tempoCalculo = (Math.random() * 1000) + 500;
			Calcula();
			Grava();
			tempoCalculo = (Math.random() * 1000) + 500;
			Calcula();
			Grava();
		} else if (idThread % 3 == 0) {
			tempoBD = 1500;
			tempoCalculo = (Math.random() * 1000) + 1000;
			Calcula();
			Grava();
			tempoCalculo = (Math.random() * 1000) + 1000;
			Calcula();
			Grava();
			tempoCalculo = (Math.random() * 1000) + 1000;
			Calcula();
			Grava();
		}
	}

	private void Calcula() {
		try {
			sleep((long) tempoCalculo);
			double tempo = tempoCalculo / 1000;
			System.out.format("A Thread " + idThread + " calculou por %.2f segundos. \n", tempo);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	private void Grava() {
		try {
			semaforoBD.acquire();
			sleep((long) tempoBD);
			System.out
					.println("A Thread " + idThread + " gravou no BD por " + (double) (tempoBD / 1000) + " segundos.");
		} catch (InterruptedException e) {
			e.printStackTrace();
		} finally {
			semaforoBD.release();
		}
	}

}