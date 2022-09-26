package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nppes.npiregistry.domain.NPI;

public interface NPIRepository extends JpaRepository<NPI, Long>{
	NPI findByNpi(long npi);

}
