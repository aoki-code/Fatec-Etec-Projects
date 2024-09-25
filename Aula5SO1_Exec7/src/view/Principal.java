package view;

import java.util.concurrent.Semaphore;

import controller.Deposito;
import controller.Saque;

public class Principal {

	public static void main(String[] args) {
		Semaphore limitacaoDeposito = new Semaphore(1);
		Semaphore limitacaoSaque = new Semaphore(1);
		for (int i = 0; i < 20; i++) {
			int tipo = (int) (Math.random() * 2);
			int idConta = (int) (Math.random() * 10000);
			double saldoConta = Math.round((Math.random() * 10000) * 100d) / 100d;
			double valorTransacao = Math.round((Math.random() * 10000) * 100d) / 100d;
			if (tipo == 0) {
				Deposito deposito = new Deposito(idConta, saldoConta, valorTransacao, limitacaoSaque);
				deposito.start();
			} else if (tipo == 1) {
				Saque saque = new Saque(idConta, saldoConta, valorTransacao, limitacaoDeposito);
				saque.start();
			}
		}

	}

}