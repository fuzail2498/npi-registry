package com.nppes.npiregistry.dto;

import java.util.Date;

import com.opencsv.bean.CsvBindByName;
import com.opencsv.bean.CsvDate;

import lombok.Data;

@Data
public class NPICSVImportDTO {

	@CsvBindByName(column = "NPI")
	private long number;

	@CsvBindByName(column = "Entity Type Code")
	private int entityTypeCode;

	@CsvBindByName(column = "Replacement NPI")
	private long replacementNPI;

	@CsvBindByName(column = "Employer Identification Number (EIN)")
	private String employerIdentificationNumber;

	@CsvBindByName(column = "Provider Organization Name (Legal Business Name)")
	private String providerOrganizationName;

	@CsvBindByName(column = "Provider Last Name (Legal Name)")
	private String providerLastName;

	@CsvBindByName(column = "Provider First Name")
	private String providerFirstName;

	@CsvBindByName(column = "Provider Middle Name")
	private String providerMiddleName;

	@CsvBindByName(column = "Provider Name Prefix Text")
	private String providerNamePrefixText;

	@CsvBindByName(column = "Provider Name Suffix Text")
	private String providerNameSuffixText;

	@CsvBindByName(column = "Provider Credential Text")
	private String providerCredentialText;

	@CsvBindByName(column = "Provider Other Organization Name")
	private String providerOtherOrganisationName;

	@CsvBindByName(column = "Provider Other Organization Name Type Code")
	private String providerOtherOrganizationNameTypeCode;

	@CsvBindByName(column = "Provider Other Last Name")
	private String providerOtherLastName;

	@CsvBindByName(column = "Provider Other First Name")
	private String providerOtherFirstName;

	@CsvBindByName(column = "Provider Other Middle Name")
	private String providerOtherMiddleName;

	@CsvBindByName(column = "Provider Other Name Prefix Text")
	private String providerOtherNamePrefixText;

	@CsvBindByName(column = "Provider Other Name Suffix Text")
	private String providerOtherNameSuffixText;

	@CsvBindByName(column = "Provider Other Credential Text")
	private String providerOtherCreddentialText;

	@CsvBindByName(column = "Provider Other Last Name Type Code")
	private String providerOtherLastNameTypeCode;

	@CsvBindByName(column = "Provider First Line Business Mailing Address")
	private String providerFirstLineBusinessMailingAddress;

	@CsvBindByName(column = "Provider Second Line Business Mailing Address")
	private String providerSecondLineBusinessMailingAddress;

	@CsvBindByName(column = "Provider Business Mailing Address City Name")
	private String providerBusinessMailingAddressCityName;

	@CsvBindByName(column = "Provider Business Mailing Address State Name")
	private String providerBusinessMailingAddressStateName;

	@CsvBindByName(column = "Provider Business Mailing Address Postal Code")
	private String providerBusinessMailingAddressPostalCode;

	@CsvBindByName(column = "Provider Business Mailing Address Country Code (If outside U.S.) ")
	private String providerBusinessMailingAddressCountryCode;

	@CsvBindByName(column = "Provider Business Mailing Address Telephone Number")
	private String providerBusinessMailingAddressTelephoneNumber;

	@CsvBindByName(column = "Provider Business Mailing Address Fax Number")
	private String providerBusinessMailingAddressFAxNumber;

	@CsvBindByName(column = "Provider First Line Business Practice Location Address")
	private String providerFirstLineBusinessPLAddress;

	@CsvBindByName(column = "Provider Second Line Business Practice Location Address")
	private String providerSecondLineBusinessPLAddress;

	@CsvBindByName(column = "Provider Business Practice Location Address City Name")
	private String providerBusinessPLAddressCityName;

	@CsvBindByName(column = "Provider Business Practice Location Address State Name")
	private String providerBusinessPLAddressStateName;

	@CsvBindByName(column = "Provider Business Practice Location Address Postal Code")
	private String providerBusinessPLAddressPostalCode;

	@CsvBindByName(column = "Provider Business Practice Location Address Country Code (If \r\n" + "outside U.S.)\r\n"
			+ "")
	private String providerBusinessPLAddressCountryCode;

	@CsvBindByName(column = "Provider Business Practice Location Address Telephone Number")
	private String providerBusinessPLAddressTelephoneNumber;

	@CsvBindByName(column = "Provider Business Practice Location Address Fax Number")
	private String providerBusinessPLAddressFaxNumber;

	@CsvBindByName(column = "Provider Enumeration Date")
	private String providerEnumerationDate;

	@CsvBindByName(column = "Last Update Date")
	private String lastUpdateDate;

	@CsvBindByName(column = "NPI Deactivation Reason Code ")
	private String npiDeactivationReasonCode;

	@CsvBindByName(column = "NPI Deactivation Date")
	private String npiDeactivationDate;

	@CsvBindByName(column = "NPI Reactivation Date")
	private String npiReactivationDate;

	@CsvBindByName(column = "Provider Gender Code")
	private String providerGenderCode;

	@CsvBindByName(column = "Certification Date")
	@CsvDate("MM.dd.yyyy")
	private Date certificationDate;

	public NPICSVImportDTO(long number, int entityTypeCode, long replacementNPI, String employerIdentificationNumber,
			String providerOrganizationName, String providerLastName, String providerFirstName,
			String providerMiddleName, String providerNamePrefixText, String providerNameSuffixText,
			String providerCredentialText, String providerOtherOrganisationName,
			String providerOtherOrganizationNameTypeCode, String providerOtherLastName, String providerOtherFirstName,
			String providerOtherMiddleName, String providerOtherNamePrefixText, String providerOtherNameSuffixText,
			String providerOtherCreddentialText, String providerOtherLastNameTypeCode) {
		this.number = number;
		this.entityTypeCode = entityTypeCode;
		this.replacementNPI = replacementNPI;
		this.employerIdentificationNumber = employerIdentificationNumber;
		this.providerOrganizationName = providerOrganizationName;
		this.providerLastName = providerLastName;
		this.providerFirstName = providerFirstName;
		this.providerMiddleName = providerMiddleName;
		this.providerNamePrefixText = providerNamePrefixText;
		this.providerNameSuffixText = providerNameSuffixText;
		this.providerCredentialText = providerCredentialText;
		this.providerOtherOrganisationName = providerOtherOrganisationName;
		this.providerOtherOrganizationNameTypeCode = providerOtherOrganizationNameTypeCode;
		this.providerOtherLastName = providerOtherLastName;
		this.providerOtherFirstName = providerOtherFirstName;
		this.providerOtherMiddleName = providerOtherMiddleName;
		this.providerOtherNamePrefixText = providerOtherNamePrefixText;
		this.providerOtherNameSuffixText = providerOtherNameSuffixText;
		this.providerOtherCreddentialText = providerOtherCreddentialText;
		this.providerOtherLastNameTypeCode = providerOtherLastNameTypeCode;
	}
	

}
