package br.edu.fatec.SpringRestBME280.model.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name = "BME280")
public class BME280 
{
	@Id
	@Column(name = "dateAndTime", length = 50, nullable = false)
	private LocalDateTime dateAndtime;
	
	@Column(name = "pressure", nullable = true)
	private Double pressure;
	
	@Column(name = "humidity", nullable = true)
	private Double humidity;
	
	@Column(name = "temperature", nullable = true)
	private Double temperature;
	
	
	public LocalDateTime getDateAndtime() {
		return dateAndtime;
	}
	
	public void setDateAndtime(String dateAndtime) {
		this.dateAndtime = parseDate(dateAndtime);
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
	
	public static LocalDateTime parseDate(String dateAndtime) {
		dateAndtime = dateAndtime.replaceAll("T", " ");
		DateTimeFormatter frm = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSSSSSS");
		return LocalDateTime.parse(dateAndtime,frm);
	}
}
