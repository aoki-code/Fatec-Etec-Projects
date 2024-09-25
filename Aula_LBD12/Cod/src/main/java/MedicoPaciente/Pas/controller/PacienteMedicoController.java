package MedicoPaciente.MedP.controller;


import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
import org.springframework.web.bind.annotation.RequestParam;


import MedicoPaciente.MedP.persistence.GenericDao;
import MedicoPaciente.MedP.persistence.PacienteMedDao;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;
//import net.sf.jasperreports.repo.InputStreamResource;




@Controller
public class PacienteMedicoController {
	@Autowired
	PacienteMedDao pmd;
	
	@Autowired
	GenericDao gd;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(name = "index",value = "/index",method = RequestMethod.POST)
	public ResponseEntity geraR(@RequestParam Map<String,String> allRequestParam) {
		
		String bt = allRequestParam.get("bt");
		int isrt = Integer.parseInt(allRequestParam.get("cid"));
		
		String err= "";
		String pac = allRequestParam.get("st1");
		String med= allRequestParam.get("st2");
		
		Map<String,Object> param = new HashMap<String,Object>();
		if(bt!= null && bt.equalsIgnoreCase("Inserir")) {
			try {
				pmd.IsrC(med, pac, isrt);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			param.put("PACI", pac);
			param.put("MED", med);
			param.put("CIDP",isrt);
			System.out.println(pac+" - "+med+" - "+isrt);
		}
		if(bt!= null && bt.equalsIgnoreCase("exibir tipo2")) {
			param.put("PNOME", pac);
			param.put("MNOME", med);
		}
		//param.put("cid", cid);
		//param.put("data", dt);
		
		byte [] bytes = null;
		InputStreamResource resource = null;
		HttpStatus status = null;
		HttpHeaders header = new HttpHeaders();
		
		
		
		File arquivo=null;
		try {
			Connection conn = gd.getC();
			if(bt!= null && bt.equalsIgnoreCase("Inserir")) {
				arquivo = ResourceUtils.getFile("classpath:Simple_Blue_Table_Based.jasper");
			}
			if(bt!= null && bt.equalsIgnoreCase("exibir tipo2")) {
				arquivo = ResourceUtils.getFile("classpath:Simple_Blue.jasper");
			}
			JasperReport report = 
					(JasperReport) JRLoader.loadObjectFromFile(arquivo.getAbsolutePath());
			bytes = JasperRunManager.runReportToPdf(report,param, conn);
		} catch (FileNotFoundException | JRException | ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			err = e.getMessage();
			status = HttpStatus.BAD_REQUEST;
		} finally {
			if(err.equals("")) {
				InputStream is = new ByteArrayInputStream(bytes);
				resource = new InputStreamResource(is);
				header.setContentLength(bytes.length);
				header.setContentType(MediaType.APPLICATION_PDF);
				status = HttpStatus.OK;
			}
		}
		
		return new ResponseEntity(resource,header,status);
		
	}
}
