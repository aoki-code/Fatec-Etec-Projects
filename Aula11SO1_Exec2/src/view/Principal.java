package view;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

import controller.Controle;

public interface Principal{
	public static void main(String[]args) {
		Controle fifc = new Controle();
		String path = "C:\\TEMP";
		String file = "data.csv";
		try {
			System.out.println("jogadores brasileiros com Overall acima de 80");
			Stack<String> pil = new Stack<String>();
			pil = fifc.empilhaBrasileiros(path, file);
			fifc.desmpilhaBonsBrasileiros(pil);
			System.out.println("jogadores monores de 20 anos com Overall acima de 80");
			List<String> obl = new LinkedList<String>();
			obl = fifc.listaRevelacoes(path, file);
			fifc.buscaListaBonsJovens(obl);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}