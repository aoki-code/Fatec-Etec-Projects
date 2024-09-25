package br.edu.fateczl.SpringSiga.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.SpringSiga.model.Faltas;
import br.edu.fateczl.SpringSiga.persistence.MostrarFaltaDao;

@Controller
public class Servlet_InsereFalta 
{

	@RequestMapping(name = "insereFalta", value = "/insereFalta", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) 
	{
		return new ModelAndView("insereFalta");
	}
	
    @RequestMapping(name = "insereFalta", value = "/insereFalta", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
	
		int tamanho  = Integer.parseInt(request.getParameter("tamanho"));
		String dt  = request.getParameter("dt");
		String materia  = request.getParameter("aula");
		
		Faltas af = new Faltas();
		af.setDt(dt);
		af.setMateria(materia);
		
		for (int i= 1; i< tamanho; i++) 
		{
	
			String ra = request.getParameter(Integer.toString(i));	
			String falta = request.getParameter(ra);
			
			af.setRa(ra);
			af.setFalta(falta);
			
            try 
            {
                MostrarFaltaDao cDao = new MostrarFaltaDao();
                cDao.insereFalta(af);
            } 
            catch (ClassNotFoundException | SQLException e) 
            {
                 e.getMessage();
            }
	
	
		}
		
		RequestDispatcher r = request.getRequestDispatcher("insereFalta.jsp" ); 
		r.forward( request, response );
		
	}	
	
}