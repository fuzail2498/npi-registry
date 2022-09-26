package com.nppes.npiregistry.dto;

import com.opencsv.bean.CsvBindByName;

public class CountryCSVImportDTO {

	@CsvBindByName(column = "code")
	private String code;

	@CsvBindByName(column = "name")
	private String name;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
