package com.nppes.npiregistry.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "provider_taxonomy_code")
public class ProviderTaxonomyCode {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String medicareSpecialityCode;
	private String medicareProviderOrSupplierTypeDescription;
	private String code;
	private String typeClassificationSpecialization;

}
