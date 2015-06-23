package com.cnblogs.yjmyzz.test.domain;

import java.io.Serializable;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "sample")
public class Sample implements Serializable {

	private static final long serialVersionUID = -6271703229325404123L;

	private Double amount;

	private Date createDate;

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public boolean equals(Sample s) {
		if (s == null) {
			return false;
		}

		if (s.getAmount().equals(this.getAmount())
				&& s.getCreateDate().toString()
						.equals(this.getCreateDate().toString())) {
			return true;
		}

		return false;
	}

}
