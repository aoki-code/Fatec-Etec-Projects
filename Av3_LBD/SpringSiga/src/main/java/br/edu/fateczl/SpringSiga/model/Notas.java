package br.edu.fateczl.SpringSiga.model;


public class Notas
{
	private String codigo;
	private String tipo;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return "Notas [codigo=" + codigo + ", tipo=" + tipo + "]";
	}
}
