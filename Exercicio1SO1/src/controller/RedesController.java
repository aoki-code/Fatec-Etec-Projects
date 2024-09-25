package controller;


import java.util.Scanner;
import java.io.IOException;

public class RedesController {
	
	public void os() {
		String os = System.getProperty("os.name");
		System.out.println(os);

		String ver = System.getProperty("os.version");
		System.out.println(ver);

		String arch = System.getProperty("os.arch");
		System.out.println(arch);
	}
	
	public void ip() {
		String os = System.getProperty("os.name");

		if (os.contains("Windows")) {
			try {
				Process process = Runtime.getRuntime().exec("ipconfig");
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
				Process process = Runtime.getRuntime().exec("ifconfig");
				Scanner leitor = new Scanner(process.getInputStream());
				while (leitor.hasNextLine()) {
					System.out.println(leitor.nextLine());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


		}
	
	public void ping() {
		String os = System.getProperty("os.name");

		if (os.contains("Windows")) {
			try {
				Process process = Runtime.getRuntime().exec("PING -4 -n 10 www.google.com.br");
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
				Process process = Runtime.getRuntime().exec("PING -4 -c 10 www.google.com.br");
				Scanner leitor = new Scanner(process.getInputStream());
				while (leitor.hasNextLine()) {
					System.out.println(leitor.nextLine());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


		}
}
	
