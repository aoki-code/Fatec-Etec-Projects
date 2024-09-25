package br.edu.fateczl.SpringSiga.model;


public class Faltas 
{
	private String ra;
	private String falta;
	private String dt;
	private String materia;
	
	public String getRa() {
		return ra;
	}
	public void setRa(String ra) {
		this.ra = ra;
	}
	public String getFalta() {
		return falta;
	}
	public void setFalta(String falta) {
		this.falta = falta;
	}
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
	}
	public String getMateria() {
		return materia;
	}
	public void setMateria(String materia) {
		this.materia = materia;
	}
	
	@Override
	public String toString() {
		return "Faltas [ra=" + ra + ", falta=" + falta + ", dt=" + dt + ", materia=" + materia + "]";
	}
}
