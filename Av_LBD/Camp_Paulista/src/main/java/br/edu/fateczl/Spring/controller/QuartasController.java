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

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Time;
import br.edu.fateczl.CampeonatoPaulistaSpring.persistence.FinaisDao;

@Controller
public class QuartasController {
	
	@Autowired
	FinaisDao fDao;

	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("quartas");
	}

	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String erro = "";
		List<Time> grupoA = new ArrayList<Time>();
		List<Time> grupoB = new ArrayList<Time>();
		List<Time> grupoC = new ArrayList<Time>();
		List<Time> grupoD = new ArrayList<Time>();
		
		try {
			grupoA = fDao.listarQuartas("A");
			grupoB = fDao.listarQuartas("B");
			grupoC = fDao.listarQuartas("C");
			grupoD = fDao.listarQuartas("D");
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
		}
		return new ModelAndView("quartas");
	}
}
