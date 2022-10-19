package com.nppes.npiregistry.dto;

import java.util.List;

import com.nppes.npiregistry.domain.Address;
import com.nppes.npiregistry.domain.NPI;

import lombok.Data;

@Data
public class NPIDataDTO {

	private long npiNumber;
	private String firstName;
	private String lastName;
	private String providerCredentialText;
	private String entityType;
	private String state;
	private String postalCode;

	public NPIDataDTO(NPI npi) {
		this.npiNumber = npi.getNpi();
		this.firstName = npi.getProviderFirstName();
		this.lastName = npi.getProviderLastName();
		this.providerCredentialText = npi.getProviderCredentialText();
		this.entityType = npi.getEntityTypeCode().getDescription();
		List<Address> address = npi.getAddress();
		for (Address address2 : address) {
			this.state = address2.getState().getName();
			this.postalCode = address2.getPostalCode();
		}
	}

}
