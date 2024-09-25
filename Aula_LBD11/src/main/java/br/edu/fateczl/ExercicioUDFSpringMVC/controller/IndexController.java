package br.edu.fateczl.ExercicioUDFSpringMVC.controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

public class IndexController 
{
	@RequestMapping(name = "index", value = "/index", 
			method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) 
	{
		return new ModelAndView("index");
	}
}
