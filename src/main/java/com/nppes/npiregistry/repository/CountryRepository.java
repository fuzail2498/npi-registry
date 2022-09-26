package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nppes.npiregistry.domain.Country;

@Repository
public interface CountryRepository extends JpaRepository<Country, Long> {

}
