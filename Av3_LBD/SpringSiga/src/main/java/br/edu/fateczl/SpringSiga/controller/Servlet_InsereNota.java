package br.edu.fateczl.SpringSiga.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
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

import br.edu.fateczl.SpringSiga.model.Nota;
import br.edu.fateczl.SpringSiga.persistence.MostrarNotaDao;

@Controller
public class Servlet_InsereNota 
{
	
	@RequestMapping(name = "registraNota", value = "/registraNota", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) 
	{
		return new ModelAndView("registraNota");
	}

	@RequestMapping(name = "registraNota", value = "/registraNota", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		int tamanho = Integer.parseInt(request.getParameter("tamanho"));
		int jTamanho= Integer.parseInt(request.getParameter("jTamanho"));

		int k = 4000;
		int J = 2000;
		
		Nota a = new Nota();
		
		for(int i = 1; i< tamanho; i++)
		{
			String ra  = request.getParameter(Integer.toString(i));
			
			a.setRa(ra);
			
			for (int x = 1;  x<=jTamanho; x++) {
				String codigo = request.getParameter(Integer.toString(J));	
				String nota = request.getParameter(Integer.toString(k));
				
				if ((ra != "" && codigo != "" && nota != "")) 
				{

                    a.setCodigo_avaliacao(codigo);
                    a.setNota(nota);
 
                    
                    try 
                    {
                    	MostrarNotaDao cDao = new MostrarNotaDao();
                        cDao.insereNotas(a);
                    } 
                    catch (ClassNotFoundException | SQLException e)
                    {
                         e.getMessage();
                    }
                }
				
			J++;
			k++;
			}

		}
		
		RequestDispatcher r = request.getRequestDispatcher("insereNota.jsp"); 
		r.forward( request, response );

		
	}	
	
}