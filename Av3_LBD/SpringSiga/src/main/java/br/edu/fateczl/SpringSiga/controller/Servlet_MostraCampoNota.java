package br.edu.fateczl.SpringSiga.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.SpringSiga.model.Alunos;
import br.edu.fateczl.SpringSiga.model.Notas;
import br.edu.fateczl.SpringSiga.persistence.MostrarNotaDao;

@Controller
public class Servlet_MostraCampoNota extends HttpServlet 
{
	@RequestMapping(name = "insereNota", value = "/insereNota", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) 
	{
		return new ModelAndView("insereNota");
	}

	 @RequestMapping(name = "insereNota", value = "/insereNota", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	 {

		String materia = request.getParameter("materias");
		ArrayList<Alunos> listaAlunos = new ArrayList<>();
		ArrayList<Notas> listaAvaliacoes = new ArrayList<>();

		try
		{
			MostrarNotaDao cDao = new MostrarNotaDao();
			listaAvaliacoes = cDao.listaProvas(materia);
		} 
		catch (ClassNotFoundException | SQLException e1)
		{
			e1.printStackTrace();
		}

		try 
		{
			MostrarNotaDao cDao = new MostrarNotaDao();
			listaAlunos = cDao.listaAlunos();
		} 
		catch (ClassNotFoundException | SQLException e) 
		{
			e.getMessage();
		} 
		finally 
		{
			request.setAttribute("aluno", listaAlunos);
			request.setAttribute("materia", listaAvaliacoes);
			request.getRequestDispatcher("/insereNota.jsp").forward(request, response);
		}

	}

}