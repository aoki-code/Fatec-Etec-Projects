package controller;

import java.util.Random;

public class Soma extends Thread {
	private int n;
	private int i;
	private int res;
	private Random r = new Random();

	public Soma(int i) {
		this.i = i;
	}

	@Override
	public void run() {
		sum();
	}

	private void sum() {
		try {
			Thread.sleep(i*1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		for (int j = 0; j < 5; j++) {
			n = r.nextInt(10);
			res += n;
			if(j==4) {
				System.out.print(" " + n);
			}else {
				System.out.print(" " + n + " +");
			}
		}
		System.out.println();
		System.out.println("Thread => " + i + " = " + res);
		System.out.println("~~~~~~~~~~~~~~~~~~~");
	}
}