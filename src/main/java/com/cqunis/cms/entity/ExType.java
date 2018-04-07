package com.cqunis.cms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.cqunis.entity.support.BaseEntity;


/**
 * The persistent class for the cqunis_oa_ex_type database table.
 * 
 */
@Entity
@Table(name="cqunis_oa_ex_type")
@NamedQuery(name="ExType.findAll", query="SELECT e FROM ExType e")
public class ExType extends BaseEntity {

	@Column(name="type_name")
	private String typeName;

	public ExType() {
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
}