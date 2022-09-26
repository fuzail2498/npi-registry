package com.nppes.npiregistry.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "state", uniqueConstraints = { @UniqueConstraint(columnNames = { "name", "reference_code" }) })
@Data
@AllArgsConstructor
@NoArgsConstructor
public class State {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected Long id;

	@Column(name = "name")
	private String name;

	@Column(name = "reference_code")
	private String referenceCode;

	@Column(name = "type_code")
	private String typeCode;

}
