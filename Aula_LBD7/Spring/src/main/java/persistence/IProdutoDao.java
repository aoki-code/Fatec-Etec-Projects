package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Produto;

public interface IProdutoDao {

	public String insereProduto(Produto p) throws SQLException, ClassNotFoundException;
	public String atualizaProduto(Produto p) throws SQLException, ClassNotFoundException;
	public String excluiProduto(Produto p) throws SQLException, ClassNotFoundException;
	public Produto consultaProduto(Produto p) throws SQLException, ClassNotFoundException;
	public List<Produto> consultaProdutos() throws SQLException, ClassNotFoundException;
	public Produto consultaQntForaEstoque(int qntMinima) throws SQLException, ClassNotFoundException;
	public List<Produto> consultaProdutosForaEstoque(int qntMinima) throws SQLException, ClassNotFoundException;
	
}
