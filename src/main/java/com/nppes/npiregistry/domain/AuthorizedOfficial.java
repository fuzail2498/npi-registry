package com.nppes.npiregistry.domain;

import javax.persistence.Embeddable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class AuthorizedOfficial {
	private String firstName;
	private String lastName;
	private String middleName;
	private String titleOrPosition;
	private String telephoneNumber;
	private String namePrefixText;
	private String nameSuffixText;
	private String credentialText;
}
