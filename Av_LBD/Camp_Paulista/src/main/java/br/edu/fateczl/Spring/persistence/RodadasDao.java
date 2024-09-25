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

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Jogo;
import br.edu.fateczl.CampeonatoPaulistaSpring.model.Time;

@Repository
public class RodadasDao implements IRodadasDao {

	@Autowired
	GenericDao gDao;

	@Override
	public String gerarRodadas() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();

		String sql = "CALL sp_partidas (?)";
		CallableStatement cs = con.prepareCall(sql);
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();

		String saida = cs.getString(1);

		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Jogo> listarRodada(String data) throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();

		Connection c = gDao.getConnection();
		int rodada = this.getRodada(c, 0, data);

		if (rodada != 0) {
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT j.codJogo AS cod, t1.codTime AS codTA, t1.nomeTime AS timeA, t2.codTime AS codTB , t2.nomeTime AS timeB, ");
			sql.append(" j.golsTimeA, j.golsTimeB, CONVERT(CHAR(10),j.data_jogo,103) AS datas");
			sql.append(" FROM jogos j, times t1, times t2");
			sql.append(" WHERE t1.codTime = j.codTimeA");
			sql.append(" AND t2.codTime = j.codTimeB");
			sql.append(" AND j.rodada = ?");
			sql.append(" ORDER BY j.data_jogo");

			PreparedStatement ps = c.prepareStatement(sql.toString());
			ps.setInt(1, rodada);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Jogo j = new Jogo();
				j.setCodJogo(rs.getInt("cod"));
				
				Time timeA = new Time();
				timeA.setCodTime(rs.getInt("codTA"));
				timeA.setNomeTime(rs.getString("timeA"));
				
				Time timeB = new Time();
				timeB.setCodTime(rs.getInt("codTB"));
				timeB.setNomeTime(rs.getString("timeB"));
				
				j.setTimeA(timeA);
				j.setTimeB(timeB);
				j.setGolsTimeA(rs.getInt("golsTimeA"));
				j.setGolsTimeB(rs.getInt("golsTimeB"));
				j.setDataJogo(rs.getString("datas"));

				jogos.add(j);
			}
			ps.close();
			rs.close();
		} else {
				throw new SQLException("Rodada n�o encontrada!");
		}
		
		c.close();
		return jogos;
	}

	@Override
	public int getRodada(Connection c, int rodada, String data) throws SQLException, ClassNotFoundException {

		String sql = "SELECT rodada FROM jogos WHERE data_jogo = ?";

		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data);

		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			rodada = rs.getInt("rodada");
		}
		ps.close();
		rs.close();
		return rodada;
	}

	@Override
	public void atualizar(int timeA, int golsA, int timeB, int golsB)
			throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "UPDATE jogos SET golsTimeA = ?, golsTimeB = ? WHERE codTimeA = ? AND codTimeB = ?";

		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, golsA);
		ps.setInt(2, golsB);
		ps.setInt(3, timeA);
		ps.setInt(4, timeB);

		ps.execute();
		ps.close();
		c.close();
	}

}
