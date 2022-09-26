package com.nppes.npiregistry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.repository.EntityTypeCodeRepository;

@Service
public class EntityTypeCodeService {
	@Autowired
	EntityTypeCodeRepository entityTypeCodeRepository;

	public List<EntityTypeCode> getAllEntityTypeCodes() {
		return entityTypeCodeRepository.findAll();
	}

	public EntityTypeCode getEntityTypeCodesByCode(int code) {
		return entityTypeCodeRepository.findByCode(code);
	}

}
