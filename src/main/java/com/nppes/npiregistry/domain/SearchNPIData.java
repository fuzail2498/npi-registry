package com.nppes.npiregistry.domain;

import java.util.List;

import lombok.Data;

@Data
public class SearchNPIData {

	private List<SearchItems> searchItems;
	private int offset;
	private int pageSize;

}
