package com.nppes.npiregistry.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nppes.npiregistry.domain.ProviderTaxonomyCode;

@Repository
public interface ProviderTaxonomyCodeRepository extends JpaRepository<ProviderTaxonomyCode, Long> {

	List<ProviderTaxonomyCode> findByCode(String code);

}
