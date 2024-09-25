package br.edu.fateczl.SpringUDF.controller;

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

import br.edu.fateczl.SpringUDF.model.Funcionario;
import br.edu.fateczl.SpringUDF.persistence.SalarioDao;

@Controller
public class FuncionarioController {
	
	@Autowired
	SalarioDao sDao;

	@RequestMapping(name = "funcionarios", value = "/funcionarios", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		String erro = "";
		List<Funcionario> funcionarios = new ArrayList<Funcionario>();
		try {
			funcionarios = listaFuncionarios();
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("funcionarios", funcionarios);
		}
		return new ModelAndView("funcionarios");
	}
	
	@RequestMapping(name = "funcionarios", value = "/funcionarios", method = RequestMethod.POST)
	public ModelAndView funcionarios(ModelMap model, @RequestParam Map<String, String> allParam) {
		String codigo = allParam.get("codigo");
		
		List<Float> salarioTotal = new ArrayList<Float>();
		String erro = "";
		List<Funcionario> funcionarios = new ArrayList<Funcionario>();	
		try {
			funcionarios = listaFuncionarios();
			if(!codigo.equals("")) {
				salarioTotal = sDao.listaSalarioTotal(Integer.parseInt(codigo));
			}else {
				erro = "Preencha o campo corretamente";
			}
		} catch (Exception e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("funcionarios", funcionarios);
			model.addAttribute("salarioTotal", salarioTotal);
		}
		return new ModelAndView("funcionarios");
	}
	
	private List<Funcionario> listaFuncionarios() throws ClassNotFoundException, SQLException{
		List<Funcionario> funcionarios = sDao.listaFuncionarios();
		return funcionarios;
	}
	
}
