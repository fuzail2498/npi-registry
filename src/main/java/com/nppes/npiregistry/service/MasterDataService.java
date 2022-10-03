package com.nppes.npiregistry.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.domain.PrimaryTaxonomy;
import com.nppes.npiregistry.domain.ProviderTaxonomyCode;
import com.nppes.npiregistry.domain.State;

@Service
public class MasterDataService {
	private StateService stateService;
	private CountryService countryService;
	private EntityTypeCodeService entityTypeCodeService;
	private GenderCodesService genderCodesService;
	private ProviderTaxonomyCodeService proTaxonomyCodeService;
	private PrimaryTaxonomyService priTaxonomyService;

	@Autowired
	public MasterDataService(StateService stateService, CountryService countryService,
			EntityTypeCodeService entityTypeCodeService, GenderCodesService genderCodesService,
			ProviderTaxonomyCodeService proTaxonomyCodeService, PrimaryTaxonomyService priTaxonomyService) {
		this.stateService = stateService;
		this.countryService = countryService;
		this.entityTypeCodeService = entityTypeCodeService;
		this.genderCodesService = genderCodesService;
		this.proTaxonomyCodeService = proTaxonomyCodeService;
		this.priTaxonomyService = priTaxonomyService;
	}

	private static Map<String, State> stateMap = new HashMap<>();
	private static Map<Integer, EntityTypeCode> entityTypeCodeMap = new HashMap<>();
	private static Map<String, GenderCode> genderCodesMap = new HashMap<>();
	private static Map<String, Country> countryMap = new HashMap<>();
	private static Map<String, ProviderTaxonomyCode> taxCodeMap = new HashMap<>();
	private static Map<String, PrimaryTaxonomy> primaryTaxSwitchMap = new HashMap<>();

	private final Logger logger = LoggerFactory.getLogger(MasterDataService.class);

	@PostConstruct
	private void setAllStatesToMap() {
		logger.info("Inside MasterDataService::setAllStatesToMap()");
		stateService.getAllState().forEach(state -> {
			stateMap.put(state.getReferenceCode(), state);
		});
		logger.info("Return successfully from MasterDataService::setAllStatesToMap()");
	}

	@PostConstruct
	private void setAllCountriesToMap() {
		logger.info("Inside MasterDataService::setAllCountriesToMap()");
		countryService.getAllCountry().forEach(country -> {
			countryMap.put(country.getCode(), country);
		});
		logger.info("Return successfully from MasterDataService::setAllCountriesToMap()");
	}

	@PostConstruct
	private void setAllEntityTypeCodeToMap() {
		logger.info("Inside MasterDataService::setAllEntityTypeCodeToMap()");
		entityTypeCodeService.getAllEntityTypeCodes().forEach(entityTypeCode -> {
			entityTypeCodeMap.put(entityTypeCode.getCode(), entityTypeCode);
		});
		logger.info("Return successfully from MasterDataService::setAllEntityTypeCodeToMap()");
	}

	@PostConstruct
	private void setAllGenderCodeToMap() {
		logger.info("Inside MasterDataService::setAllGenderCodeToMap()");
		genderCodesService.getALLGenderCodes().forEach(genderCode -> {
			genderCodesMap.put(genderCode.getCode(), genderCode);
		});
		logger.info("Return successfully from MasterDataService::setAllGenderCodeToMap()");
	}
	
	@PostConstruct
	public void setAllTaxonomyCode() {
		List<ProviderTaxonomyCode> taxonomyCodeDB = proTaxonomyCodeService.getAllTaxonomyCode();
		taxonomyCodeDB.forEach(taxonomyCode -> {
			taxCodeMap.put(taxonomyCode.getCode(), taxonomyCode);
		});
	}

	@PostConstruct
	public void setAllPrimaryTaxonomy() {
		List<PrimaryTaxonomy> primaryTaxonomyDB = priTaxonomyService.getAllPrimaryTaxonomy();
		primaryTaxonomyDB.forEach(priTaxonomy -> {
			primaryTaxSwitchMap.put(priTaxonomy.getSwitchCode(), priTaxonomy);
		});
	}

	public Map<String, Country> getCountyMap() {
		return countryMap;
	}

	public Map<String, State> getStateMap() {
		return stateMap;
	}

	public Map<Integer, EntityTypeCode> getEntityTypeCodeMap() {
		return entityTypeCodeMap;
	}

	public Map<String, GenderCode> getGenderCodeMap() {
		return genderCodesMap;
	}
	
	public Map<String, ProviderTaxonomyCode> getTaxonomyCodeMap() {
		return taxCodeMap;
	}

	public Map<String, PrimaryTaxonomy> getPrimaryTaxonomyMap() {
		return primaryTaxSwitchMap;
	}

}
