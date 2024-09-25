package br.edu.fateczl.SpringUDF.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.SpringUDF.model.Funcionario;

public interface ISalarioDao {
	
	public List<Funcionario> listaFuncionarios() throws ClassNotFoundException, SQLException;
	public List<Float> listaSalarioTotal(int qtdFuncionarios) throws ClassNotFoundException, SQLException;

}
