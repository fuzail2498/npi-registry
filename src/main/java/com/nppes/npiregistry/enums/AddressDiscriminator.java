package com.nppes.npiregistry.enums;

import com.nppes.npiregistry.exception.UnprocessableEntityException;

public enum AddressDiscriminator {
	ADDRESSES("ADDRESSES"), PRACTICE_LOCATIONS("ADDRESSES");

	private String addressDiscriminator;

	public String getAddressDiscriminator() {
		return addressDiscriminator;
	}

	private AddressDiscriminator(String addressDiscriminator) {
		this.addressDiscriminator = addressDiscriminator;
	}

	public static AddressDiscriminator getEnum(String addressDescriminator) {
		for (AddressDiscriminator adressDiscriminator : values()) {
			if (adressDiscriminator.getAddressDiscriminator().equalsIgnoreCase(addressDescriminator)) {
				return adressDiscriminator;
			}
		}
		throw new UnprocessableEntityException("Invalid Address purpose.");
	}

}
