package com.nppes.npiregistry.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.csvreader.CsvReader;
import com.nppes.npiregistry.constants.NPIRegistryConstants;
import com.nppes.npiregistry.domain.GroupTaxonomy;
import com.nppes.npiregistry.domain.NPI;
import com.nppes.npiregistry.domain.PrimaryTaxonomy;
import com.nppes.npiregistry.domain.ProviderTaxonomyCode;
import com.nppes.npiregistry.domain.State;
import com.nppes.npiregistry.domain.Taxonomy;
import com.nppes.npiregistry.repository.GroupTaxonomyRepository;
import com.nppes.npiregistry.repository.PrimaryTaxonomyRepository;
import com.nppes.npiregistry.repository.ProviderTaxonomyCodeRepository;
import com.nppes.npiregistry.repository.StateRepository;

@Service
public class TaxonomyService {

	@Autowired
	ProviderTaxonomyCodeRepository providerTaxonomyCodeRepository;
	@Autowired
	PrimaryTaxonomyRepository primaryTaxonomyRepository;
	@Autowired
	GroupTaxonomyRepository groupTaxonomyRepository;
	@Autowired
	StateRepository stateRepository;
	@Autowired
	MasterDataService masterDataService;

	public List<Taxonomy> importTaxonomyDataFromCSV(CsvReader npiRecords, NPI nPI, NPI npiFromRepo, Map<String, State> stateData, List<GroupTaxonomy> groupTaxonomies) throws IOException {


		List<Taxonomy> taxList = new ArrayList<Taxonomy>();

		for (int i = 1; i <= 15; i++) {

			String taxonomyCode = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_HEALTHCARE_PROVIDER_TAXONOMY_CODE + i);
			String primaryTaxonomySwitch = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH + i);
			String taxonomyGroup = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_HEALTHCARE_PROVIDER_TAXONOMY_GROUP + i);
			String license = npiRecords.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_LICENSE_NUMBER + i);
			String state = npiRecords
					.get(NPIRegistryConstants.NPI_REGISTRY_CSV_HEADER_PROVIDER_LICENSE_NUMBER_STATE_CODE + i);

			if (StringUtils.isNotBlank(taxonomyCode) || StringUtils.isNotBlank(primaryTaxonomySwitch)
					|| StringUtils.isNotBlank(taxonomyGroup) || StringUtils.isNotBlank(license)
					|| StringUtils.isNotBlank(state)) {

				Taxonomy taxonomy = new Taxonomy();

				if (!taxonomyCode.isEmpty()) {
					ProviderTaxonomyCode taxonomyCodeObj = masterDataService.getTaxonomyCodeMap().get(taxonomyCode);

					if (!ObjectUtils.isEmpty(taxonomyCodeObj)) {
						taxonomy.setProviderTaxonomyCode(taxonomyCodeObj);
					}

				}

				if (!primaryTaxonomySwitch.isEmpty()) {
					PrimaryTaxonomy primaryTaxonomyObj = masterDataService.getPrimaryTaxonomyMap()
							.get(primaryTaxonomySwitch);
					if (!ObjectUtils.isEmpty(primaryTaxonomyObj)) {
						taxonomy.setPrimaryTaxonomy(primaryTaxonomyObj);
					}
				}

				if (!taxonomyGroup.isEmpty()) {
					GroupTaxonomy taxonomyGroupObj = null;
					String[] taxGroupFirstChar = taxonomyGroup.split(" ");
					if (taxGroupFirstChar[0].equals(groupTaxonomies.get(0).getCode())) {
						taxonomyGroupObj = groupTaxonomies.get(0);
					} else if (taxGroupFirstChar[0].equals(groupTaxonomies.get(1).getCode())) {
						taxonomyGroupObj = groupTaxonomies.get(1);
					}
					if (!ObjectUtils.isEmpty(taxonomyGroupObj)) {
						taxonomy.setGroupTaxonomy(taxonomyGroupObj);
					}
				}

				if (!license.isEmpty()) {
					taxonomy.setLicense(license);
				}

				if (!state.isEmpty()) {
					State stateObj = stateData.get(state);
					if (!ObjectUtils.isEmpty(stateObj)) {
						taxonomy.setState(stateObj);
					}
				}

				if (!ObjectUtils.isEmpty(nPI)) {
					taxonomy.setNpi(nPI);
				}

				if (!ObjectUtils.isEmpty(taxonomy)) {
					taxList.add(taxonomy);
				}
			}
		}
		
		return taxList;
	}

}
