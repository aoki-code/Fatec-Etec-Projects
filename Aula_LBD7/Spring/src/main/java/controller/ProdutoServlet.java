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

@WebServlet("/produto")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProdutoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String codigo = request.getParameter("codigo");
		String nome = request.getParameter("nome");
		String valor_unitario = request.getParameter("valor_unitario");
		String qnt_estoque = request.getParameter("qnt_estoque");
		String botao = request.getParameter("botao");
		
		Produto p = new Produto();
		
		GenericDao gDao = new GenericDao();
		IProdutoDao pDao = new ProdutoDao(gDao);
		String erro = "";
		String saida = "";
		List<Produto> produtos = new ArrayList<Produto>();
		
		try {
			
			if(botao.equals("Listar")) {
				produtos = pDao.consultaProdutos();
			}
			
			if(botao.equals("Inserir")) {
				p = valido(codigo, nome, valor_unitario, qnt_estoque, botao);
				saida = pDao.insereProduto(p);
				p = new Produto(); 
			}
			
			if(botao.equals("Atualizar")) {
				p = valido(codigo, nome, valor_unitario, qnt_estoque, botao);
				saida = pDao.atualizaProduto(p);
				p = new Produto(); 	
			}
			
			if(botao.equals("Excluir")) {
				p = valido(codigo, nome, valor_unitario, qnt_estoque, botao);
				saida = pDao.excluiProduto(p);
				p = new Produto(); 
			}
			
			if(botao.equals("Buscar")) {
				p = valido(codigo, nome, valor_unitario, qnt_estoque, botao);
				p = pDao.consultaProduto(p);
			}
		} catch(SQLException | ClassNotFoundException | IOException e){
			erro = e.getMessage();
		} finally {
			
			RequestDispatcher rd = request.getRequestDispatcher("produto.jsp");
			request.setAttribute("produto", p);
			request.setAttribute("produtos", produtos);
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			rd.forward(request, response);
		}
		
	}
	
	private Produto valido(String codigo, String nome, String valor_unitario, String qnt_estoque, String botao) throws IOException {
		
		Produto p = new Produto();
		
		if(botao.equals("Inserir")) {
			if(codigo.equals("") || nome.equals("")|| valor_unitario.equals("")|| qnt_estoque.equals("")) {
				throw new IOException("Preencher os campos");
			} else {
				p.setCodigo(Integer.parseInt(codigo));
				p.setNome(nome);
				p.setValorUnitario(Double.parseDouble(valor_unitario));
				p.setQntEstoque(Integer.parseInt(qnt_estoque));
			}
		}
		
		if(botao.equals("Atualizar")) {
			if(codigo.equals("") || nome.equals("")|| valor_unitario.equals("")|| qnt_estoque.equals("")) {
				throw new IOException("Preencher os campos");
			} else {
				p.setCodigo(Integer.parseInt(codigo));
				p.setNome(nome);
				p.setValorUnitario(Double.parseDouble(valor_unitario));
				p.setQntEstoque(Integer.parseInt(qnt_estoque));
			}
		}
		
		if(botao.equals("Excluir")) {
			if(codigo.equals("")) {
				throw new IOException("Preencher o ID.");
			} else {
				p.setCodigo(Integer.parseInt(codigo));
			}
		}
		
		if(botao.equals("Buscar")) {
			if(codigo.equals("")) {
				throw new IOException("Preencher o ID.");
			} else {
				p.setCodigo(Integer.parseInt(codigo));
			}
		}
		
		return p;
	}

}
