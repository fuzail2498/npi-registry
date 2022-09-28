package com.nppes.npiregistry.domain;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nppes.npiregistry.repository.CountryRepository;
import com.nppes.npiregistry.repository.StateRepository;

@Component
public class MasterDataService {

	private CountryRepository countryRepository;
	private StateRepository stateRepository;

	@Autowired
	public MasterDataService(CountryRepository countryRepository, StateRepository stateRepository) {
		this.countryRepository = countryRepository;
		this.stateRepository = stateRepository;
	}

	/**
	 * This method is used to get the country data into map.
	 * 
	 * @return
	 */
	public Map<String, Map<String, Country>> getCountryData() {
		Map<String, Map<String, Country>> countryMap = new HashMap<String, Map<String, Country>>();
		Map<String, Country> countries = new HashMap<String, Country>();
		countryRepository.findAll().forEach(country -> {
			countries.put(country.getCode(), country);
		});
		countryMap.put("countryData", countries);
		return countryMap;

	}

	/**
	 * This method is used to get the state data into map.
	 * 
	 * @return
	 */
	public Map<String, Map<String, State>> getStateData() {
		Map<String, Map<String, State>> countryMap = new HashMap<String, Map<String, State>>();
		Map<String, State> states = new HashMap<String, State>();
		stateRepository.findAll().forEach(state -> {
			states.put(state.getReferenceCode(), state);
		});
		countryMap.put("stateData", states);
		return countryMap;

	}

}
