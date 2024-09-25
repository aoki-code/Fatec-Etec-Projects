package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Cliente;
import persistence.ClienteDao;
import persistence.GenericDao;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    public ClienteServlet() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String cpf = request.getParameter("cpf");
		String nome = request.getParameter("nome");
		String email = request.getParameter("email");
		String limiteDoCartao = request.getParameter("limiteDoCartao");
		String dataNascimento = request.getParameter("dataNascimento");
		
		String botao = request.getParameter("botao");
		String op = botao.substring(0, 1);
		
		if(op.equals("A"))
		{
			op = "U";
		}
		
		Cliente  cli = new Cliente();
		cli = validaCliente(cpf, nome, email, limiteDoCartao, dataNascimento);
		String erro = "";
		String saida = "";
		
		try 
		{
			if(cli == null)
			{
				erro = "preencha os campos corretamente";
			}
			else
			{
				GenericDao gDao = new GenericDao();
				ClienteDao cDao = new ClienteDao(gDao);
				saida = cDao.iudCliente(op, cli);
			}
		} 
		catch (SQLException | ClassNotFoundException e) 
		{
			erro = e.getMessage();
		}
		finally 
		{
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
		
	}
	
	private Cliente validaCliente(String cpf,String nome, String email, String limiteDoCartao, String dataNascimento)
	{
		Cliente cli = new Cliente();
		
		if(cpf.equals("") || nome.equals("") || email.equals("") || limiteDoCartao.equals("") || dataNascimento.equals(""))
		{
			cli = null;
		}
		else
		{
			cli.setCpf(Integer.parseInt(cpf));
			cli.setNome(nome);
			cli.setEmail(email);
			cli.getLimiteDoCartao();
			cli.getDataNascimento();
		}
		
		return cli;
	}

}
