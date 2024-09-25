package br.edu.fateczl.SpringSiga.model;

public class Alunos
{
	private String ra;
	private String nome;
	
	public String getRa() {
		return ra;
	}
	public void setRa(String ra) {
		this.ra = ra;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	@Override
	public String toString() {
		return "Alunos [ra=" + ra + ", nome=" + nome + "]";
	}
}
