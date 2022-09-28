package com.nppes.npiregistry.domain;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.nppes.npiregistry.enums.AddressPurpose;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "address")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class Address{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected Long id;
	
	@Column(name = "address_line1")
	private String addressLine1;

	@Column(name = "address_line2")
	private String addressLine2;

	@Column(name = "address_purpose")
	@Enumerated(EnumType.STRING)
	private AddressPurpose addressPurpose;

	@Column(name = "city_name")
	private String cityName;

	@Column(name = "postal_code")
	private String postalCode;

	@OneToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "country_id")
	private Country country;

	@OneToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "state_id")
	private State state;

	@Column(name = "telephone_number")
	private String telephoneNumber;

	@Column(name = "fax_number")
	private String faxNumber;

	@Column(name = "telephone_extention")
	private String telephoneExtension;

	@Column(name = "address_type")
	private String addressType;

	@Column(name = "is_primary")
	private boolean isPrimary;
	
	@ManyToOne
	@JoinColumn(name = "npi_information_id")
	private NPI npi;

}
