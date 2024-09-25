package view;

import java.util.Random;

import controller.ThreadVetor;

public class Principal {

	public static void main(String[] args) {
		
		Random random = new Random();
		int vet[] = new int[1000];
		
		for (int i=0 ; i<1000 ; i++) {
			vet[i] = random.nextInt(101);
		}
		
		for (int op=1 ; op<3 ; op++) {
			Thread tCalct = new ThreadVetor(op, vet);
			tCalct.start();
		}
	}

}