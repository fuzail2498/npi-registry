package com.nppes.npiregistry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.GenderCode;
import com.nppes.npiregistry.repository.GenderCodeRepository;

@Service
public class GenderCodesService {
	@Autowired
	GenderCodeRepository genderCodeRepository;

	/**
	 * This method is used to get all the gender codes
	 * 
	 * @return
	 */
	public List<GenderCode> getALLGenderCodes() {
		return genderCodeRepository.findAll();
	}

}
