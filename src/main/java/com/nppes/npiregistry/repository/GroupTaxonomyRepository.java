package com.nppes.npiregistry.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nppes.npiregistry.domain.GroupTaxonomy;

@Repository
public interface GroupTaxonomyRepository extends JpaRepository<GroupTaxonomy, Long> {

}
