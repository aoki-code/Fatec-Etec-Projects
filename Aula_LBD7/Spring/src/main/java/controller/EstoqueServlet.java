package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Produto;
import persistence.GenericDao;
import persistence.IProdutoDao;
import persistence.ProdutoDao;

@WebServlet("/estoque")
public class EstoqueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public EstoqueServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String minimo = request.getParameter("minimo");
		String botao = request.getParameter("botao");
		int qntForaEstoque = Integer.parseInt(minimo);
		
		Produto p = new Produto();
		
		GenericDao gDao = new GenericDao();
		IProdutoDao pDao = new ProdutoDao(gDao);
		String erro = "";
		String saida = "";
		List<Produto> produtos = new ArrayList<Produto>();
		
		try {
			
			if(botao.equals("Listar")) {
				
				produtos = pDao.consultaProdutosForaEstoque(qntForaEstoque);
			}
			
			if(botao.equals("Qnt")) {
				p = pDao.consultaQntForaEstoque(qntForaEstoque);
			}
			
		} catch(SQLException | ClassNotFoundException e){
			erro = e.getMessage();
		} finally {
			
			RequestDispatcher rd = request.getRequestDispatcher("produtoestoque.jsp");
			request.setAttribute("minimo", qntForaEstoque);
			request.setAttribute("produto", p);
			request.setAttribute("produtos", produtos);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
	}

}
