package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nppes.npiregistry.domain.PrimaryTaxonomy;

@Repository
public interface PrimaryTaxonomyRepository extends JpaRepository<PrimaryTaxonomy, Long> {

	PrimaryTaxonomy findBySwitchCode(String switchCode);

}
