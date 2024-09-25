package br.edu.fateczl.CampeonatoPaulistaSpring.controller;

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

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Situacao;
import br.edu.fateczl.CampeonatoPaulistaSpring.persistence.FinaisDao;

@Controller
public class FinalistasController {
	
	@Autowired
	FinaisDao fDao;

	@RequestMapping(name = "finalistas", value = "/finalistas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("finalistas");
	}
	
	@RequestMapping(name = "finalistas", value = "/finalistas", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<Situacao> grupoA = new ArrayList<Situacao>();
		List<Situacao> grupoB = new ArrayList<Situacao>();
		List<Situacao> grupoC = new ArrayList<Situacao>();
		List<Situacao> grupoD = new ArrayList<Situacao>();
		List<Situacao> todos = new ArrayList<Situacao>();
		String erro = "";
		String saida = "";
		try {
			if(botao.contains("grupo")) {
				grupoA = fDao.listarPorGrupos("A");
				grupoB = fDao.listarPorGrupos("B");
				grupoC = fDao.listarPorGrupos("C");
				grupoD = fDao.listarPorGrupos("D");
			}
			if(botao.contains("todos")) {
				todos = fDao.listarTodos();
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
			model.addAttribute("todos", todos);
		}
		return new ModelAndView("finalistas");
	}
}
