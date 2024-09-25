package model;

import java.sql.Date;

public class Cliente 
{
	private int cpf;
	private String nome;
	private String email;
	private double limiteDoCartao;
	private Date dataNascimento;
	
	public int getCpf() {
		return cpf;
	}
	public void setCpf(int cpf) {
		this.cpf = cpf;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public double getLimiteDoCartao() {
		return limiteDoCartao;
	}
	public void setLimiteDoCartao(double limiteDoCartao) {
		this.limiteDoCartao = limiteDoCartao;
	}
	public Date getDataNascimento() {
		return dataNascimento;
	}
	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	
	@Override
	public String toString() {
		return "Cliente [cpf=" + cpf + ", nome=" + nome + ", email=" + email + ", limiteDoCartao=" + limiteDoCartao
				+ ", dataNascimento=" + dataNascimento + "]";
	}
	
	
}
