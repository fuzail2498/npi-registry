package com.nppes.npiregistry.dto;

import com.nppes.npiregistry.enums.ImportResult;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CSVFileImportResponse {
	private ImportResult importResult;
	private Long totalRecord;
	private String description;

}
