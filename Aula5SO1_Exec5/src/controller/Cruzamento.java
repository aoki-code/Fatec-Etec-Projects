package controller;

import java.util.concurrent.Semaphore;

public class Cruzamento extends Thread {

	private int idCarro;
	private String direcao;
	private double tempoInicial, tempoFinal, tempoTotal;
	private Semaphore semaforo;

	public Cruzamento(String direcao, Semaphore semaforo) {
		this.idCarro = (int) this.getId();
		this.direcao = direcao;
		this.semaforo = semaforo;
	}

	@Override
	public void run() {
		CarroAndando();
		try {
			CarroEsperando();
			semaforo.acquire();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			semaforo.release();
		}
		CarroCruzando();
	}

	private void CarroAndando() {
		int tempo = 1000;
		int distanciaPercorrida = 0;

		while (distanciaPercorrida < 100) {
			distanciaPercorrida += (int) ((Math.random() * 5) + 6);
			try {
				Thread.sleep(tempo);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("O Carro " + idCarro + " já andou " + distanciaPercorrida + " metros");
		}
	}

	private void CarroEsperando() {
		System.out.println("O Carro " + idCarro + " parou no cruzamento");
		tempoInicial = System.nanoTime();
	}

	private void CarroCruzando() {
		tempoFinal = System.nanoTime();
		tempoTotal = tempoFinal - tempoInicial;
		tempoTotal = tempoTotal / Math.pow(10, 9);
		System.out.println("O carro " + idCarro + " ficou aguardando no cruzamento: " + tempoTotal
				+ "segundos e cruzou da direção " + direcao);
	}
}
