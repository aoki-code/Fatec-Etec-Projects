package controller;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Bilheteria extends Thread {
	private int tLogin;
	private int tCompra;
	private int numIngresso;
	private String cliente;
	private static int ingresso = 100;
	private Semaphore controle;
	
	Random numAleatorio = new Random();
	
	public Bilheteria(String cliente, int numIngresso, Semaphore controle) {
		
		this.cliente = cliente;
		this.numIngresso = numIngresso;
		this.controle = controle;
		
		
	}
	
	@Override
	public void run() {
		if (logar()) {
			if(realizarCompra()) {
				comprar();
			}
		}
		super.run();
	}
	

	private void comprar() {
		try {
			controle.acquire();
			if(numIngresso <= ingresso) {
				controleIngresso();
			}
			else {
				System.err.println("Cliente " + cliente + " tentou comprar " + numIngresso + " mas somente " + ingresso + " disponiveis");
			}
		}
		catch(InterruptedException e) {
			e.printStackTrace();
		}
		finally {
			controle.release();
		}
	}
	
	private boolean logar() {
		tLogin = numAleatorio.nextInt(2001) + 50;
		try {
			sleep(tLogin);
			if(tLogin < 1000) {
				System.out.print("Cliente " + cliente + " logado... \n");
				return true;
			}
			else {
				System.err.println("Cliente " + cliente + " expirou tempo de login");
			}
				
			}
		catch(InterruptedException e) {
			e.printStackTrace();
		}
		return false;
		}

	
	private boolean realizarCompra() {
		tCompra = numAleatorio.nextInt(3001) + 1000;
		
		try {
			sleep(tCompra);
			
			if (tCompra < 2500) {
				return true;
			}
			else {
				System.err.println("Cliente " + cliente + " expirou tempo de compra");
			}	
		}
		catch(InterruptedException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private void controleIngresso () {
		ingresso -= numIngresso;
		System.out.print("O Cliente " + cliente + " comprou " + numIngresso + " ingressos, restando apenas " + ingresso + " ingressos \n");
	}
	
}
