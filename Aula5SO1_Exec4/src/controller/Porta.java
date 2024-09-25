package controller;

import java.util.concurrent.Semaphore;
import java.util.Random;

public class Porta extends Thread {

	private int idPessoa;
	private static int posSaida;
	private Semaphore semaforo;
	Random r = new Random();

	public Porta(int idPessoa, Semaphore semaforo) {
		this.idPessoa = idPessoa;
		this.semaforo = semaforo;
	}

	@Override
	public void run() {
		PessoaAndando();
		try {
			semaforo.acquire();
			PessoaNaPorta();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} finally {
			semaforo.release();
		}
		PessoaCruzando();
	}

	private void PessoaAndando() {
		int tempo = 1000;
		int distanciaPercorrida = 0;

		while (distanciaPercorrida < 200) {
			distanciaPercorrida += (int) ((Math.random() * 3) + 4);
			try {
				Thread.sleep(tempo);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("A Pessoa " + idPessoa + " já andou " + distanciaPercorrida + " metros");
		}
	}

	private void PessoaNaPorta() {
		System.out.println("A Pessoa " + idPessoa + " chegou na porta");
		double tempoInicial = System.nanoTime();
		int tempoParado = (r.nextInt(3 - 1) + 1) * 1000;
		try {
			Thread.sleep(tempoParado);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		double tempoFinal = System.nanoTime();
		double tempototal = tempoFinal - tempoInicial;
		tempototal = tempototal / Math.pow(10, 9);
		System.out.println("Pessoa" + idPessoa + " Tempo parado: " + tempototal);
	}

	private void PessoaCruzando() {
		posSaida++;
		System.out.println("A pessoa " + idPessoa + " foi a " + posSaida + "ª. a cruzar a porta");
	}
}