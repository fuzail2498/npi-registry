package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nppes.npiregistry.domain.State;

public interface StateRepository extends JpaRepository<State, Long> {
	
	State findByReferenceCode(String referenceCode);

	State findByName(String stateName);

}
