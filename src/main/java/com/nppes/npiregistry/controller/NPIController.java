package com.nppes.npiregistry.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nppes.npiregistry.service.NPIService;

@RestController
public class NPIController {
	@Autowired
	NPIService npiService;

	/**
	 * This controller method is used to save and update npi-registry CSV file into
	 * DB.
	 * 
	 * @param multipartFile
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/v1/npi-registry/upload-csv")
	public String importNPIRegistryCSVData(MultipartFile multipartFile, HttpServletRequest request) throws IOException {
		return npiService.importNPIRegistryCSVData(multipartFile);
	}

}
