package com.fatec.feriado;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import com.google.gson.Gson; 

class Req01ConsultarFeriado {

	@Test
	void ct01_consultar_feriado_com_sucesso() {
		String urlBase = "https://api.invertexto.com/v1/holidays/2022?token=5386|token&state=SP";
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		record Feriado(String date, String name, String type, String level) {};
		HttpEntity request = new HttpEntity<>(headers);
		ResponseEntity<String> response = restTemplate.exchange(urlBase, HttpMethod.GET, request, String.class);
		assertEquals("200 OK", response.getStatusCode().toString());
		assertEquals("application/json", response.getHeaders().getContentType().toString());
		converteUTF8(response.getBody());

	}

	@Test
	void ct02_consultar_feriado_com_autorizacao_invalida() {
		ResponseEntity<String> response = null;
		String urlBase = "https://api.invertexto.com/v1/holidays/2022?token=5386|token&state=SP";
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		record Feriado(String date, String name, String type, String level) {};
		HttpEntity request = new HttpEntity<>(headers);

		try {
			response = restTemplate.exchange(urlBase, HttpMethod.GET, request, String.class);

		} catch (HttpClientErrorException e) {

			assertEquals("401 UNAUTHORIZED", e.getStatusCode().toString());
			System.out.println(e.getResponseBodyAsString());
		}

	}
	
	public void converteUTF8(String str) {
		Gson gson = new Gson();
		try {
			String listaa = str;
			byte[] listab = listaa.getBytes("UTF-8");
			String str2 = new String(listab, "UTF-8");
			record Feriado(String date, String name, String type, String level) {};
			Feriado[] lista = gson.fromJson(str, Feriado[].class);
			System.out.println(lista[0]);
			assertEquals(17, lista.length);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@Test
	void ct03_consultar_feriado_com_ano_invalido() {
		ResponseEntity<String> response = null;
		String urlBase = "https://api.invertexto.com/v1/holidays/?token=5386|token&state=SP";
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		record Feriado(String date, String name, String type, String level) {};
		HttpEntity request = new HttpEntity<>(headers);

		try {
			response = restTemplate.exchange(urlBase, HttpMethod.GET, request, String.class);

		} catch (HttpClientErrorException e) {

			assertEquals("404 NOT_FOUND", e.getStatusCode().toString());
			System.out.println(e.getResponseBodyAsString());
		}

	}
	

}
