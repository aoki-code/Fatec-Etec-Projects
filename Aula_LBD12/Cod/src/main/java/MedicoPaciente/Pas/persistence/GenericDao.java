package MedicoPaciente.Pas.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

@Repository
public class GenericDao {
	private Connection c;
	public Connection getC() throws ClassNotFoundException, SQLException {
		String hostName = "localhost";
		String dbName = "medico";
		String user = "sa";
		String password = "B29123456
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		c = DriverManager.getConnection(
	String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s", 
			hostName,dbName,user,password)
				);
		return c;
	}
}
