package com.nppes.npiregistry.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.nppes.npiregistry.domain.EntityTypeCode;
import com.nppes.npiregistry.exception.NotFoundException;
import com.nppes.npiregistry.exception.UnprocessableEntityException;
import com.nppes.npiregistry.service.EntityTypeCodeService;

@RestController
public class EntityTypeCodeController {
	@Autowired
	EntityTypeCodeService entityTypeCodeService;

	/**
	 * This controller method is used to get all Entity Type Code
	 * 
	 * @param code
	 * @return
	 */
	@GetMapping("/v1/entity-type-code")
	public List<EntityTypeCode> getAllEntityTypeCodes() {
		return entityTypeCodeService.getAllEntityTypeCodes();
	}

	/**
	 * This controller method is used to get Entity Type Code by code
	 * 
	 * @param code
	 * @return
	 */
	@GetMapping("/v1/entity-type-code/{code}")
	public EntityTypeCode getAllEntityTypeCodes(@PathVariable("code") int code) {
		EntityTypeCode entityTypeCode = entityTypeCodeService.getEntityTypeCodesByCode(code);
		if (entityTypeCode == null) {
			throw new NotFoundException("Invalid Entity Type Code");
		}
		return entityTypeCode;
	}

}
