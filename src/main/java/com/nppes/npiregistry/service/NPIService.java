package com.nppes.npiregistry.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.csvreader.CsvReader;
import com.nppes.npiregistry.constants.NPIRegistryConstants;
import com.nppes.npiregistry.domain.Address;
import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.domain.GroupTaxonomy;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.domain.SearchItems;
import com.nppes.npiregistry.domain.SearchNPIData;
import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.domain.Taxonomy;
import com.nppes.npiregistry.dto.CSVFileImportResponse;
import com.nppes.npiregistry.dto.NPIDataDTO;
import com.nppes.npiregistry.enums.AddressDiscriminator;
import com.nppes.npiregistry.enums.AddressPurpose;
import com.nppes.npiregistry.enums.ImportResult;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.repository.GroupTaxonomyRepository;
import com.nppes.npiregistry.repository.NPIRepository;
import com.nppes.npiregistry.utils.CollectionPartitionCreator;

@Service
public class NPIService {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

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
			logger.error(
					"Inside NPISERVICE::importNPIRegistryCSVData() :: Please provide valid CSV file for NPI-REGISTRY");
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
			logger.error(
					"Inside NPISERVICE::importNPIRegistryCSVData() :: Invalid File extension,Only CSV file acceptable.");
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
			String employerIdentificationNumber = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_EMPLOYER_IDENTIFICATION_NUMBER);
			String providerOrganizationName = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_ORGANISATION_NAME);
			String providerGenderCode = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_GENDER_CODE);
			String providerLastName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_LAST_NAME);
			String providerFirstName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_FIRST_NAME);
			String providerMiddleName = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_MIDDLE_NAME);
			String providerNamePrefixText = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_NAME_PREFIX_TEXT);
			String providerNameSuffixText = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_NAME_SUFFIX_TEXT);
			String providerCredentialText = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_CREDENTIAL_TEXT);
			String nPIDeactivationDate = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI_DEACTIVATION_DATE);
			String npiReactivationDate = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI_REACTIVATION_DATE);
			String npiCertificationDate = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_CERTIFICATION_DATE);
			String providerEnumerationDate = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_ENUMERATION_DATE);
			String lastUpdatedDate = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_LAST_UPDATED_DATE);

			if (StringUtils.isBlank(npi)) {
				continue;
			}
			// This condition is used when npi is deactivated
			if (StringUtils.isBlank(lastUpdatedDate) && StringUtils.isNotBlank(npi)
					&& StringUtils.isNotBlank(nPIDeactivationDate)) {
				logger.info("Inside NPISERVICE::importNPIRegistryCSVData() :: Skipping deativated NPIs currently");
				// put logic what to with deactivated NPIs
				continue;
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
			if (StringUtils.isNotBlank(lastUpdatedDate)) {
				lastUpdatedDateObj = LocalDate.parse(lastUpdatedDate, formatter);
			}
			NPI npiFromRepo = npiRepository.findByNpi(Long.parseLong(npi));
			System.out.println(lineCountForCSVFile.get());
			if (npiFromRepo == null
					|| (npiFromRepo != null && lastUpdatedDateObj.isAfter(npiFromRepo.getLastUpdatedDate()))) {
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
				if (npiData.size() % 500000 == 0) {
					logger.info(
							"Inside NPISERVICE::importNPIRegistryCSVData() :: CSV file reached 10000 records need to process these data first and clean heap memory for further data processing");
					saveNPIrecords(npiData, multipartFile.getOriginalFilename());
					npiData.clear();
				}
				logger.info(
						"Inside NPISERVICE::importNPIRegistryCSVData() :: Successfully read CSV file row at line : {}",
						lineCountForCSVFile.get());
			}
		}
		if (CollectionUtils.isNotEmpty(npiData)) {
			saveNPIrecords(npiData, multipartFile.getOriginalFilename());
		}
		logger.info(
				"Return successfully from NPISERVICE::importNPIRegistryCSVData() ::  Successfully read file for NPI-Registry : {} and process {} record.",
				multipartFile.getOriginalFilename(), lineCountForCSVFile.get());
		return CSVFileImportResponse.builder().importResult(ImportResult.SUCCESS).totalRecord(lineCountForCSVFile.get())
				.description("Successfully uploaded npi-registry data.").build();
	}

	/**
	 * This method is used to read data from CSV file related to NPI-REGISTRY for
	 * secondary PL address associated data related to NPIs into DB
	 * 
	 * @param multipartFile
	 * @return CSVFileImportResponse
	 * @throws IOException
	 */
	public CSVFileImportResponse importNPIRegistryCSVDataForSecondaryPLAddress(MultipartFile multipartFile)
			throws IOException {
		logger.info(
				"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress():: Starting process for CSV loading");
		if (multipartFile == null || FilenameUtils.getExtension(multipartFile.getOriginalFilename()) == "") {
			logger.error(
					"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() :: Please provide valid CSV file for NPI-REGISTRY");
			throw new UnprocessableEntityException("Please provide a valid csv file.");
		}
		if (!FilenameUtils.getExtension(multipartFile.getOriginalFilename()).toUpperCase().equals("CSV")) {
			logger.error(
					"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() :: Invalid File extension,Only CSV file acceptable.");
			throw new UnprocessableEntityException("Invalid File extension,Only CSV file acceptable.");
		}

		List<NPI> npiData = new ArrayList<NPI>();
		Map<String, Country> countryData = masterDataService.getCountyMap();
		Map<String, State> stateData = masterDataService.getStateMap();
		CsvReader npiRecords = new CsvReader(multipartFile.getInputStream(), StandardCharsets.UTF_8);
		npiRecords.readHeaders();
		AtomicLong lineCountForCSVFile = new AtomicLong();
		while (npiRecords.readRecord()) {
			lineCountForCSVFile.getAndIncrement();
			logger.info(
					"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() :: Reading CSV file at line : {}",
					lineCountForCSVFile.get());
			String npi = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_NPI);
			String secondaryPLFirstLineAddress = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_FIRST_LINE_SECONDARY_PL_ADDRESS);
			String secondaryPLSecondLineAddress = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECOND_LINE_SECONDARY_PL_ADDRESS);
			String secondaryPLCityName = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_CITY_NAME);
			String secondaryPLStateName = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_STATE_NAME);
			String secondaryPLPostalCode = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_POSTAL_CODE);
			String secondaryPLCountryCode = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_COUNTRY_CODE);
			String secondaryPLTelephoneNumber = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_TELEPHONE_NUMBER);
			String secondaryPLTelephoneExtension = npiRecords.get(
					NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_TELEPHONE_EXTENSION);
			String secondaryPLFaxNumber = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECONDARY_PL_ADDRESS_FAX_NUMBER);

			NPI npiFromRepo = npiRepository.findByNpi(Long.parseLong(npi));
			if (npiFromRepo == null) {
				logger.error(
						"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() :: NPI not found in the inventory at line {}.",
						lineCountForCSVFile.get());
				throw new UnprocessableEntityException(
						"NPI not found in the inventory at line " + lineCountForCSVFile.get() + " for NPI " + npi);
			}

			Optional<Address> secondaryPLAddressFromRepo = Optional.empty();
			if (StringUtils.isNotBlank(secondaryPLFirstLineAddress)
					|| StringUtils.isNotBlank(secondaryPLSecondLineAddress)
					|| StringUtils.isNotBlank(secondaryPLCityName) || StringUtils.isNotBlank(secondaryPLStateName)
					|| StringUtils.isNotBlank(secondaryPLPostalCode) || StringUtils.isNotBlank(secondaryPLCountryCode)
					|| StringUtils.isNotBlank(secondaryPLTelephoneNumber)
					|| StringUtils.isNotBlank(secondaryPLTelephoneExtension)
					|| StringUtils.isNotBlank(secondaryPLFaxNumber)) {
				logger.info(
						"Inside NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() :: Creating address object for Secondary PL Address.");
				Country country = null;
				State state = null;
				if (StringUtils.isNotBlank(secondaryPLStateName)) {
					state = stateData.get(secondaryPLStateName);
				}
				if (StringUtils.isNotBlank(secondaryPLCountryCode)) {
					country = countryData.get(secondaryPLCountryCode);
				}
				if (npiFromRepo != null) {
					secondaryPLAddressFromRepo = npiFromRepo.getAddress().stream()
							.filter(a -> a.getAddressPurpose().equals(AddressPurpose.LOCATION)
									&& a.getAddressDiscriminator().equals(AddressDiscriminator.PRACTICE_LOCATIONS))
							.findAny();
				}
				Address secondaryPLAddress = new Address(
						secondaryPLAddressFromRepo.isPresent() ? secondaryPLAddressFromRepo.get().getId() : null,
						secondaryPLFirstLineAddress, secondaryPLSecondLineAddress, AddressPurpose.LOCATION,
						AddressDiscriminator.PRACTICE_LOCATIONS, secondaryPLCityName, secondaryPLPostalCode, country,
						state, secondaryPLTelephoneNumber, secondaryPLFaxNumber, secondaryPLTelephoneExtension, "DOM",
						false, npiFromRepo);
				npiFromRepo.setAddress(new ArrayList<>(Arrays.asList(secondaryPLAddress)));
				npiData.add(npiFromRepo);

			}
		}
		if (CollectionUtils.isNotEmpty(npiData)) {
			saveNPIrecords(npiData, multipartFile.getOriginalFilename());
		}
		logger.info(
				"Return successfully from NPISERVICE::importNPIRegistryCSVDataForSecondaryPLAddress() ::  Successfully read file for NPI-Registry : {} and process {} record.",
				multipartFile.getOriginalFilename(), lineCountForCSVFile.get());
		return CSVFileImportResponse.builder().importResult(ImportResult.SUCCESS).totalRecord(lineCountForCSVFile.get())
				.description("Successfully uploaded npi-registry secondary practice location data.").build();
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
			List<List<NPI>> npiBatches = CollectionPartitionCreator.ofSize(nPIS, 1000);
			for (List<NPI> npis : npiBatches) {
				executorService.submit(() -> {
					try {
						npiRepository.saveAll(npis);
					} catch (Exception e) {
						logger.error(
								"Inside NPISERVICE::importNPIRegistryCSVData() :: Error while saving NPIs batch : {} for file : {}",
								e.getMessage(), filename);
					}
				});
			}
		}
		logger.info("Return successfully from NPISERVICE::saveNPIrecords()");
	}

	public List<NPIDataDTO> getNPIData(SearchNPIData searchNPIData) {

		EntityManager entityManager = entityManagerFactory.createEntityManager();

		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<NPI> criteriaQuery = criteriaBuilder.createQuery(NPI.class);
		Root<NPI> root = criteriaQuery.from(NPI.class);

		List<SearchItems> searchItems = searchNPIData.getSearchItems();

		List<Predicate> predicates = new ArrayList<>();

		for (SearchItems item : searchItems) {
			if (ObjectUtils.isEmpty(item)) {
				continue;
			}
			if (item.getSearchKey().equalsIgnoreCase("npiNumber")) {
				Predicate preNpi = criteriaBuilder.equal(root.get("npi"), item.getSearchVal());
				predicates.add(preNpi);
			}
			if (item.getSearchKey().equalsIgnoreCase("firstName")) {
				Predicate preFirstName = criteriaBuilder.equal(root.get("providerFirstName"), item.getSearchVal());
				predicates.add(preFirstName);
			}
			if (item.getSearchKey().equalsIgnoreCase("lastName")) {
				Predicate preLastName = criteriaBuilder.equal(root.get("providerLastName"), item.getSearchVal());
				predicates.add(preLastName);
			}
			if (item.getSearchKey().equalsIgnoreCase("entityType")) {
				Join<Object, Object> typeJoin = root.join("entityTypeCode");
				Predicate preNpiType = criteriaBuilder.equal(typeJoin.get("description"), item.getSearchVal());
				predicates.add(preNpiType);
			}
			if (item.getSearchKey().equalsIgnoreCase("state") || item.getSearchKey().equalsIgnoreCase("postalCode")
					|| item.getSearchKey().equalsIgnoreCase("country")) {

				Join<Object, Object> addJoin = root.join("address");
				Join<Object, Object> stateJoin = addJoin.join("state");
				Join<Object, Object> countryJoin = addJoin.join("country");

				if (item.getSearchKey().equalsIgnoreCase("state")) {
					Predicate preState = criteriaBuilder.equal(stateJoin.get("name"), item.getSearchVal());
					predicates.add(preState);
				}
				if (item.getSearchKey().equalsIgnoreCase("postalCode")) {
					Predicate prePostalCode = criteriaBuilder.equal(addJoin.get("postalCode"), item.getSearchVal());
					predicates.add(prePostalCode);
				}
				if (item.getSearchKey().equalsIgnoreCase("country")) {
					Predicate preCountry = criteriaBuilder.equal(countryJoin.get("name"), item.getSearchVal());
					predicates.add(preCountry);
				}
			}

			criteriaQuery.select(root).where(criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()])));
//			criteriaQuery.orderBy(criteriaBuilder.desc(root.get("id")));
		}

		TypedQuery<NPI> query = entityManager.createQuery(criteriaQuery)
				.setFirstResult((searchNPIData.getOffset()) * searchNPIData.getPageSize())
				.setMaxResults(searchNPIData.getPageSize());
		List<NPI> list = query.getResultList();

		return list.stream().map(a -> new NPIDataDTO(a)).collect(Collectors.toList());
	}

}
