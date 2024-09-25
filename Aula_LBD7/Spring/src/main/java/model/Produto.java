package model;

public class Produto {

	private int codigo;
	private String nome;
	private double valorUnitario;
	private int qntEstoque;
	private int qntEMinima;
	
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

	public double getValorUnitario() {
		return valorUnitario;
	}

	public void setValorUnitario(double valorUnitario) {
		this.valorUnitario = valorUnitario;
	}

	public int getQntEstoque() {
		return qntEstoque;
	}

	public void setQntEstoque(int qntEstoque) {
		this.qntEstoque = qntEstoque;
	}
	
	public int getQntEMinima() {
		return qntEMinima;
	}

	public void setQntEMinima(int qntEMinima) {
		this.qntEMinima = qntEMinima;
	}

	@Override
	public String toString() {
		return "Produto [codigo=" + codigo + ", nome=" + nome + ", valorUnitario=" + valorUnitario + ", qntEstoque="
				+ qntEstoque + "]";
	}
	
}
