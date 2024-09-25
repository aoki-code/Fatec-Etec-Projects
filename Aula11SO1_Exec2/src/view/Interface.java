package view;

import java.io.IOException;
import java.util.List;
import java.util.Stack;

public interface Interface{
	public  Stack<String> empilhaBrasileiros(String caminho, String nome) throws IOException;
	public void desmpilhaBonsBrasileiros(Stack<String> pilha) throws IOException;
	public  List<String> listaRevelacoes(String caminho, String nome) throws IOException;
	public void buscaListaBonsJovens(List<String> lista) throws IOException;
}