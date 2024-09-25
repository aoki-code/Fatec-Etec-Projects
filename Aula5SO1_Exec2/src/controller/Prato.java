package controller;

import java.util.concurrent.Semaphore;

public class Prato extends Thread {

	private int idThread;
	private long tempoCozimento;
	private Semaphore semaforoEntrega;

	public Prato(int id, Semaphore semaforoEntrega) {
		this.idThread = id;
		this.semaforoEntrega = semaforoEntrega;
	}

	@Override
	public void run() {
		metodo();
	}

	private void metodo() {
		if (idThread % 2 == 1) {
			tempoCozimento = (long) (Math.random() * 300) + 500;
			System.out.println("Thread #" + idThread + ": Uma Sopa de Cebola foi colocada no fogo!");
			double tempoNoFogo = 0;
			double percentCozimento = 0.0;
			while (tempoNoFogo < tempoCozimento) {
				try {
					sleep(1000);
					tempoNoFogo += 100;
					percentCozimento = (tempoNoFogo / tempoCozimento);
					if (percentCozimento >= 1) {
						System.out.println("Sopa de Cebola #" + idThread + ": % de cozimento = 100% \nThread #" + idThread
								+ ": Sopa de Cebola cozida!");
					} else {
						System.out.println("Sopa de Cebola #" + idThread + ": % de cozimento = "
								+ (int) (percentCozimento * 100) + "%");
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			try {
				semaforoEntrega.acquire();
				sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			} finally {
				semaforoEntrega.release();
				System.out.println("Thread #" + idThread + ": Sopa de Cebola entregue!");
			}

		} else if (idThread % 2 == 0) {
			tempoCozimento = (long) (Math.random() * 600) + 600;
			System.out.println("Thread #" + idThread + ": Uma Lasanha a Bolonhesa foi colocada no fogo!");
			double tempoNoFogo = 0;
			double percentCozimento = 0.0;
			while (tempoNoFogo < tempoCozimento) {
				try {
					sleep(1000);
					tempoNoFogo += 100;
					percentCozimento = (tempoNoFogo / tempoCozimento);
					if (percentCozimento >= 1) {
						System.out.println("Lasanha a Bolonhesa #" + idThread + ": % de cozimento = 100% \nThread #"
								+ idThread + ": Lasanha a Bolonhesa cozida!");
					} else {
						System.out.println("Lasanha a Bolonhesa #" + idThread + ": % de cozimento = "
								+ (int) (percentCozimento * 100) + "%");
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			try {
				semaforoEntrega.acquire();
				sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			} finally {
				semaforoEntrega.release();
				System.out.println("Thread #" + idThread + ": Lasanha a Bolonhesa entregue!");
			}
		}
	}
}