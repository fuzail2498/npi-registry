package com.nppes.npiregistry.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.csvreader.CsvReader;
import com.nppes.npiregistry.constants.NPIRegistryConstants;
import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.GenderCodeRepository;
import com.nppes.npiregistry.repository.NPIRepository;
import com.nppes.npiregistry.utils.CollectionPartitionCreator;

@Service
public class NPIService {

	private NPIRepository npiRepository; 
	private EntityTypeCodeService entityTypeCodeService;
	private GenderCodeRepository genderCodeRepository;
	
	@Autowired
	public NPIService(NPIRepository npiRepository, EntityTypeCodeService entityTypeCodeService,
			GenderCodeRepository genderCodeRepository) {
		this.npiRepository = npiRepository;
		this.entityTypeCodeService = entityTypeCodeService;
		this.genderCodeRepository = genderCodeRepository;
	}

	public String importNPIRegistryCSVData(MultipartFile multipartFile) throws IOException {
		if (multipartFile == null || FilenameUtils.getExtension(multipartFile.getOriginalFilename()) == "") {
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
			throw new UnprocessableEntityException("Invalid File extension,Only CSV file acceptable.");
		}
		
		List<NPI> npiData = new ArrayList<NPI>();
		ExecutorService executorService = Executors.newFixedThreadPool(50);
		CsvReader npiRecords = new CsvReader(multipartFile.getInputStream(), StandardCharsets.UTF_8);
		List<GenderCode> genderCodes = genderCodeRepository.findAll();
		List<EntityTypeCode> entityTypeCodes = entityTypeCodeService.getAllEntityTypeCodes();
		npiRecords.readHeaders();
		while (npiRecords.readRecord()) {
			EntityTypeCode entityTypeCodeobj = null;
			GenderCode genderCodeObj = null;
			LocalDate nPIDeactivationDateObj = null;
			LocalDate npiReactivationDateObj = null;
			LocalDate npiCertificationDateObj = null;
			LocalDate providerEnumerationDateObj = null;
			LocalDate lastUpdatedDateObj = null;
			String npi = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI);
			String entityTypeCode = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_ENTITY_TYPE_CODE);
			String replacementNPI = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_REPLACEMENT_NPI);
			String employerIdentificationNumber = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_EMPLOYER_IDENTIFICATION_NUMBER);
			String providerOrganizationName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_ORGANISATION_NAME);
			String providerGenderCode = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_GENDER_CODE);
			String providerLastName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_LAST_NAME);
			String providerFirstName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_FIRST_NAME);
			String providerMiddleName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_MIDDLE_NAME);
			String providerNamePrefixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_NAME_PREFIX_TEXT);
			String providerNameSuffixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_NAME_SUFFIX_TEXT);
			String providerCredentialText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_CREDENTIAL_TEXT);
			String providerOtherOrganisationName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_ORGANIZATION_NAME);
			String providerOtherOrganizationNameTypeCode = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_LAST_NAME_TYPE_CODE);
			String providerOtherLastName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_LAST_NAME);
			String providerOtherFirstName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_FIRST_NAME);
			String providerOtherMiddleName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_MIDDLE_NAME);
			String providerOtherNamePrefixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_NAME_PREFIX_TEXT);
			String providerOtherNameSuffixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_NAME_SUFFIX_TEXT);
			String providerOtherCreddentialText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_CREDENTIAL_TEXT);
			String providerOtherLastNameTypeCode = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_OTHER_LAST_NAME_TYPE_CODE);
			String nPIDeactivationReasonCode = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI_DEACTIVATION_REASON_CODE);
			String nPIDeactivationDate =  npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI_DEACTIVATION_DATE);
			String npiReactivationDate =  npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI_REACTIVATION_DATE);
			String npiCertificationDate =  npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_CERTIFICATION_DATE);
			String providerEnumerationDate =  npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_ENUMERATION_DATE);
			String lastUpdatedDate = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_LAST_UPDATED_DATE);
			
			if (StringUtils.isBlank(npi)) {
				continue;
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
			if (StringUtils.isNotBlank(lastUpdatedDate)) {
				lastUpdatedDateObj = LocalDate.parse(lastUpdatedDate, formatter);
			}
			NPI npiFromRepo = npiRepository.findByNpi(Long.parseLong(npi));
			if (npiFromRepo == null || (npiFromRepo != null && lastUpdatedDateObj.isAfter(npiFromRepo.getLastUpdatedDate()))) {
				NPI nPI = new NPI();
				if (npiFromRepo != null) {
					nPI.setId(npiFromRepo.getId());
				}
				if (StringUtils.isNotBlank(entityTypeCode)) {
					if (entityTypeCode.trim().equalsIgnoreCase("1")) {
						entityTypeCodeobj = entityTypeCodes.get(0);
					} else if (entityTypeCode.trim().equalsIgnoreCase("2")) {
						entityTypeCodeobj = entityTypeCodes.get(1);
					}
				}
				if (StringUtils.isNotBlank(providerGenderCode)) {
					if (providerGenderCode.trim().equalsIgnoreCase("M")) {
						genderCodeObj = genderCodes.get(0);
					} else if (providerGenderCode.trim().equalsIgnoreCase("F")) {
						genderCodeObj = genderCodes.get(1);
					}
				}
				if (StringUtils.isNotBlank(npiCertificationDate)) {
					npiCertificationDateObj = LocalDate.parse(npiCertificationDate, formatter);
				}
				if (StringUtils.isNotBlank(npiReactivationDate)) {
					npiReactivationDateObj = LocalDate.parse(npiReactivationDate, formatter);
				}
				if (StringUtils.isNotBlank(nPIDeactivationDate)) {
					nPIDeactivationDateObj = LocalDate.parse(nPIDeactivationDate, formatter);
				}

				nPI = new NPI(StringUtils.isBlank(npi) ? 0 : Long.parseLong(npi), entityTypeCodeobj, genderCodeObj,
						null, StringUtils.isBlank(replacementNPI) ? 0 : Long.parseLong(replacementNPI),
						employerIdentificationNumber, providerOrganizationName, providerFirstName, providerLastName,
						providerMiddleName, providerNamePrefixText, providerNameSuffixText, providerCredentialText,
						npiCertificationDateObj, nPIDeactivationDateObj, npiReactivationDateObj, lastUpdatedDateObj,
						providerEnumerationDateObj, LocalDate.now());
				npiData.add(nPI);
			}
		}
//		For trial :: use remove after testing 
		for(NPI n : npiData) {
			npiRepository.save(n);
		}
//		List<List<NPI>> batchs = CollectionPartitionCreator.ofSize(npiData, 100);
//
//		for (List<NPI> npis : batchs) {
//			executorService.submit(() -> {
//				try {
//					npiRepository.saveAll(npis);
//				} catch (Exception e) {
//					System.out.println("Error while inserting npanxx data : " + e);
//				}
//			});
//		}
//		executorService.shutdown();
		npiData.forEach(System.out::println);
		return "Successfully uploaded data";
	}

}
