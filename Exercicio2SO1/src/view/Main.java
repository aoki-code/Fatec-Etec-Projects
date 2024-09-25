package view;

import controller.KillController;

public class Main {
	public static void main(String[] args) {
		KillController pCont = new KillController();
		pCont.os();
		
		pCont.listaProcessos();
		
		String opc = "WINWORD.EXE";
		pCont.mataNome(opc);
		
		String opd = "14288";
		pCont.mataPid(opd);

	}

}
