package com.nppes.npiregistry.enums;

import com.nppes.npiregistry.exception.UnprocessableEntityException;

public enum AddressPurpose {
	LOCATION("LOCATION"), MAILING("MAILING");

	private String addresspurpose;

	public String getAddresspurpose() {
		return addresspurpose;
	}

	private AddressPurpose(String addresspurpose) {
		this.addresspurpose = addresspurpose;
	}

	public static AddressPurpose getEnum(String addressPurpose) {
		for (AddressPurpose purpose : values()) {
			if (purpose.getAddresspurpose().equalsIgnoreCase(addressPurpose)) {
				return purpose;
			}
		}
		throw new UnprocessableEntityException("Invalid Order Status.");
	}

}
