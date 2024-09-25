package view;

import controller.RedesController;

public class Main {
	public static void main(String[] args) {
		RedesController pCont = new RedesController();
		pCont.os();
		
		pCont.ip();
		
		pCont.ping();
	}

}
