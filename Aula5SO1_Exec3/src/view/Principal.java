package view;

import java.util.Random;
import java.util.concurrent.Semaphore;

import controller.Bilheteria;

public class Principal {
	
	public static void main(String[] args) {
		Random numAleatorio = new Random();
		Semaphore controle = new Semaphore(1);
		
		for (int i = 0; i < 300; i++) {
			Thread compra = new Bilheteria(String.valueOf(i), (numAleatorio.nextInt(4)+1), controle);
			compra.start();
			
		}
	}

}
