package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

import view.Interface;

public class Controle implements Interface{

	@Override
	public  Stack<String> empilhaBrasileiros(String caminho, String nome) throws IOException {
		File dir = new File(caminho);
		File file = new File(caminho,nome);
		Stack<String> pil = new Stack<String>();
		if(dir.exists() && dir.isDirectory()) {
			if(file.exists() && file.isFile()) {
				FileInputStream fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis);
				BufferedReader bufre = new BufferedReader(isr);
				String val = bufre.readLine();
				val = bufre.readLine();
				while(val != null){
					String[] sv = val.split(",");
					if(sv[5].equalsIgnoreCase("Brazil")) {
						pil.push(val);
					}
					val = bufre.readLine();
					}
				}else {
					throw new IOException("Não é dir");
			}
		}else {
			throw new IOException("Não é arquivo");
		}
		return pil;
	}
	@Override
	public void desmpilhaBonsBrasileiros(Stack<String> pilha) throws IOException {
		while(pilha.size()!=0){
			String player = pilha.pop();
			String[] sp = player.split(",");
			if(Integer.parseInt(sp[7]) > 80) {
				System.out.println("Nome: "+sp[2]+" - Overall: "+sp[7]);
			}
		}
		
	}

	@Override
	public  List<String> listaRevelacoes(String caminho, String nome) throws IOException {
		File dir = new File(caminho);
		File file = new File(caminho,nome);
		List<String> li = new LinkedList<String>();
		if(dir.exists() &&dir.isDirectory()) {
			if(file.exists() && file.isFile()) {
				FileInputStream fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis);
				BufferedReader bufre = new BufferedReader(isr);
				bufre.readLine();
				String vl = bufre.readLine();
				while(vl != null) {
					String[] sp = vl.split(",");
					if(Integer.parseInt(sp[3]) <= 20) {
						li.add(vl);
					
				}
					vl = bufre.readLine();
			}
			}
			
		}else {
			throw new IOException("Não é dir");
		}
		return li;
		
	}

	@Override
	public void buscaListaBonsJovens(List<String> lista) throws IOException {
		Iterator<String> it = lista.iterator();
		while(it.hasNext()) {
			String gp = it.next();
			String[] sp = gp.split(",");
			if(Integer.parseInt(sp[7]) > 80) {
				System.out.println("Nome: "+sp[2]+" - Idade: "+sp[3]+" - Overall: "+sp[7]);
			}
		}
		
	}

}