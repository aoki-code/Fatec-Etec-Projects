package view;

import java.util.concurrent.Semaphore;

import controller.Calculo;

public class Principal {
	
	public static void main(String[] args) {
		Semaphore semaforoBD = new Semaphore(1);

		for (int idThread = 1; idThread < 22; idThread++) {
			Calculo t = new Calculo(idThread, semaforoBD);
			t.start();
		}
	}
}


