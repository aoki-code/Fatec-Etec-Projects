package br.edu.fateczl.CampeonatoPaulistaSpring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Situacao;
import br.edu.fateczl.CampeonatoPaulistaSpring.model.Time;

public interface IFinaisDao {
	public List<Situacao> listarPorGrupos(String grupo) throws SQLException, ClassNotFoundException;
	public List<Situacao> listarTodos() throws SQLException, ClassNotFoundException;
	public List<Time> listarQuartas(String grupo) throws SQLException, ClassNotFoundException;
}
