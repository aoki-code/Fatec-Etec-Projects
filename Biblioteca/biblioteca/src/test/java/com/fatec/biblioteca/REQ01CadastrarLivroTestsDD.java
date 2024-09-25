package com.fatec.biblioteca;


import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import com.fatec.biblioteca.model.Livro;

class REQ01CadastrarLivroTestsDD {
	Livro livro = new Livro();

	public String obtemDataAtual() {
		DateTime data = new DateTime();
		DateTimeFormatter fmt = DateTimeFormat.forPattern("dd/MM/YYYY");
		return data.toString(fmt);
	}
	
	String dataVenc = obtemDataAtual();
	
	@ParameterizedTest
	@CsvSource({
		"23424, Japi Pote, J.K. Rinling, 22/11/2023, 2421 , satisfatorio",
		"34234, Hobbit,	               , 10/10/2023, 3456 , Autor nao podera ser branco",
		"     , Senhor dos Aneis, J. R. R. Tolkien, 02/05/2023, 4321 , ISBN nao podera ser branco",
		"23553,          , J.K. Rinling, 10/07/2023, 2342 , Titulo nao podera ser branco",
		"45345, Assassinato no Expresso do Oriente, Agatha Christie,           , 3545 , Data de edição nao podera ser branco",
		"76345, Sherlock Holmes, Arthur Ignatius Conan Doyle, 21/09/2023, 	  , Edicao não poderá ser branco",
		"97823, Japi Pote, J.K. Rinling, 22/11/2024, 5345 , Data de edicao deverá ser anterior a data de hoje",

	})
	
	void validaLivro(String isbn, String titulo, String autor, String data, int edicao, String re) {
		try {
			livro = new Livro(isbn, titulo, autor, data, edicao);
			assertNotNull(livro);
			String dataDeHoje = obtemDataAtual();
			assertTrue(dataDeHoje.equals(livro.getData()));
			assertEquals ("satisfatorio", re);
		} catch (Exception e) {
			assertEquals(re, e.getMessage());
		}
		
	}
}
