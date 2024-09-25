package model;

public class Viagem 
{
	private int codigo;
	private String placaOnibus;
	private String horaSaida;
	private String horaChegada;
	private String partida;
	private String destino;
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getPlacaOnibus() {
		return placaOnibus;
	}
	public void setPlacaOnibus(String placaOnibus) {
		this.placaOnibus = placaOnibus;
	}
	public String getHoraSaida() {
		return horaSaida;
	}
	public void setHoraSaida(String horaSaida) {
		this.horaSaida = horaSaida;
	}
	public String getHoraChegada() {
		return horaChegada;
	}
	public void setHoraChegada(String horaChegada) {
		this.horaChegada = horaChegada;
	}
	public String getPartida() {
		return partida;
	}
	public void setPartida(String partida) {
		this.partida = partida;
	}
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
	}
	
	@Override
	public String toString() {
		return "Viagem [codigo=" + codigo + ", placaOnibus=" + placaOnibus + ", horaSaida=" + horaSaida
				+ ", horaChegada=" + horaChegada + ", partida=" + partida + ", destino=" + destino + "]";
	}
	
	
}
