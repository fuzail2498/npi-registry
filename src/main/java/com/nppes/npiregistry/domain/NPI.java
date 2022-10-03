package com.nppes.npiregistry.domain;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "npi_information")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class NPI {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected Long id;

	@Column(name = "number")
	private long npi;

	@OneToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "entity_type_code")
	private EntityTypeCode entityTypeCode;

	@OneToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "gender_code_id")
	private GenderCode gender;

	@OneToMany(mappedBy = "npi", cascade = CascadeType.ALL)
	private List<Address> address;

	@Column(name = "replacement_npi")
	private long replacementNpi;

	@Column(name = "employer_identification_number")
	private String employerIdentificationNumber;

	@Column(name = "organization_Name")
	private String providerOrganizationName;

	@Column(name = "first_name")
	private String providerFirstName;

	@Column(name = "last_name")
	private String providerLastName;

	@Column(name = "middle_name")
	private String providerMiddleName;

	@Column(name = "name_prefix_text")
	private String providerNamePrefixText;

	@Column(name = "name_suffix_text")
	private String providerNameSuffixText;

	@Column(name = "credential_ext")
	private String providerCredentialText;

	@Column(name = "certification_date")
	private LocalDate certificationDate;

	@Column(name = "deactivation_date")
	private LocalDate deactivationDate;

	@Column(name = "reactivation_date")
	private LocalDate reactivationDate;

	@Column(name = "last_updated_date")
	private LocalDate lastUpdatedDate;

	@Column(name = "enumeration_date")
	private LocalDate enumerationDate;

	@Column(name = "last_sync_date")
	private LocalDate lastSyncDate;
	
	@OneToMany(mappedBy = "npi", cascade = CascadeType.ALL)
	private List<Taxonomy> taxonomy;
}
