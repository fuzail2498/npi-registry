package com.nppes.npiregistry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.PrimaryTaxonomy;
import com.nppes.npiregistry.repository.PrimaryTaxonomyRepository;

@Service
public class PrimaryTaxonomyService {

	@Autowired
	private PrimaryTaxonomyRepository priTaxonomyRepository;

	public List<PrimaryTaxonomy> getAllPrimaryTaxonomy() {
		return priTaxonomyRepository.findAll();
	}

}
