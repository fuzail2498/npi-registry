package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nppes.npiregistry.domain.EntityTypeCode;

public interface EntityTypeCodeRepository extends JpaRepository<EntityTypeCode, Long> {
	EntityTypeCode findByCode(int code);

}
