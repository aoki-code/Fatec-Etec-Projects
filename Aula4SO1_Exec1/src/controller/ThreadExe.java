package controller;

public class ThreadExe extends Thread {
	
	private int idThread;
	
	public ThreadExe(int idThread) {
		this.idThread = idThread;
	}
	
	@Override
	public void run() {
		System.out.println(idThread);
	}

}
