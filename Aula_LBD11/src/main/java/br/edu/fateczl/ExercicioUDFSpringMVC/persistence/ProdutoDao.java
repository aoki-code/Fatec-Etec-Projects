package br.edu.fateczl.ExercicioUDFSpringMVC.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import br.edu.fateczl.ExercicioUDFSpringMVC.model.Produto;

public class ProdutoDao implements IProdutoDao
{
	@Autowired
	GenericDao gDao;
	
	@Override
	public List<Produto> findProdutosSituacao() throws SQLException, ClassNotFoundException 
	{
		List<Produto> produtos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT codigo, nome, valor_unitario, qtd_estoque FROM fn_tabelaprod()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Produto produto = new Produto();
			produto.setCodigo(rs.getInt("codigo"));
			produto.setNome(rs.getString("nome"));
			produto.setValor_unitario(rs.getDouble("valor_unitario"));
			produto.setQtd_estoque(rs.getInt("qtd_estoque"));
			
			produtos.add(produto);
		}
		ps.close();
		rs.close();
		c.close();
		return produtos;
	}

	@Override
	public Produto findProdutoSituacao(Produto produto) throws SQLException, ClassNotFoundException 
	{
		
		Connection c = gDao.getConnection();
		String sql = 
				"SELECT codigo, nome, valor_unitario, qtd_estoque "
				+ " FROM fn_prod() WHERE cod = ?";
			PreparedStatement ps = c.prepareStatement(sql);
			ps.setInt(1, produto.getCodigo());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) 
			{
				produto.setNome(rs.getString("nome"));
				produto.setValor_unitario(rs.getDouble("valor_unitario"));
				produto.setQtd_estoque(rs.getInt("qtd_estoque"));
				
			}
			
			ps.close();
			rs.close();
			c.close();
			
		return produto;
	}

}
