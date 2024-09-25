package br.edu.fateczl.CampeonatoPaulistaSpring.model;

public class Situacao {
	private int codTime;
	private String nomeTime;
	private String grupos;
	private int numJogosDisputados;
	private int vitorias;
	private int empates;
	private int derrotas;
	private int golsMarcados;
	private int golsSofridos;
	private int saldoGols;
	private int pontos;
	private int rebaixado;
	
	public int getRebaixado() {
		return rebaixado;
	}
	public void setRebaixado(int rebaixado) {
		this.rebaixado = rebaixado;
	}
	public int getCodTime() {
		return codTime;
	}
	public void setCodTime(int codTime) {
		this.codTime = codTime;
	}
	public String getNomeTime() {
		return nomeTime;
	}
	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}
	public String getGrupos() {
		return grupos;
	}
	public void setGrupos(String grupos) {
		this.grupos = grupos;
	}
	public int getNumJogosDisputados() {
		return numJogosDisputados;
	}
	public void setNumJogosDisputados(int numJogosDisputados) {
		this.numJogosDisputados = numJogosDisputados;
	}
	public int getVitorias() {
		return vitorias;
	}
	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}
	public int getEmpates() {
		return empates;
	}
	public void setEmpates(int empates) {
		this.empates = empates;
	}
	public int getDerrotas() {
		return derrotas;
	}
	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}
	public int getGolsMarcados() {
		return golsMarcados;
	}
	public void setGolsMarcados(int golsMarcados) {
		this.golsMarcados = golsMarcados;
	}
	public int getGolsSofridos() {
		return golsSofridos;
	}
	public void setGolsSofridos(int golsSofridos) {
		this.golsSofridos = golsSofridos;
	}
	public int getSaldoGols() {
		return saldoGols;
	}
	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}
	public int getPontos() {
		return pontos;
	}
	public void setPontos(int pontos) {
		this.pontos = pontos;
	}
	@Override
	public String toString() {
		return "Situacao [codTime=" + codTime + ", nomeTime=" + nomeTime + ", grupos=" + grupos
				+ ", numJogosDisputados=" + numJogosDisputados + ", vitorias=" + vitorias + ", empates=" + empates
				+ ", derrotas=" + derrotas + ", golsMarcados=" + golsMarcados + ", golsSofridos=" + golsSofridos
				+ ", saldoGols=" + saldoGols + ", pontos=" + pontos + "]";
	}
}
