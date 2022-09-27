package com.nppes.npiregistry.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.repository.StateRepository;

@Service
public class StateService {
	@Autowired
	StateRepository stateRepository;

	/**
	 * This method is used to get state by refrence code
	 * 
	 * @param referenceCode
	 * @return
	 */
	public State getStateByReferenceCode(String referenceCode) {
		return stateRepository.findByReferenceCode(referenceCode);

	}

	/**
	 * This method is used to get the state by name
	 * 
	 * @param stateName
	 * @return
	 */
	public State getStateByName(String stateName) {
		return stateRepository.findByName(stateName);

	}

}
