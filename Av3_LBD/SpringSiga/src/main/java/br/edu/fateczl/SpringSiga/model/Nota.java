package br.edu.fateczl.SpringSiga.model;


public class Nota 
{
	private String ra;
	 private String codigo_avaliacao;
	 private String nota;
	 
	 public String getRa() {
		return ra;
	}
	public void setRa(String ra) {
		this.ra = ra;
	}
	public String getCodigo_avaliacao() {
		return codigo_avaliacao;
	}
	public void setCodigo_avaliacao(String codigo_avaliacao) {
		this.codigo_avaliacao = codigo_avaliacao;
	}
	public String getNota() {
		return nota;
	}
	public void setNota(String nota) {
		this.nota = nota;
	}
	
	@Override
	public String toString() {
		return "Nota [ra=" + ra + ", codigo_avaliacao=" + codigo_avaliacao + ", nota=" + nota + "]";
	}
}
