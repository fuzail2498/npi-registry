package com.nppes.npiregistry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.ProviderTaxonomyCode;
import com.nppes.npiregistry.repository.ProviderTaxonomyCodeRepository;

@Service
public class ProviderTaxonomyCodeService {

	@Autowired
	private ProviderTaxonomyCodeRepository proTaxonomyCodeRepository;

	public List<ProviderTaxonomyCode> getAllTaxonomyCode() {
		return proTaxonomyCodeRepository.findAll();
	}

}
