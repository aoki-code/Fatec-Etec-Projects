package com.fatec.biblioteca;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.jupiter.api.Test;

import com.fatec.biblioteca.model.Livro;

class REQ01CadastrarLivroTests {
	Livro livro = new Livro();
	Logger logger = LogManager.getLogger(this.getClass());
	
	public String obtemDataAtual() {
		DateTime data = new DateTime();
		DateTimeFormatter fmt = DateTimeFormat.forPattern("dd/MM/YYYY");
		//DateTime dataVencimento = dataAtual.plusDays(10);
		return data.toString(fmt);
	}
	
	@Test
	void ct01_cadastrar_livro_com_sucesso() {
		try {

		
			livro = new Livro("23424", "Japi Pote", "J.K. Rinling", "22/11/2003", 2421 );
			assertNotNull(livro);
			String dataDeHoje = obtemDataAtual();
			assertTrue(dataDeHoje.equals(livro.getData()));
		} catch (Exception e) {
			logger.info(">>>>>> ct01 - nao deveria falhar => " + e.getMessage());
			fail("nao deveria falhar fatura valida");

		}

	}

}
