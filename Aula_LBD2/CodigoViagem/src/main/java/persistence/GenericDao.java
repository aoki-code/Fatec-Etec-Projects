package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao
{
	private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException
	{
		String hostname = "127.0.0.1";
		String dbName = "viajar";
		String user = "thais";
		String senha = "";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		
		String connect =
				String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;", 
						hostname, dbName, user, senha);
		
		c = DriverManager.getConnection(connect);
		return c;
	}
}
