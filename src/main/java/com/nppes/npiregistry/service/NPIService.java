package com.nppes.npiregistry.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicLong;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections4.ListUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.csvreader.CsvReader;
import com.nppes.npiregistry.constants.NPIRegistryConstants;
import com.nppes.npiregistry.domain.Address;
import com.nppes.npiregistry.domain.AuthorizedOfficial;
import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.dto.CSVFileImportResponse;
import com.nppes.npiregistry.enums.ImportResult;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.GenderCodeRepository;
import com.nppes.npiregistry.repository.NPIRepository;

@Service
public class NPIService {

	private NPIRepository npiRepository; 
	private EntityTypeCodeService entityTypeCodeService;
	private GenderCodeRepository genderCodeRepository;
	private AddressService addressService;
	private MasterDataService masterDataService;
	private final Logger logger = LoggerFactory.getLogger(NPIService.class);
	
	@Autowired
	public NPIService(NPIRepository npiRepository, EntityTypeCodeService entityTypeCodeService,
			GenderCodeRepository genderCodeRepository, AddressService addressService, MasterDataService masterDataService) {
		this.npiRepository = npiRepository;
		this.entityTypeCodeService = entityTypeCodeService;
		this.genderCodeRepository = genderCodeRepository;
		this.addressService = addressService;
		this.masterDataService = masterDataService;
	}

