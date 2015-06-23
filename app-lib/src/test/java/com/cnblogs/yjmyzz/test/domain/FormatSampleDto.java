package com.cnblogs.yjmyzz.test.domain;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import java.util.Date;

/**
 * Created by jimmy on 2015/3/4.
 */
public class FormatSampleDto {

    @NumberFormat(pattern = "#.##")
    private Double fee;

    @NumberFormat(pattern = "#.00")
    private int pcs;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createDate;

    public Double getFee() {
        return fee;
    }

    public void setFee(Double fee) {
        this.fee = fee;
    }

    public int getPcs() {
        return pcs;
    }

    public void setPcs(int pcs) {
        this.pcs = pcs;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
