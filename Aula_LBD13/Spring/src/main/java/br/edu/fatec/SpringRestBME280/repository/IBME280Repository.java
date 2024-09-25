package br.edu.fatec.SpringRestBME280.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fatec.SpringRestBME280.model.entity.BME280;

public interface IBME280Repository extends JpaRepository<BME280, LocalDateTime>
{

}
