package view;

import java.util.concurrent.Semaphore;

import controller.Prato;

public class Principal {

	public static void main(String[] args) {

		Semaphore entrega = new Semaphore(1);

		for (int idThread = 1; idThread < 6; idThread++) {
			Prato t = new Prato(idThread, entrega);
			t.start();
		}
	}
}