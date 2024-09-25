package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import model.Cliente;

public class ClienteDao implements IClienteDao
{
	private GenericDao gDao;
	
	private final DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	
	public ClienteDao(GenericDao gDao) 
	{
		this.gDao = gDao;
	}
	
	public String iudCliente(String op, Cliente cli) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		
		String sql = "{CALL sp_cliente_validaCPF (?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, op);
		cs.setInt(2, cli.getCpf());
		cs.setString(3, cli.getNome());
		cs.setString(4, cli.getEmail());
		cs.setDouble(5, cli.getLimiteDoCartao());
		cs.getDate(df.format(cli.getDataNascimento()));
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(6);
		cs.close();
		c.close();
		
		return saida;
	}
	
}
