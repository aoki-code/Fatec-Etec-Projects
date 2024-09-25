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

import br.edu.fateczl.CampeonatoPaulistaSpring.model.Jogo;
import br.edu.fateczl.CampeonatoPaulistaSpring.persistence.RodadasDao;

@Controller
public class DatasController {
	
	@Autowired
	RodadasDao rDao;

	@RequestMapping(name = "datas", value = "/datas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("datas");
	}

	@RequestMapping(name = "datas", value = "/datas", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String data = allParam.get("data_rodada");
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		List<Jogo> rodada = new ArrayList<Jogo>();
		List<Jogo> pontuacao = new ArrayList<Jogo>();
		try {
			if(botao.equals("Pesquisar")) {
				rodada = rDao.listarRodada(data);
				if(rodada == null){
					saida = "Data inexistente";
				}
			}
			if(botao.equals("Pontuar")) {
				pontuacao = rDao.listarRodada(data);
				if(pontuacao == null){
					saida = "Data inexistente";
				}
			}
			if(botao.equals("Atualizar")) {
				int contador = 1;
				int timeA = 0, timeB = 0, golA = 0, golB = 0;
				for(String key : allParam.keySet()) {
					if(!allParam.get(key).equals("") && 
							!allParam.get(key).equals("Atualizar")){
						if(contador % 2 == 0) {
							golB = Integer.parseInt(allParam.get(key));
							timeB = Integer.parseInt(key);
							rDao.atualizar(timeA, golA, timeB, golB);
						} else {
							golA = Integer.parseInt(allParam.get(key));
							timeA = Integer.parseInt(key);
						}
						contador ++;
					}
				}
				saida = "Os jogos foram atualizados";
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("rodada", rodada);
			model.addAttribute("pontuacao", pontuacao);
		}
		return new ModelAndView("datas");
	}
}
