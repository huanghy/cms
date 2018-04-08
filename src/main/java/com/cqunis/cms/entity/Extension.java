package com.cqunis.cms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.alibaba.fastjson.annotation.JSONField;
import com.cqunis.entity.support.BaseEntity;


/**
 * The persistent class for the cqunis_oa_extension database table.
 * 
 */
@Entity
@Table(name="cqunis_oa_extension")
@NamedQuery(name="Extension.findAll", query="SELECT e FROM Extension e")
public class Extension extends BaseEntity {


	@Column(name="actual_amount")
	private String actualAmount;

	@Column(name="alr_ad")
	private int alrAd;

	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="end_time")
	private Date endTime;

	@Column(name="ex_name")
	private String exName;

	@Column(name="ex_type_id")
	private String exTypeId;

	@Column(name="ex_type_name")
	private String exTypeName;

	@Column(name="human_id")
	private String humanId;

	@Column(name="human_name")
	private String humanName;

	@Column(name="inv_amount")
	private String invAmount;

	private String region;

	private int sort;

	@Column(name="task_state")
	private int taskState;
	
	/***多久执行一次
	 */
	@Column(name="period")
	private int period;
	
	/***延迟时间
	 */
	@Column(name="delay")
	private int delay;
	
	
	/**随机数量**/
	@Column(name="random_num")
	private int randomNum;
	
	@Column(name="exe_state")
	private int exeState;
	

	@Column(name="unit_price")
	private String unitPrice;
	
	/***备注
	 */
	@Column(name="des")
	private String des;


	public Extension() {
	}

	

	public String getActualAmount() {
		return this.actualAmount;
	}

	public void setActualAmount(String actualAmount) {
		this.actualAmount = actualAmount;
	}

	public int getAlrAd() {
		return this.alrAd;
	}

	public void setAlrAd(int alrAd) {
		this.alrAd = alrAd;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public String getExName() {
		return this.exName;
	}

	public void setExName(String exName) {
		this.exName = exName;
	}

	public String getExTypeId() {
		return this.exTypeId;
	}

	public void setExTypeId(String exTypeId) {
		this.exTypeId = exTypeId;
	}

	public String getExTypeName() {
		return this.exTypeName;
	}

	public void setExTypeName(String exTypeName) {
		this.exTypeName = exTypeName;
	}

	public String getHumanId() {
		return this.humanId;
	}

	public void setHumanId(String humanId) {
		this.humanId = humanId;
	}

	public String getHumanName() {
		return this.humanName;
	}

	public void setHumanName(String humanName) {
		this.humanName = humanName;
	}

	public String getInvAmount() {
		return this.invAmount;
	}

	public void setInvAmount(String invAmount) {
		this.invAmount = invAmount;
	}

	public String getRegion() {
		return this.region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public int getSort() {
		return this.sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getTaskState() {
		return this.taskState;
	}

	public void setTaskState(int taskState) {
		this.taskState = taskState;
	}

	public String getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}



	/**
	 * @return the des
	 */
	public String getDes() {
		return des;
	}



	/**
	 * @param des the des to set
	 */
	public void setDes(String des) {
		this.des = des;
	}



	/**
	 * @return the period
	 */
	public int getPeriod() {
		return period;
	}



	/**
	 * @param period the period to set
	 */
	public void setPeriod(int period) {
		this.period = period;
	}



	/**
	 * @return the randomNum
	 */
	public int getRandomNum() {
		return randomNum;
	}



	/**
	 * @param randomNum the randomNum to set
	 */
	public void setRandomNum(int randomNum) {
		this.randomNum = randomNum;
	}



	/**
	 * @return the exeState
	 */
	public int getExeState() {
		return exeState;
	}



	/**
	 * @param exeState the exeState to set
	 */
	public void setExeState(int exeState) {
		this.exeState = exeState;
	}



	/**
	 * @return the delay
	 */
	public int getDelay() {
		return delay;
	}



	/**
	 * @param delay the delay to set
	 */
	public void setDelay(int delay) {
		this.delay = delay;
	}
	
	
	
}