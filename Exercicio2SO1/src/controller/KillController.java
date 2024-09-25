package controller;

import java.io.IOException;
import java.util.Scanner;

public class KillController {
	
	public void os() {
		String os = System.getProperty("os.name");
		System.out.println(os);

		String ver = System.getProperty("os.version");
		System.out.println(ver);

		String arch = System.getProperty("os.arch");
		System.out.println(arch);
	}

	public void listaProcessos() {
		String os = System.getProperty("os.name");

		if (os.contains("Windows")) {
			try {
				Process process = Runtime.getRuntime().exec("TASKLIST /FO TABLE");
				Scanner leitor = new Scanner(process.getInputStream());
				while (leitor.hasNextLine()) {
					System.out.println(leitor.nextLine());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		if (os.contains("Linux")) {
			try {
				Process process = Runtime.getRuntime().exec("ps -ef");
				Scanner leitor = new Scanner(process.getInputStream());
				while (leitor.hasNextLine()) {
					System.out.println(leitor.nextLine());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


		}
	
	public void initProcess(String process) {
		try {
			Runtime.getRuntime().exec(process);
		} catch (Exception e) {
			String erro = e.getMessage();
			if (erro.contains("2")) {
				System.err.println("Aplicação não encontrada");
			}
			if (erro.contains("740")) {
				StringBuffer buffer = new StringBuffer();
				buffer.append("cmd /c");
				buffer.append(" ");
				buffer.append(process);

				String cmdCred = buffer.toString();

				try {
					Runtime.getRuntime().exec(cmdCred);
				} catch (Exception e1) {
					System.err.println("Chamada de aplicação inválida");
				}
			}
		}
	}
	
	public void mataNome(String opc) {
		String os = System.getProperty("os.name");
		String cmdNome = "";

		if (os.contains("Windows")) {
			cmdNome = "TASKKILL /IM";
		}
		if (os.contains("Linux")) {
			cmdNome = "pkill -f";
		}

		StringBuffer buffer = new StringBuffer();
		
		try {
			buffer.append(cmdNome);
			buffer.append(" ");
			buffer.append(opc);
		} catch (NumberFormatException e) {

		}
		initProcess(buffer.toString());
	}
	
	public void mataPid(String opd) {
		String os = System.getProperty("os.name");
		String cmdPid = "";
		if (os.contains("Windows")) {
			cmdPid = "TASKKILL /PID";
		}
		if (os.contains("Linux")) {
			cmdPid = "kill -9";
		}

		int pid = 0;
		StringBuffer buffer = new StringBuffer();
		
		try {
			pid = Integer.parseInt(opd);
			buffer.append(cmdPid);
			buffer.append(" ");
			buffer.append(pid);
		} catch (NumberFormatException e) {

		}
		initProcess(buffer.toString());
	}
	
}
