package com.cqunis.cms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.cqunis.entity.support.BaseEntity;


/**
 * The persistent class for the cqunis_oa_ex_record database table.
 * 
 */
@Entity
@Table(name="cqunis_oa_ex_record")
@NamedQuery(name="ExRecord.findAll", query="SELECT e FROM ExRecord e")
public class ExRecord  extends BaseEntity  {
	private static final long serialVersionUID = 1L;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="end_time")
	private Date endTime;

	@Column(name="ext_id")
	private String extId;

	@Column(name="human_id")
	private String humanId;

	@Column(name="unit_price")
	private String unitPrice;

	public ExRecord() {
	}


	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}


	public String getExtId() {
		return this.extId;
	}

	public void setExtId(String extId) {
		this.extId = extId;
	}

	public String getHumanId() {
		return this.humanId;
	}

	public void setHumanId(String humanId) {
		this.humanId = humanId;
	}

	public String getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
}