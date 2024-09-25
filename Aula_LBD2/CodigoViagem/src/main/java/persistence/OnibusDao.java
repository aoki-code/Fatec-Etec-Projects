package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Onibus;

public class OnibusDao 
{
	
private GenericDao gDao;
	
	public OnibusDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	public Onibus buscarOnibus(Onibus o) throws SQLException, ClassNotFoundException
	{
		Connection c = gDao.getConnection();
		String sql = "SELECT * from v_descricao_onibus WHERE codViagem = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, o.getCodViagem());
		ResultSet rs= ps.executeQuery();
			if(rs.next()) 
			{
				
				o.setPlaca(rs.getString("placaOnibus"));
				o.setMarca(rs.getString("marcaOnibus"));
				o.setDescricao(rs.getString("descOnibus"));
				o.setAno(rs.getInt("anoOnibus"));
				o.setCodViagem(rs.getInt("codViagem"));
				o.setNomeMotorista(rs.getString("nomeMotorista"));
			}
			
			rs.close();
			ps.close();
			c.close();
			
			return o;
	}
	
}
