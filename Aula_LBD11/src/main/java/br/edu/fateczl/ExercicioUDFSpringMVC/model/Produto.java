package br.edu.fateczl.ExercicioUDFSpringMVC.model;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@EqualsAndHashCode
public class Produto 
{
	private int codigo;
    private String nome;
    private double valor_unitario;
    private int qtd_estoque;
	
}
