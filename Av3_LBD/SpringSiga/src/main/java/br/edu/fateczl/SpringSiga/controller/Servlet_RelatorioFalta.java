package br.edu.fateczl.SpringSiga.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.edu.fateczl.SpringSiga.persistence.GenericDao;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
public class Servlet_RelatorioFalta 
{

	@Autowired
	GenericDao gDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(name = "relatorioFalta", value = "/relatorioFalta", method = RequestMethod.POST)
	private ResponseEntity geraRelatorio(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException, SQLException 
	{
	
		String erro = "";
		String disciplina = request.getParameter("disciplina");
		
		Map<String, Object> param = new HashMap<>();
		param.put("disciplina", disciplina);
		
		byte[] bytes = null;
		HttpHeaders header = new HttpHeaders();
		HttpStatus status = null;
		InputStreamResource resource = null;
		
		try {
			Connection conn = gDao.getConnection();
			File arquivo = ResourceUtils.getFile("classpath:reports/exemploFaltas.jasper");
			JasperReport report = (JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report, param, conn);
			
			
		} 
		catch (JRException e) 
		{
			e.printStackTrace();
			erro = e.getMessage();
			status = HttpStatus.BAD_GATEWAY;
			
		}
		finally 
		{
			if (erro != null)
			{
				status = HttpStatus.OK;
				ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(bais);
				header.setContentType(MediaType.APPLICATION_PDF);
				header.setContentLength(bytes.length);
			}
			
		}
		
		return new ResponseEntity(resource, header, status);
	}
}