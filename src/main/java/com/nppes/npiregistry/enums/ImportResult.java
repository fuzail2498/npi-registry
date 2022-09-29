package com.nppes.npiregistry.enums;

public enum ImportResult {
	SUCCESS("SUCCESS"), FAILED("FAILED"), PARTIAL_FAILED("PARTIAL_FAILED");

	String importResult;

	private ImportResult(String importResult) {
		this.importResult = importResult;
	}

	public String getImportResult() {
		return importResult;
	}

}
