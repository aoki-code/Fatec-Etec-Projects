package persistence;

import java.sql.SQLException;

import model.Cliente;

public interface IClienteDao 
{
	public String iudCliente(String op, Cliente cli) throws SQLException, ClassNotFoundException;
}
