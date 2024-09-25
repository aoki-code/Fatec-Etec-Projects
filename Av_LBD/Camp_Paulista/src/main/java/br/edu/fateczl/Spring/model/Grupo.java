package br.edu.fateczl.CampeonatoPaulistaSpring.model;

public class Grupo {
	private Time time;
	private String grupo;
	
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	@Override
	public String toString() {
		return "Grupo [time=" + time + ", grupo=" + grupo + "]";
	}
}
