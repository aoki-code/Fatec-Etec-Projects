package br.edu.fateczl.CampeonatoPaulistaSpring.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Grupo;
import br.edu.fateczl.CampeonatoPaulistaSpring.model.Time;

@Repository
public class GrupoDao implements IGrupoDao {

	@Autowired
	GenericDao gDao;


	@Override
	public String divideTimes() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();

		String sql = "CALL sp_divide_times (?)";
		CallableStatement cs = con.prepareCall(sql);
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(1);
		
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Grupo> listarTimes() throws SQLException, ClassNotFoundException {
		List<Grupo> participantes = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT g.codTime AS id, t.nomeTime, t.cidade, t.estadio, t.materialesportivo, g.grupo");
		sql.append(" FROM grupos g, times t");
		sql.append(" WHERE g.codTime = t.codTime");
		sql.append(" ORDER BY grupo");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setCodTime(rs.getInt("id"));
			t.setNomeTime(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			t.setMaterialesportivo(rs.getString("materialesportivo"));
			
			Grupo g = new Grupo();
			g.setTime(t);
			g.setGrupo(rs.getString("grupo"));
			
			participantes.add(g);
		}
		return participantes;
	}
	
	@Override
	public List<Grupo> listarGrupo (String letra) throws SQLException, ClassNotFoundException {
		List<Grupo> grupo = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT g.codTime AS id, t.nomeTime, t.cidade, t.estadio, t.materialesportivo, g.grupo");
		sql.append(" FROM grupos g, times t");
		sql.append(" WHERE g.codTime = t.codTime");
		sql.append(" AND grupo = ?");
		sql.append(" ORDER BY flag_especial DESC");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, letra);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			t.setCodTime(rs.getInt("id"));
			t.setNomeTime(rs.getString("nomeTime"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			t.setMaterialesportivo(rs.getString("materialesportivo"));
			
			Grupo g = new Grupo();
			g.setTime(t);
			g.setGrupo(rs.getString("grupo"));
			
			grupo.add(g);
		}
		return grupo;
	}

}
