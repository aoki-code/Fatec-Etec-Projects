package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Viagem;
import persistence.GenericDao;

@WebServlet("/viagem")
public class ViagemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public ViagemServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String codViagem = request.getParameter(codViagem);
		String partida = request.getParameter(partida);
		String destino = request.getParameter(destino);
		String saida = request.getParameter(saida);
		String chegada = request.getParameter(chegada);
		String placaOnibus = request.getParameter(placaOnibus);
		
		Viagem v = new Viagem();
		
		GenericDao gDao = new GenericDao();
		String erro = "";
		String saidaa = "";
		
		try 
		{
			if(botao.equals("Buscar"))
			{
				v = valido(codViagem);
			}
		} 
		catch (SQLException | ClassNotFoundException | IOException e) 
		{
			erro = e.getMessage();
		}
		finally
		{
			RequestDispatcher rd = request.getRequestDispatcher("viagem.jsp");
			request.setSttribute("viagem", v);
			request.setSttribute("erro", erro);
			request.setSttribute("saida", saida);
		
			rd.forward(request, response);
		}
		
	}
	
	private Viagem valido(String codViagem)
	{
		Viagem v = new Viagem();
		
		if(botao.equals("Buscar"))
		{
			if(codViagem.equals(""))
			{
				throw new IOException("Preencher ID");
			}
			else
			{
				v.setCodigo(Integer.parseInt(codViagem));
			}
			return v;
		}
	}
}
