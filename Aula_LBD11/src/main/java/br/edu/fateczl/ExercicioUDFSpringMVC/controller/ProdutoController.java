package br.edu.fateczl.ExercicioUDFSpringMVC.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.ExercicioUDFSpringMVC.model.Produto;
import br.edu.fateczl.ExercicioUDFSpringMVC.persistence.ProdutoDao;

@Controller
public class ProdutoController 
{
	@Autowired
	ProdutoDao pDao;
	
	@RequestMapping(name = "produto", value = "/produto", 
			method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("produto");
	}
	
	@RequestMapping(name = "produto", value = "/produto", 
			method = RequestMethod.POST)
	public ModelAndView findProdutos(@RequestParam Map<String, String> params, ModelMap model) {
		String codigo = params.get("codigo");
		String botao = params.get("botao");
		
		Produto produto = new Produto();
		List<Produto> produtos = new ArrayList<>();
		String erro = "";
		try {
			if (botao.equals("Listar")) {
				produtos = pDao.findProdutosSituacao();
				produto = null;
			}
			if (botao.equals("Consultar") && !codigo.equals("")) {
				produto.setCodigo(Integer.parseInt(codigo));
				produto = pDao.findProdutoSituacao(produto);
				
			} else {
				if (botao.equals("Consultar") ) {
					erro = "Preencha o código";
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("produto", produto);
			model.addAttribute("produtos", produtos);
		}
		return new ModelAndView("produto");
	}
}
