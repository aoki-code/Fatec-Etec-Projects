package br.edu.fateczl.SpringUDF.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.SpringUDF.model.Dependente;
import br.edu.fateczl.SpringUDF.model.Funcionario;

@Repository
public class SalarioDao implements ISalarioDao{

	@Autowired
	GenericDao gDao;
	
	@Override
	public List<Funcionario> listaFuncionarios() throws ClassNotFoundException, SQLException {
		List<Funcionario> funcionarios = new ArrayList<Funcionario>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT nome,nome_d,salario,salario_d FROM fn_tabela()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Funcionario f = new Funcionario();
			f.setNome(rs.getString("nome"));
			f.setSalario(rs.getInt("salario"));
			
			Dependente d = new Dependente();
			d.setNome_d(rs.getString("nome_d"));
			d.setSalario_d(rs.getInt("salario_d"));
			
			f.setDependente(d);
			
			funcionarios.add(f);
		}
		
		rs.close();
		ps.close();
		c.close();
		return funcionarios;
	}

	@Override
	public List<Float> listaSalarioTotal(int qtdFuncionarios) throws ClassNotFoundException, SQLException {
		List<Float> salarioTotal = new ArrayList<Float>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT dbo.fn_salarios(?) AS salarioTotal";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, qtdFuncionarios);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			float s = rs.getFloat("salarioTotal");
			salarioTotal.add(s);
		}
		rs.close();
		ps.close();
		c.close();
		return salarioTotal;
	}

}