	/**
	 * This method is used to read data from CSV file related to NPI-REGISTRY and
	 * associated data related to NPIs into DB
	 * 
	 * @param multipartFile
	 * @return CSVFileImportResponse
	 * @throws IOException
	 */
	public CSVFileImportResponse importNPIRegistryCSVData(MultipartFile multipartFile) throws IOException {
		logger.info("Inside NPISERVICE::importNPIRegistryCSVData():: Starting process for CSV loading");
		if (multipartFile == null || FilenameUtils.getExtension(multipartFile.getOriginalFilename()) == "") {
			logger.error("Inside NPISERVICE::importNPIRegistryCSVData() :: Please provide valid CSV file for NPI-REGISTRY");
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
			logger.error("Inside NPISERVICE::importNPIRegistryCSVData() :: Invalid File extension,Only CSV file acceptable.");
			throw new UnprocessableEntityException("Invalid File extension,Only CSV file acceptable.");
		}
		
		List<NPI> npiData = new ArrayList<NPI>();
		ExecutorService executorService = Executors.newFixedThreadPool(50);
		CsvReader npiRecords = new CsvReader(multipartFile.getInputStream(), StandardCharsets.UTF_8);
		Map<String, GenderCode> genderCodeMap = masterDataService.getGenderCodeMap();
		Map<Integer, EntityTypeCode> entityTypeCodeMap = masterDataService.getEntityTypeCodeMap();
		Map<String, Country> countryData = masterDataService.getCountyMap();
		Map<String, State> stateData = masterDataService.getStateMap();
		npiRecords.readHeaders();
		AtomicLong lineCountForCSVFile = new AtomicLong();
		while (npiRecords.readRecord()) {
			lineCountForCSVFile.getAndIncrement();
			logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Reading CSV file at line : {}",
					lineCountForCSVFile.get());
			EntityTypeCode entityTypeCodeobj = null;
			GenderCode genderCodeObj = null;
			LocalDate nPIDeactivationDateObj = null;
			LocalDate npiReactivationDateObj = null;
			LocalDate npiCertificationDateObj = null;
			LocalDate providerEnumerationDateObj = null;
			LocalDate lastUpdatedDateObj = null;
			AuthorizedOfficial authorizedOfficial = null;
			boolean isSoleProprieterObj = false;
			boolean isOrganizationSubpartObj = false;
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
			String isSoleProprieter = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_IS_SOLE_PROPRIETER);
			String isOrganizationSubpart = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_IS_ORGANIZATION_SUBPART);
			String parentOrganizationLBN = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PARENT_ORGANIZATION_LBN);
			String parentOrganizationTIN = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PARENT_ORGANIZATION_TIN);
			// AUTHORIZED OFFICIAL HEADERS
			String authorizeOfficialFirstName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_FIRST_NAME);
			String authorizeOfficialLastName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_LAST_NAME);
			String authorizedOfficialMiddleName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_MIDDLE_NAME);
			String authorizedOfficialTitleOrPosition = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_TITLE_OR_POSITION);
			String authorizedOfficialTelephoneNumber = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_TELEPHONE_NUMBER);
			String authorizedOfficialNamePrefixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_NAME_PREFIX_TEXT);
			String authorizedOfficialNameSuffixText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_NAME_SUFFIX_TEXT);
			String authorizedOfficialCredentialText = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_AUTHORIZED_OFFICIAL_CREDENTIAL_TEXT);
			
			if (StringUtils.isBlank(npi)) {
				continue;
			}
			//This condition is used when npi is deactivated
			if (StringUtils.isBlank(lastUpdatedDate) && StringUtils.isNotBlank(npi) && StringUtils.isNotBlank(nPIDeactivationDate)) {
				logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Skipping deativated NPIs currently");
				//put logic what to with deactivated NPIs
				continue;
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
			if (StringUtils.isNotBlank(lastUpdatedDate)) {
				lastUpdatedDateObj = LocalDate.parse(lastUpdatedDate, formatter);
			}
			NPI npiFromRepo = npiRepository.findByNpi(Long.parseLong(npi));
			if (npiFromRepo == null || (npiFromRepo != null && lastUpdatedDateObj.isAfter(npiFromRepo.getLastUpdatedDate()))) {
				
				if (StringUtils.isNotBlank(entityTypeCode)) {
					entityTypeCodeobj = entityTypeCodeMap.get(Integer.parseInt(entityTypeCode.trim()));
				}
				if (StringUtils.isNotBlank(providerGenderCode)) {
					genderCodeObj = genderCodeMap.get(providerGenderCode.trim());
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
				if (StringUtils.isNotBlank(isSoleProprieter)) {
					isSoleProprieterObj = isSoleProprieter.equalsIgnoreCase("Y") ? true : false;
				}
				if (StringUtils.isNotBlank(isOrganizationSubpart)) {
					isOrganizationSubpartObj = isOrganizationSubpart.equalsIgnoreCase("Y") ? true : false;
				}
				
				if (StringUtils.isNotBlank(authorizeOfficialFirstName)
						|| StringUtils.isNotBlank(authorizeOfficialLastName)
						|| StringUtils.isNotBlank(authorizedOfficialMiddleName)
						|| StringUtils.isNotBlank(authorizedOfficialTitleOrPosition)
						|| StringUtils.isNotBlank(authorizedOfficialTelephoneNumber)
						|| StringUtils.isNotBlank(authorizedOfficialNamePrefixText)
						|| StringUtils.isNotBlank(authorizedOfficialNameSuffixText)
						|| StringUtils.isNotBlank(authorizedOfficialCredentialText)) {
					authorizedOfficial = new AuthorizedOfficial(authorizeOfficialFirstName, authorizeOfficialLastName,
							authorizedOfficialMiddleName, authorizedOfficialTitleOrPosition,
							authorizedOfficialTelephoneNumber, authorizedOfficialNamePrefixText,
							authorizedOfficialNameSuffixText, authorizedOfficialCredentialText);

				}

				NPI nPI = new NPI(npiFromRepo != null ? npiFromRepo.getId() : null,
						StringUtils.isBlank(npi) ? 0 : Long.parseLong(npi), entityTypeCodeobj, genderCodeObj, null,
						StringUtils.isBlank(replacementNPI) ? 0 : Long.parseLong(replacementNPI),
						employerIdentificationNumber, providerOrganizationName, providerFirstName, providerLastName,
						providerMiddleName, providerNamePrefixText, providerNameSuffixText, providerCredentialText,
						npiCertificationDateObj, nPIDeactivationDateObj, npiReactivationDateObj, lastUpdatedDateObj,
						providerEnumerationDateObj, LocalDate.now(), authorizedOfficial, isSoleProprieterObj,
						isOrganizationSubpartObj, parentOrganizationLBN, parentOrganizationTIN);
				List<Address> adressesForNPI = addressService.saveOrUpdateAdressesForNPIs(npiRecords, nPI, npiFromRepo,
						countryData, stateData);
				nPI.setAddress(adressesForNPI);
				npiData.add(nPI);
				logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Successfully read CSV file row at line : {}",
						lineCountForCSVFile.get());
			}
		}
//		For trial :: use remove after testing 
//		for(NPI n : npiData) {
//			npiRepository.save(n);
//		}
		if (CollectionUtils.isNotEmpty(npiData)) {
			List<List<NPI>> npiBatches = ListUtils.partition(npiData, 100);
			for (List<NPI> npis : npiBatches) {
				executorService.submit(() -> {
					try {
						npiRepository.saveAll(npis);
					} catch (Exception e) {
						logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Error while saving NPIs batch : {} for file : {}",
								e.getMessage(), multipartFile.getOriginalFilename());
					}
				});
			}
		}
		logger.info("Return successfully from NPISERVICE::importNPIRegistryCSVData() ::  Successfully read file for NPI-Registry : {} and process {} record.",
				multipartFile.getOriginalFilename(), lineCountForCSVFile.get());
		return CSVFileImportResponse.builder().importResult(ImportResult.SUCCESS).totalRecord(lineCountForCSVFile.get())
				.description("Successfully uploaded npi-registry data.").build();
	}

}
