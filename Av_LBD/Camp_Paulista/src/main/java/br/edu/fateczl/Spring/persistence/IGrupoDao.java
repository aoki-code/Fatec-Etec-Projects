package br.edu.fateczl.CampeonatoPaulistaSpring.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Grupo;

public interface IGrupoDao {
	
	public String divideTimes() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarTimes() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarGrupo(String letra) throws SQLException, ClassNotFoundException;
}
