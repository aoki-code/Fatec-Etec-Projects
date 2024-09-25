package br.edu.fateczl.ExercicioUDFSpringMVC.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.ExercicioUDFSpringMVC.model.Produto;

public interface IProdutoDao 
{
	public List<Produto> findProdutosSituacao() throws SQLException, ClassNotFoundException;
	public Produto findProdutoSituacao(Produto produto) throws SQLException, ClassNotFoundException;
	
}
