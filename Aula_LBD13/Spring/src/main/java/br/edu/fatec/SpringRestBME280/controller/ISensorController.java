package br.edu.fatec.SpringRestBME280.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import br.edu.fatec.SpringRestBME280.model.dto.BME280Dto;
import br.edu.fatec.SpringRestBME280.model.entity.BME280;

public interface ISensorController 
{
	public List<BME280Dto> findAll();
	public ResponseEntity<BME280Dto> find(String dt);
	public ResponseEntity<String> insert(BME280 sensor);
	public ResponseEntity<String> update(BME280 sensor);
	public ResponseEntity<String> delete(BME280 sensor);
}
