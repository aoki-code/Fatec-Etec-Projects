package com.fatec.biblioteca.model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

public class Livro {
	String isbn;
	String titulo;
	String autor;
	String data;
	int edicao;
	Logger logger = LogManager.getLogger(this.getClass());
	
	public Livro(String isbn, String titulo, String autor, String data, int edicao) {
		this.isbn = setIsbn(isbn);
		this.titulo = setTitulo(titulo);
		this.autor = setAutor(autor);
		this.data = setData(data);
		this.edicao = edicao;

	}
	
	public Livro() {
	}

	public String getIsbn() {
		return isbn;
	}
	public String setIsbn(String isbn) {
		
		if (isbn == null || isbn.isBlank()) {
			 throw new IllegalArgumentException("O ISBN não deve estar em branco");
			 } else { 
				 return isbn;
			 }
	}
	public String getTitulo() {
		return titulo;
	}
	public String setTitulo(String titulo) {
		if (titulo == null || titulo.isBlank()) {
			 throw new IllegalArgumentException("O titulo não deve estar em branco");
			 } else { 
				return titulo;
			 }
	}
	public String getAutor() {
		return autor;
	}
	public String setAutor(String autor) {
		if (autor == null || autor.isBlank()) {
			 throw new IllegalArgumentException("O autor não deve estar em branco");
			 } else { 
				 return autor;
			 }
	}
	public String getData() {
		return data;
	}
	public String setData(String data) {
		if ((data != null) && (dataIsValida(data) == true)) {
			logger.info(">>>>>> setData  => " + data);
			return data;
		} else {
			throw new IllegalArgumentException("Data invalida");
		}
	}
	public int getEdicao() {
		return edicao;
	}
	public void setEdicao(int edicao) {
		if (edicao < 1) {
			 throw new IllegalArgumentException("O edicao não deve estar em branco");
			 } else { 
				 this.edicao = edicao;
			 }
	}
	
	public boolean dataIsValida(String data) {
		if (data != null) {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			df.setLenient(false);
			try {
				df.parse(data);
				return true;
			} catch (ParseException ex) {
				logger.info(">>>>>> isValida false=> " + ex.getMessage());
				return false;
			}
		} else {
			return false;
		}
	}

}
