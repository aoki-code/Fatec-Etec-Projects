package br.edu.fateczl.SpringUDF.model;

public class Dependente {
	
	private int codigo_d;
	private String nome_d;
	private float salario_d;

	public int getCodigo_d() {
		return codigo_d;
	}
	public void setCodigo_d(int codigo_d) {
		this.codigo_d = codigo_d;
	}
	public String getNome_d() {
		return nome_d;
	}
	public void setNome_d(String nome_d) {
		this.nome_d = nome_d;
	}
	public float getSalario_d() {
		return salario_d;
	}
	public void setSalario_d(float salario_d) {
		this.salario_d = salario_d;
	}
	
	@Override
	public String toString() {
		return "dependente [codigo_d=" + codigo_d + ", nome_d=" + nome_d + ", salario_d=" + salario_d + "]";
	}

}
