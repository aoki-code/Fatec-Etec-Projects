package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Produto;

public class ProdutoDao implements IProdutoDao {

	private GenericDao gDao;
	
	public ProdutoDao (GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public String insereProduto(Produto p) throws SQLException, ClassNotFoundException {
		
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("DECLARE @saida VARCHAR(MAX) ");
		sql.append("EXEC sp_produto 'i', ?, ?, ?, ?, @saida OUTPUT ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1,p.getCodigo());
		ps.setString(2,p.getNome());
		ps.setDouble(3,p.getValorUnitario());
		ps.setInt(4,p.getQntEstoque());
		ps.execute();
		ps.close();
		c.close();
		
		return "Produto inserido com sucesso";
	}

	@Override
	public String atualizaProduto(Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("DECLARE @saida VARCHAR(MAX) ");
		sql.append("EXEC sp_produto 'u', ?, ?, ?, ?, @saida OUTPUT ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1,p.getCodigo());
		ps.setString(2,p.getNome());
		ps.setDouble(3,p.getValorUnitario());
		ps.setInt(4,p.getQntEstoque());
		ps.execute();
		ps.close();
		c.close();
		
		return "Produto atualizado com sucesso";
	}

	@Override
	public String excluiProduto(Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("DECLARE @saida VARCHAR(MAX) ");
		sql.append("EXEC sp_produto 'd', ?, ?, ?, ?, @saida OUTPUT ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1,p.getCodigo());
		ps.setString(2,p.getNome());
		ps.setDouble(3,p.getValorUnitario());
		ps.setInt(4,p.getQntEstoque());
		ps.execute();
		ps.close();
		c.close();
		
		return "Produto excluido com sucesso";
		
	}

	@Override
	public Produto consultaProduto(Produto p) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("SELECT p.codigo, p.nome, p.valor_unitario, p.qnt_estoque ");
		sql.append("FROM prduto p ");
		sql.append("WHERE p.codigo = ? ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1,p.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setValorUnitario(rs.getDouble("valor_unitario"));
			p.setQntEstoque(rs.getInt("qnt_estoque"));
		}
		rs.close();
		ps.close();
		c.close();
		
		return p;
	}

	@Override
	public List<Produto> consultaProdutos() throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<Produto>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("SELECT p.codigo, p.nome, p.valor_unitario, p.qnt_estoque ");
		sql.append("FROM prduto p ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setValorUnitario(rs.getDouble("valor_unitario"));
			p.setQntEstoque(rs.getInt("qnt_estoque"));
			
			produtos.add(p);
		}
		rs.close();
		ps.close();
		c.close();
		
		return produtos ;
	
	}

	@Override
	public Produto consultaQntForaEstoque(int qntMinima) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("SELECT dbo.fn_estoque(?) AS qntMinima ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, qntMinima);
		ResultSet rs = ps.executeQuery();
		Produto p = new Produto();
		p.setQntEMinima(rs.getInt("qntMinima"));
		
		rs.close();
		ps.close();
		c.close();
		
		return p;
	}

	@Override
	public List<Produto> consultaProdutosForaEstoque(int qntMinima) throws SQLException, ClassNotFoundException {
		List<Produto> produtos = new ArrayList<Produto>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql =  new StringBuffer();
		sql.append("SELECT p.codigo, p.nome, p.qnt_estoque FROM fn_listaestoque(?) ");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, qntMinima);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Produto p = new Produto();
			p.setCodigo(rs.getInt("codigo"));
			p.setNome(rs.getString("nome"));
			p.setQntEstoque(rs.getInt("qnt_estoque"));
			
			produtos.add(p);
		}
		rs.close();
		ps.close();
		c.close();
		
		return produtos ;
	}
	
}
