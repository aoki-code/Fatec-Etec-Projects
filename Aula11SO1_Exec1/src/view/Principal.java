package view;

import java.io.IOException;
import controller.Controle;

public class Principal {
	public static void main(String[]args) {
		Controle tbd = new Controle();
		String dir =  "C:\\TEMP";
		String name = "generic_food.csv";
		try {
			tbd.altt(dir,name);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

}
