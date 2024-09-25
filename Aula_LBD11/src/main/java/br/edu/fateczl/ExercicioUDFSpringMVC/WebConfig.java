package br.edu.fateczl.ExercicioUDFSpringMVC;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc
@Configuration
@ComponentScan(basePackages = "br.edu.fateczl.ExercicioUDFSpringMVC")
public class WebConfig 
{
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// Configurar a pasta do CSS
		registry.addResourceHandler("/resources/**").addResourceLocations("/WEB-INF/resources/");
	}

	public void addViewControllers(ViewControllerRegistry registry) {
		// Abrir um index na chamada da URL sem passar por classe de controle
		registry.addViewController("/").setViewName("index");
	}
	
	@Bean
	public ViewResolver internalResourceViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/view/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

}
