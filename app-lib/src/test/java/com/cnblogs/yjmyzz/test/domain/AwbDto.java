package com.cnblogs.yjmyzz.test.domain;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import java.util.Date;

public class AwbDto {

    public AwbDto() {
        super();

    }

    public AwbDto(String awbNumber, String agent, Double price, Date createDate) {
        super();
        this.awbNumber = awbNumber;
        this.agent = agent;
        this.price = price;
        this.createDate = createDate;
    }

    /**
     * 创建日期
     */
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date createDate;

    /**
     * 价格
     */
    @NumberFormat(pattern = "#.000")
    private Double price;


    /**
     * 运单号
     */
    private String awbNumber;

    /**
     * 代理人
     */
    private String agent;

    public String getAwbNumber() {
        return awbNumber;
    }

    public void setAwbNumber(String awbNumber) {
        this.awbNumber = awbNumber;
    }

    public String getAgent() {
        return agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }


    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }


    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
