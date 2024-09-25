package br.edu.fateczl.CampeonatoPaulistaSpring.model;

public class Time {
	private int codigo;
	private String nome;
	private String cidade;
	private String estadio;
	private String materialesportivo;
	
	public int getCodTime() {
		return codigo;
	}
	public void setCodTime(int codTime) {
		this.codigo = codTime;
	}
	public String getNomeTime() {
		return nome;
	}
	public void setNomeTime(String nomeTime) {
		this.nome = nomeTime;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstadio() {
		return estadio;
	}
	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}
	public String getMaterialesportivo() {
		return materialesportivo;
	}
	public void setMaterialesportivo(String materialesportivo) {
		this.materialesportivo = materialesportivo;
	}
	@Override
	public String toString() {
		return "Time [codigo=" + codigo + ", nome=" + nome + ", cidade=" + cidade + ", estadio=" + estadio
				+ ", materialesportivo=" + materialesportivo + "]";
	}
}
