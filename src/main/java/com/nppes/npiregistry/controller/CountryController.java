package com.nppes.npiregistry.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nppes.npiregistry.service.CountryService;

@RestController
public class CountryController {

	@Autowired
	CountryService countryService;

	/**
	 * This controller method is used to load country data into database from csv
	 * file.
	 * 
	 * @param multipartFile
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/v1/country/upload-csv")
	public String importCountryCSVData(MultipartFile multipartFile, HttpServletRequest request) throws IOException {
		return countryService.importCountryCSVData(multipartFile);
	}
}
