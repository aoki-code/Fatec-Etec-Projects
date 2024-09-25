package controller;

public class ThreadVetor extends Thread{
	
	private int op;
	private int vet[] = new int [1000];
	
	public ThreadVetor (int op, int vet[]) {
		this.op = op;
		this.vet = vet;
	}
	
	@Override
	public void run() {
		calcTemp();
	}

	private void calcTemp() {
		switch (op) {
		case 1:
			double tempoInicial = System.nanoTime();
			for (int valor: vet) {
				int x = valor;
			}
			double tempoFinal = System.nanoTime();
			double tempoTotal =  tempoFinal - tempoInicial;
			tempoTotal = tempoTotal / Math.pow(10, 9);
			System.out.println("Tempo para percorrer o vetor (Foreach)==> " + tempoTotal + "s.");
			break;
		case 2:
			tempoInicial = System.nanoTime();
			for (int i = 0 ; i < vet.length; i++) {
				int x= vet[i];
			}
			tempoFinal = System.nanoTime();
			tempoTotal =  tempoFinal - tempoInicial;
			tempoTotal = tempoTotal / Math.pow(10, 9);
			System.out.println("Tempo para percorrer o vetor (For normal)==> " + tempoTotal + "s.");
			break;
		}
	}

}