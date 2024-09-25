package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class Controle {
	public void altt(String path,String name) throws IOException {
		File file = new File(path,name);
		if(file.exists() && file.isFile()){
			FileInputStream fis = new FileInputStream(file);
			InputStreamReader fsr = new InputStreamReader(fis);
			BufferedReader buf = new BufferedReader(fsr);
			String linha = buf.readLine();
			while(linha != null) {
				if(linha.contains("fruits")) {
					linha = linha.replace(",", "\t");
					System.out.println(linha);
				}else{
					System.out.println(linha);
				}
				linha = buf.readLine();
			}
		}else {
			throw new IOException("NÂO È ARQUIVO");
		}
	}

}
