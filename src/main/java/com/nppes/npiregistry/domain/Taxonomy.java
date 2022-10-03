package com.nppes.npiregistry.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "taxonomy")
public class Taxonomy {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne
	@JoinColumn(name = "taxanomy_group_id")
	private GroupTaxonomy groupTaxonomy;

	@OneToOne
	@JoinColumn(name = "state_id")
	private State state;

	private String license;

	@OneToOne
	@JoinColumn(name = "primary_taxonomy_id")
	private PrimaryTaxonomy primaryTaxonomy;

	@OneToOne
	@JoinColumn(name = "taxonomy_code_id")
	private ProviderTaxonomyCode providerTaxonomyCode;
	
	@ManyToOne
	@JoinColumn(name="npi_id")
	private NPI npi;

}
