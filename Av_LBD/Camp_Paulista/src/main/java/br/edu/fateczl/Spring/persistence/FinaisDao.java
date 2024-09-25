package br.edu.fateczl.CampeonatoPaulistaSpring.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Situacao;
import br.edu.fateczl.CampeonatoPaulistaSpring.model.Time;

@Repository
public class FinaisDao implements IFinaisDao {

	@Autowired
	GenericDao gDao;
	
	@Override
	public List<Situacao> listarPorGrupos(String grupo) throws SQLException, ClassNotFoundException {
		List<Situacao> times = new ArrayList<Situacao>();

		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT codTime, nome_time AS nome, grupo, num_jogos_disputados AS disputados,");
		sql.append(" vitorias, empates, derrotas, gols_marcados, gols_sofridos, saldo_gols, pontos");
		sql.append(" FROM situacao WHERE grupo = ?");
		sql.append(" ORDER BY  pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC");

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, grupo);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Situacao s = new Situacao();
			s.setCodTime(rs.getInt("codTime"));
			s.setNomeTime(rs.getString("nome"));
			s.setGrupos(rs.getString("grupo"));
			s.setNumJogosDisputados(rs.getInt("disputados"));
			s.setVitorias(rs.getInt("vitorias"));
			s.setEmpates(rs.getInt("empates"));
			s.setDerrotas(rs.getInt("derrotas"));
			s.setGolsMarcados(rs.getInt("gols_marcados"));
			s.setGolsSofridos(rs.getInt("gols_sofridos"));
			s.setSaldoGols(rs.getInt("saldo_gols"));
			s.setPontos(rs.getInt("pontos"));
			
			times.add(s);
		}
		return times;
	}

	@Override
	public List<Situacao> listarTodos() throws SQLException, ClassNotFoundException {
		List<Situacao> campeonato = new ArrayList<Situacao>();

		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT codTime, nome_time AS nome, grupo, num_jogos_disputados AS disputados,");
		sql.append(" vitorias, empates, derrotas, gols_marcados, gols_sofridos, saldo_gols, pontos");
		sql.append(" FROM situacao");
		sql.append(" ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC");

		int cont = 1;
		PreparedStatement ps = c.prepareStatement(sql.toString());

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Situacao s = new Situacao();
			s.setCodTime(rs.getInt("codTime"));
			s.setNomeTime(rs.getString("nome"));
			s.setGrupos(rs.getString("grupo"));
			s.setNumJogosDisputados(rs.getInt("disputados"));
			s.setVitorias(rs.getInt("vitorias"));
			s.setEmpates(rs.getInt("empates"));
			s.setDerrotas(rs.getInt("derrotas"));
			s.setGolsMarcados(rs.getInt("gols_marcados"));
			s.setGolsSofridos(rs.getInt("gols_sofridos"));
			s.setSaldoGols(rs.getInt("saldo_gols"));
			s.setPontos(rs.getInt("pontos"));
			
			if(cont >= 15) {
				s.setRebaixado(1);
			}
			
			campeonato.add(s);
			cont++;
		}
		return campeonato;
	}

	@Override
	public List<Time> listarQuartas(String grupo) throws SQLException, ClassNotFoundException {
		List<Time> times = new ArrayList<Time>();
		int cont = 0;

		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT nome_time AS nome");
		sql.append(" FROM situacao WHERE grupo = ?");
		sql.append(" ORDER BY  pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC");

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, grupo);

		ResultSet rs = ps.executeQuery();
		while (rs.next() && cont < 2) {
			Time t = new Time();
			t.setNomeTime(rs.getString("nome"));
			
			times.add(t);
			cont++;
		}
		return times;
	}
}
