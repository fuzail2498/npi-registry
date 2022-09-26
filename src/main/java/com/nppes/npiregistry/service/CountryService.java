package com.nppes.npiregistry.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.dto.CountryCSVImportDTO;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.CountryRepository;
import com.opencsv.bean.CsvToBeanBuilder;

@Service
public class CountryService {
	
	@Autowired
	private CountryRepository countryRepository;

	/**
	 * This method is used to import the country data from the csv file.
	 * 
	 * @param multipartFile
	 * @return String
	 */
	public String importCountryCSVData(MultipartFile multipartFile) throws IOException {
		if (multipartFile == null || FilenameUtils.getExtension(multipartFile.getOriginalFilename()) == "") {
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
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
		return "Successfully added country data.";
	}

}
