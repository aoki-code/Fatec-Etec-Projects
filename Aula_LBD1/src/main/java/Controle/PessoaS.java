package Controle;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/pessoa")
public class PessoaS extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PessoaS() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Entrou no servlet PessoaS");
		String idParam = request.getParameter("id");
		String nomeParam = request.getParameter("nome");
		
		Pessoa pessoa = new Pessoa();
		pessoa.setId(Integer.parseInt(idParam));
		pessoa.setNome(nomeParam);
		
		System.out.println(pessoa);
		
		List<Pessoa> pessoas = new ArrayList<Pessoa>();
		Pessoa pessoa1 = new Pessoa();
		pessoa1.setId(11);
		pessoa1.setNome("Teste");
		pessoa.add(pessoa1);
		
		Pessoa pessoa2 = new Pessoa();
		pessoa2.setId(12);
		pessoa2.setNome("Teste2");
		pessoa.add(pessoa2);
		
//		for (Pessoa p : pessoas) {
//			System.out.println(p);
//		}
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		request.setAttribute("pessoa", pessoa);
		request.setAttribute("pessoas", pessoas);
		rd.forward(request, response);
		
//		Map<String, String[]> parameterMap = request.getParameterMap();
//		Set<String> keySet = parameterMap.keySet();
//		
//	for (String key: keySet) {
//		String[] param = parameterMap.get(key);
//		System.out.println(param[0]);
//		
//	}
		
	}

}
