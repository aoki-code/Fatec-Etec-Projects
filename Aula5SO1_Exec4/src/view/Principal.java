package view;

import java.util.concurrent.Semaphore;
import controller.Porta;

public class Principal {

	public static void main(String[] args) {
		int permissoes = 1;
		Semaphore semaforo = new Semaphore(permissoes);

		for (int idPessoa = 1; idPessoa < 5; idPessoa++) {
			Thread pessoa = new Porta(idPessoa, semaforo);
			pessoa.start();
		}
	}

}