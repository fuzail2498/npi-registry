package com.nppes.npiregistry.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csvreader.CsvReader;
import com.nppes.npiregistry.constants.NPIRegistryConstants;
import com.nppes.npiregistry.domain.Address;
import com.nppes.npiregistry.domain.Country;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.enums.AddressPurpose;
import com.nppes.npiregistry.repository.CountryRepository;
import com.nppes.npiregistry.repository.StateRepository;

@Service
public class AddressService {
	StateService stateService;
	CountryService countryService;
	
	@Autowired
	public AddressService(StateService stateService, CountryService countryService) {
		this.stateService = stateService;
		this.countryService = countryService;
	}


	/**
	 * This method take csv reader object and process the address associated to
	 * particular NPIs and return list of addresses
	 * 
	 * @param npiRecords
	 * @param nPI
	 * @return addresses
	 * @throws IOException
	 */
	public List<Address> saveOrUpdateAdressesForNPIs(CsvReader npiRecords, NPI nPI) throws IOException {
		//HEADERS FOR BUSINESS MAILING ADDRESS
		String providerFirstLineBusinessMailingAddress = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_FIRST_LINE_BUSINESS_MAILING_ADDRESS);
		String providerSecondLineBusinessMailingAddress = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECOND_LINE_BUSINESS_MAILING_ADDRESS);
		String providerBusinessMailingAddressCityName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_CITY_NAME);
		String providerBusinessMailingAddressStateName= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_STATE_NAME);
		String providerBusinessMailingAddressPostalCode= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_POSTAL_CODE);
		String providerBusinessMailingAddressCountryCode= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_COUNTRY_CODE);
		String providerBusinessMailingAddressTelephoneNumber= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_TELEPHONE_NUMBER);
		String providerBusinessMailingAddressFaxNumber= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_MAILING_ADDRESS_FAX_NUMBER);
		//HEADERS FOR BUSINESS PRACTICE LOCATON ADDRESS
		String providerFirstLineBusinessPLAddress = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_FIRST_LINE_BUSINESS_PL_ADDRESS);
		String providerSecondLineBusinessPLAddress = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_SECOND_LINE_BUSINESS_PL_ADDRESS);
		String providerBusinessPLAddressCityName = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_CITY_NAME);
		String providerBusinessPLAddressStateName= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_STATE_NAME);
		String providerBusinessPLAddressPostalCode= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_POSTAL_CODE);
		String providerBusinessPLAddressCountryCode= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_COUNTRY_CODE);
		String providerBusinessPLAddressTelephoneNumber= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_TELEPHONE_NUMBER);
		String providerBusinessPLAddressFaxNumber= npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_BUSINESS_PL_ADDRESS_FAX_NUMBER);
		
		List<Address> addresses = new ArrayList<>();

		if (StringUtils.isNotBlank(providerFirstLineBusinessMailingAddress)
				|| StringUtils.isNotBlank(providerSecondLineBusinessMailingAddress)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressCityName)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressStateName)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressPostalCode)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressCountryCode)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressTelephoneNumber)
				|| StringUtils.isNotBlank(providerBusinessMailingAddressFaxNumber)) {
			Country country = null;
			State state = null;
			if (StringUtils.isNotBlank(providerBusinessMailingAddressStateName)) {
				state = stateService.getStateByReferenceCode(providerBusinessMailingAddressStateName);
			}
			if (StringUtils.isNotBlank(providerBusinessMailingAddressCountryCode)) {
				country = countryService.getCountryByCode(providerBusinessMailingAddressCountryCode);
			}
			Address businessMailingAddress = new Address(null, providerFirstLineBusinessMailingAddress,
					providerSecondLineBusinessMailingAddress, AddressPurpose.MAILING,
					providerBusinessMailingAddressCityName, providerBusinessMailingAddressPostalCode, country, state,
					providerBusinessMailingAddressTelephoneNumber, providerBusinessMailingAddressFaxNumber, "", "DOM",
					false, nPI);
			addresses.add(businessMailingAddress);
		}

		if (StringUtils.isNotBlank(providerFirstLineBusinessPLAddress)
				|| StringUtils.isNotBlank(providerSecondLineBusinessPLAddress)
				|| StringUtils.isNotBlank(providerBusinessPLAddressCityName)
				|| StringUtils.isNotBlank(providerBusinessPLAddressStateName)
				|| StringUtils.isNotBlank(providerBusinessPLAddressPostalCode)
				|| StringUtils.isNotBlank(providerBusinessPLAddressCountryCode)
				|| StringUtils.isNotBlank(providerBusinessPLAddressTelephoneNumber)
				|| StringUtils.isNotBlank(providerBusinessPLAddressFaxNumber)) {
			Country country = null;
			State state = null;
			if (StringUtils.isNotBlank(providerBusinessPLAddressStateName)) {
				state = stateService.getStateByReferenceCode(providerBusinessPLAddressStateName);
			}
			if (StringUtils.isNotBlank(providerBusinessPLAddressCountryCode)) {
				country = countryService.getCountryByCode(providerBusinessPLAddressCountryCode);
			}
			Address businessPLAddress = new Address(null, providerFirstLineBusinessPLAddress,
					providerSecondLineBusinessPLAddress, AddressPurpose.LOCATION, providerBusinessPLAddressCityName,
					providerBusinessPLAddressPostalCode, country, state, providerBusinessPLAddressTelephoneNumber,
					providerBusinessPLAddressFaxNumber, "", "DOM", false, nPI);
			addresses.add(businessPLAddress);

		}
		
		return addresses;
		
	}

}
