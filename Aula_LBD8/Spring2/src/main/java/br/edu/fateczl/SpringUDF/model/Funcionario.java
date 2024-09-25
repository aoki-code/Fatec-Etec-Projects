package br.edu.fateczl.SpringUDF.model;

public class Funcionario {
	
	private int codigo;
	private String nome;
	private float salario;
	private Dependente dependente;
	
	public Dependente getDependente() {
		return dependente;
	}
	public void setDependente(Dependente dependente) {
		this.dependente = dependente;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public float getSalario() {
		return salario;
	}
	public void setSalario(float salario) {
		this.salario = salario;
	}
	
	@Override
	public String toString() {
		return "funcionario [codigo=" + codigo + ", nome=" + nome + ", salario=" + salario + "]";
	}

}
