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
import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.domain.GroupTaxonomy;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.domain.Taxonomy;
import com.nppes.npiregistry.dto.CSVFileImportResponse;
import com.nppes.npiregistry.enums.ImportResult;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.GroupTaxonomyRepository;
import com.nppes.npiregistry.repository.NPIRepository;

@Service
public class NPIService {

	private NPIRepository npiRepository; 
	private AddressService addressService;
	private MasterDataService masterDataService;
	private TaxonomyService taxonomyService;
	private GroupTaxonomyRepository groupTaxonomyRepository;
	private final Logger logger = LoggerFactory.getLogger(NPIService.class);
	ExecutorService executorService = Executors.newFixedThreadPool(50);
	
	@Autowired
	public NPIService(NPIRepository npiRepository, AddressService addressService, MasterDataService masterDataService,
			TaxonomyService taxonomyService, GroupTaxonomyRepository groupTaxonomyRepository) {
		this.npiRepository = npiRepository;
		this.addressService = addressService;
		this.masterDataService = masterDataService;
		this.taxonomyService = taxonomyService;
		this.groupTaxonomyRepository = groupTaxonomyRepository;
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
		CsvReader npiRecords = new CsvReader(multipartFile.getInputStream(), StandardCharsets.UTF_8);
		Map<String, GenderCode> genderCodeMap = masterDataService.getGenderCodeMap();
		Map<Integer, EntityTypeCode> entityTypeCodeMap = masterDataService.getEntityTypeCodeMap();
		Map<String, Country> countryData = masterDataService.getCountyMap();
		Map<String, State> stateData = masterDataService.getStateMap();
		List<GroupTaxonomy> groupTaxonomies = groupTaxonomyRepository.findAll();
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
				if (StringUtils.isNotBlank(providerEnumerationDate)) {
					providerEnumerationDateObj = LocalDate.parse(providerEnumerationDate, formatter);
				}
				
				NPI nPI = new NPI(npiFromRepo != null ? npiFromRepo.getId() : null,
						StringUtils.isBlank(npi) ? 0 : Long.parseLong(npi), entityTypeCodeobj, genderCodeObj, null,
						StringUtils.isBlank(replacementNPI) ? 0 : Long.parseLong(replacementNPI),
						employerIdentificationNumber, providerOrganizationName, providerFirstName, providerLastName,
						providerMiddleName, providerNamePrefixText, providerNameSuffixText, providerCredentialText,
						npiCertificationDateObj, nPIDeactivationDateObj, npiReactivationDateObj, lastUpdatedDateObj,
						providerEnumerationDateObj, LocalDate.now(), null);
				List<Address> adressesForNPI = addressService.saveOrUpdateAdressesForNPIs(npiRecords, nPI, npiFromRepo,
						countryData, stateData);
				nPI.setAddress(adressesForNPI);
				List<Taxonomy> taxonomyForNPI = taxonomyService.importTaxonomyDataFromCSV(npiRecords, nPI, npiFromRepo,
						stateData, groupTaxonomies);
				nPI.setTaxonomy(taxonomyForNPI);
				npiData.add(nPI);
				if (npiData.size() % 10000 == 0) {
					logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: CSV file reached 10000 records need to process these data first and clean heap memory for further data processing");
					saveNPIrecords(new ArrayList<>(npiData), multipartFile.getOriginalFilename());
					npiData.clear();
				}
				System.out.println(npiData.size());
				logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Successfully read CSV file row at line : {}",
						lineCountForCSVFile.get());
			}
		}
		if (CollectionUtils.isNotEmpty(npiData)) {
			saveNPIrecords(npiData, multipartFile.getOriginalFilename());
		}
		logger.info("Return successfully from NPISERVICE::importNPIRegistryCSVData() ::  Successfully read file for NPI-Registry : {} and process {} record.",
				multipartFile.getOriginalFilename(), lineCountForCSVFile.get());
		return CSVFileImportResponse.builder().importResult(ImportResult.SUCCESS).totalRecord(lineCountForCSVFile.get())
				.description("Successfully uploaded npi-registry data.").build();
	}
	
	/**
	 * This method is used to save NPI records in batches.
	 * 
	 * @param nPIS
	 * @param filename
	 */
	public void saveNPIrecords(List<NPI> nPIS, String filename) {
		logger.info("Inside NPISERVICE::saveNPIrecords()");
		if (CollectionUtils.isNotEmpty(nPIS)) {
			List<List<NPI>> npiBatches = ListUtils.partition(nPIS, 1000);
			for (List<NPI> npis : npiBatches) {
				executorService.submit(() -> {
					try {
						npiRepository.saveAll(npis);
					} catch (Exception e) {
						logger.error("Inside NPISERVICE::importNPIRegistryCSVData() :: Error while saving NPIs batch : {} for file : {}",
								e.getMessage(), filename);
					}
				});
			}
		}
		logger.info("Return successfully from NPISERVICE::saveNPIrecords()");
	}

}
