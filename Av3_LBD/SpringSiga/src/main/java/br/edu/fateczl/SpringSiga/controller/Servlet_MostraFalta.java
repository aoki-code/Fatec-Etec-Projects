package br.edu.fateczl.SpringSiga.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.SpringSiga.model.Alunos;
import br.edu.fateczl.SpringSiga.persistence.MostrarFaltaDao;

@Controller
public class Servlet_MostraFalta 
{
	@RequestMapping(name = "mostraFalta", value = "/mostraFalta", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) 
	{
		return new ModelAndView("mostraFalta");
	}

	@RequestMapping(name = "mostraFalta", value = "/mostraFalta", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		String materia  = request.getParameter("materias");
		String dt  = request.getParameter("data");
		ArrayList<Alunos> listaAlunos = new ArrayList<>();
		int aula = 0;
		
		try 
		{
			MostrarFaltaDao cDao = new MostrarFaltaDao();
			aula = cDao.qntAulas(materia);
		} 
		catch (ClassNotFoundException | SQLException e1) 
		{
			e1.printStackTrace();
		}
		
		try 
		{
			MostrarFaltaDao cDao = new MostrarFaltaDao();
			listaAlunos= cDao.listaAlunos();	
		}
		catch (ClassNotFoundException | SQLException e)
		{
			 e.getMessage();
		} 
		finally 
		{
			request.setAttribute("aluno", listaAlunos);
			request.setAttribute("data", dt);
			request.setAttribute("materia", materia);
			request.setAttribute("aulas", (aula/20));
			request.getRequestDispatcher("/insereFalta.jsp").forward(request, response);
		}
		
	}	
	
}

