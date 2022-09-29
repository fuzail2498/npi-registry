package com.nppes.npiregistry.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.dto.CSVFileImportResponse;
import com.nppes.npiregistry.dto.CountryCSVImportDTO;
import com.nppes.npiregistry.enums.ImportResult;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.CountryRepository;
import com.opencsv.bean.CsvToBeanBuilder;

@Service
public class CountryService {

	@Autowired
	private CountryRepository countryRepository;
	private final Logger logger = LoggerFactory.getLogger(CountryService.class);

	/**
	 * This method is used to get the country by country name
	 * 
	 * @param countryName
	 * @return
	 */
	public Country getCountryByName(String countryName) {
		return countryRepository.findByName(countryName);
	}

	/**
	 * This method is used to get the country by country code
	 * 
	 * @param countryCode
	 * @return
	 */
	public Country getCountryByCode(String countryCode) {
		return countryRepository.findByCode(countryCode);
	}

	/**
	 * This method is used to get the list of all countries
	 * 
	 * @return
	 */
	public List<Country> getAllCountry() {
		return countryRepository.findAll();

	}

	/**
	 * This method is used to import the country data from the csv file.
	 * 
	 * @param multipartFile
	 * @return String
	 */
	public CSVFileImportResponse importCountryCSVData(MultipartFile multipartFile) throws IOException {
		logger.info("Inside CountryService::importCountryCSVData()");
		if (multipartFile == null || FilenameUtils.getExtension(multipartFile.getOriginalFilename()) == "") {
			logger.error("InsideCountryService::importCountryCSVData() :: Please provide valid CSV file for Country Data");
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
			logger.error("InsideCountryService::importCountryCSVData() :: Invalid File extension,Only CSV file acceptable.");
			throw new UnprocessableEntityException("Invalid File extension,Only CSV file acceptable.");
		}
		Reader reader = new InputStreamReader(multipartFile.getInputStream());
		List<CountryCSVImportDTO> countryBeans = new CsvToBeanBuilder<CountryCSVImportDTO>(reader)
				.withType(CountryCSVImportDTO.class).withIgnoreQuotations(true).withThrowExceptions(false).build()
				.parse();
		if (CollectionUtils.isNotEmpty(countryBeans)) {
			List<Country> countries = countryBeans.stream().map(c -> new Country(c)).collect(Collectors.toList());
			countryRepository.saveAll(countries);

		}
		logger.info("Return successfully from CountryService::importCountryCSVData()");
		return CSVFileImportResponse.builder().importResult(ImportResult.SUCCESS)
				.description("Successfully uploaded country data.").build();
	}

}
