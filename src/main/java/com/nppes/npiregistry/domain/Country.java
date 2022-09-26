package com.nppes.npiregistry.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nppes.npiregistry.dto.CountryCSVImportDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "country_temp")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class Country {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected Long id;
	
	@Column(name = "country_code")
	private String code;

	@Column(name = "name")
	private String name;

	public Country(CountryCSVImportDTO countryCSVImportDTO) {
		this.code = countryCSVImportDTO.getCode();
		this.name = countryCSVImportDTO.getName();
	}

}
