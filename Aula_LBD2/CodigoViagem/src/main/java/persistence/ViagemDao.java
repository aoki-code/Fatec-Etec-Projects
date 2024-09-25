package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Viagem;

public class ViagemDao 
{
	private GenericDao gDao;
	
	public ViagemDao(GenericDao gDao)
	{
		this.gDao = gDao;
	}
	
	
	public Viagem buscarViagem(Viagem v) throws SQLException, ClassNotFoundException
	{
		Connection c = gDao.getConnection();
		String sql = "SELECT * from v_descricao_viagem WHERE codViagem = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, v.getCodigo());
		ResultSet rs= ps.executeQuery();
			if(rs.next()) 
			{
				
				v.setCodigo(rs.getInt("codViagem"));
				v.setPartida(rs.getString("partida"));
				v.setDestino(rs.getString("destino"));
				v.setHoraSaida(rs.getString("saida"));
				v.setHoraChegada(rs.getString("chegada"));
				v.setPlacaOnibus(rs.getString("placaOnibus"));
			}
			
			rs.close();
			ps.close();
			c.close();
			
			return v;
	}
}
