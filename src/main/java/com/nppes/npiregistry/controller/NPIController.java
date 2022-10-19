package com.nppes.npiregistry.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nppes.npiregistry.domain.SearchNPIData;
import com.nppes.npiregistry.dto.CSVFileImportResponse;
import com.nppes.npiregistry.dto.NPIDataDTO;
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
	@PostMapping("/v1/upload/npi-data")
	public CSVFileImportResponse importNPIRegistryCSVData(MultipartFile multipartFile, HttpServletRequest request)
			throws IOException {
		return npiService.importNPIRegistryCSVData(multipartFile);
	}

	/**
	 * This controller method is used to save and update npi-registry provider
	 * secondary address CSV file into DB.
	 * 
	 * @param multipartFile
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/v1/upload/npi-data/pl")
	public CSVFileImportResponse importNPIRegistryCSVDataForSecondaryPLAddress(MultipartFile multipartFile,
			HttpServletRequest request) throws IOException {
		return npiService.importNPIRegistryCSVDataForSecondaryPLAddress(multipartFile);
	}

	@GetMapping("/npidata")
	public List<NPIDataDTO> getNPIDetails(@RequestBody SearchNPIData searchNPIData) {
		return npiService.getNPIData(searchNPIData);
	}

}
