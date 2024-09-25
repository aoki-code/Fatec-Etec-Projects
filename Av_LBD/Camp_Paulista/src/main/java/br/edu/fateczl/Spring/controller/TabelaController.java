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

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Grupo;
import br.edu.fateczl.CampeonatoPaulistaSpring.persistence.GrupoDao;

@Controller
public class TabelaController {
	@Autowired
	GrupoDao grpDao;

	@RequestMapping(name = "tabela", value = "/tabela", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("tabela");
	}

	@RequestMapping(name = "tabela", value = "/tabela", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String erro = "";
		List<Grupo> grupoA = new ArrayList<Grupo>();
		List<Grupo> grupoB = new ArrayList<Grupo>();
		List<Grupo> grupoC = new ArrayList<Grupo>();
		List<Grupo> grupoD = new ArrayList<Grupo>();
		
		try {
			grupoA = grpDao.listarGrupo("A");
			grupoB = grpDao.listarGrupo("B");
			grupoC = grpDao.listarGrupo("C");
			grupoD = grpDao.listarGrupo("D");
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
		}
		return new ModelAndView("tabela");
	}
}
