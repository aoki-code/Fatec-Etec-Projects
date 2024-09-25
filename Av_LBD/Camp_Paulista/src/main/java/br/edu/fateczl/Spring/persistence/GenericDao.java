package br.edu.fateczl.CampeonatoPaulistaSpring.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class GenericDao {
	private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostName="127.0.0.1";
		String dbName="campeonato";
		String user="sa";
		String password="123456";
		
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		String connect = 
				String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s", 
				hostName,dbName,user,password);
		c = DriverManager.getConnection(connect);
		return c;
	}
}
