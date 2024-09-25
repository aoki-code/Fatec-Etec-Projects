package br.edu.fatec.SpringRestBME280.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import br.edu.fatec.SpringRestBME280.model.entity.BME280;

public class BME280Dto 
{
	private LocalDateTime dateAndtime;
	private Double pressure;
	private Double humidity;
	private Double temperature;

	
	public LocalDateTime getDateAndtime() {
		return dateAndtime;
	}

	public void setDateAndtime(LocalDateTime dateAndtime) {
		this.dateAndtime = dateAndtime;
	}

	public Double getPressure() {
		return pressure;
	}

	public void setPressure(Double pressure) {
		this.pressure = pressure;
	}

	public Double getHumidity() {
		return humidity;
	}

	public void setHumidity(Double humidity) {
		this.humidity = humidity;
	}

	public Double getTemperature() {
		return temperature;
	}

	public void setTemperature(Double temperature) {
		this.temperature = temperature;
	}

	@Override
	public String toString() {
		return dateAndtime + " | " + pressure + " | " + humidity  + " | " + temperature;
	}
	
	
	public static BME280Dto parseToBME280DTO(BME280 bme) {
		BME280Dto dto = new BME280Dto();
		dto.setDateAndtime(bme.getDateAndtime());
		dto.setHumidity(bme.getHumidity());
		dto.setPressure(bme.getPressure());
		dto.setTemperature(bme.getTemperature());
		return dto;
	}
	
	public static List<BME280Dto> parseToBME280DTO(List<BME280> bmes) {
		List<BME280Dto> dtos = new ArrayList<>();
		for(BME280 bme:bmes) {
			BME280Dto dto = new BME280Dto();
			dto.setDateAndtime(bme.getDateAndtime());
			dto.setHumidity(bme.getHumidity());
			dto.setPressure(bme.getPressure());
			dto.setTemperature(bme.getTemperature());
			dtos.add(dto);
		}		
		return dtos;
	}

}
