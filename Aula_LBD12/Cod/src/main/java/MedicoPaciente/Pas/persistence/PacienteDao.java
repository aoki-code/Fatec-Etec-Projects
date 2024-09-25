package MedicoPaciente.Pas.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PacienteDao {
	@Autowired
	GenericDao gdao;
	public void IsrC(String idm,String idp,int cid) throws ClassNotFoundException, SQLException {
		Connection c = gdao.getC();
		String sql ="CALL CPROC ?,?,?";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, idm);
		cs.setString(2, idp);
		cs.setInt(3, cid);
		cs.execute();
		cs.close();
		c.close();
	}
}
