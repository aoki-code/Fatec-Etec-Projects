package br.edu.fateczl.SpringSiga.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import br.edu.fateczl.SpringSiga.model.Alunos;
import br.edu.fateczl.SpringSiga.model.Nota;
import br.edu.fateczl.SpringSiga.model.Notas;

@Repository
public class MostrarNotaDao 
{
	private Connection c;
	
	public MostrarNotaDao() throws ClassNotFoundException, SQLException 
	{
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	

	public ArrayList<Alunos> listaAlunos() throws SQLException, ClassNotFoundException 
	{
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Alunos> Lista = new ArrayList<Alunos>();
		
		String selectStatement = "Select ra, nome from aluno";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) 
	    {	
	    	Alunos aluno = new Alunos();
	    	aluno.setRa(rs.getString("ra"));
	    	aluno.setNome(rs.getString("nome"));
	    	Lista.add(aluno);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return Lista;
	}


	public ArrayList<Notas> listaProvas(String materia) throws ClassNotFoundException, SQLException 
	{
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
		
		ArrayList<Notas> ListaN = new ArrayList<Notas>();
		
		String selectStatement = "Select codigo, tipo from avaliacao where codigo_disciplina = (?)";
		PreparedStatement prepStmt = c.prepareStatement(selectStatement);
		prepStmt.setString(1, materia);
	    ResultSet rs = prepStmt.executeQuery();
	
	    while (rs.next()) 
	    {	
	    	Notas prv = new Notas();
	    	prv.setCodigo(rs.getString("codigo"));
	    	prv.setTipo(rs.getString("tipo"));
	    	ListaN.add(prv);
	     }
	   
	     rs.close();
	     prepStmt.close();
		
		return ListaN;
	}


	public void insereNotas (Nota aluno) throws ClassNotFoundException, SQLException 
	{
        GenericDao gDao = new GenericDao();
        c = gDao.getConnection();

        String sql = "CALL SP_Nota_INS (?, ?, ?)";
        CallableStatement cs = c.prepareCall(sql);
        cs.setString(1, aluno.getRa());
        cs.setInt(2, Integer.parseInt(aluno.getCodigo_avaliacao()));
        cs.setDouble(3, Double.parseDouble(aluno.getNota()));
        cs.execute();
        cs.close();

    }
}
