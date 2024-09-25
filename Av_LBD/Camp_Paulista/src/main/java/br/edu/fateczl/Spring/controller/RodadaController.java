package br.edu.fateczl.CampeonatoPaulistaSpring.controller;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.CampeonatoPaulistaSpring.persistence.RodadasDao;

@Controller
public class RodadaController {
	
	@Autowired
	RodadasDao rDao;

	@RequestMapping(name = "rodada", value = "/rodada", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("rodada");
	}

	@RequestMapping(name = "rodada", value = "/rodada", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String erro = "";
		String saida = "";
		try {
			saida = rDao.gerarRodadas();
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		}
		return new ModelAndView("rodada");
	}
}
