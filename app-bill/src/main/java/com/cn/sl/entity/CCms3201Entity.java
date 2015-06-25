package com.cn.sl.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Created by shilin on 2015/6/24.
 */
@Entity
@javax.persistence.Table(name = "C_CMS_3201", schema = "CDS", catalog = "")
public class CCms3201Entity {
    private BigDecimal recid;

    @Id
    @SequenceGenerator(name="SEQ_C_CMS_3201", sequenceName="SEQ_C_CMS_3201", allocationSize = 1)
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="SEQ_C_CMS_3201")
    @Column(name ="RECID")
    public BigDecimal getRecid() {
        return recid;
    }

    public void setRecid(BigDecimal recid) {
        this.recid = recid;
    }

    private String awbPre;

    @Basic
    @javax.persistence.Column(name = "AWB_PRE", nullable = false, insertable = true, updatable = true, length = 5)
    public String getAwbPre() {
        return awbPre;
    }

    public void setAwbPre(String awbPre) {
        this.awbPre = awbPre;
    }

    private String awbNo;

    @Basic
    @javax.persistence.Column(name = "AWB_NO", nullable = false, insertable = true, updatable = true, length = 10)
    public String getAwbNo() {
        return awbNo;
    }

    public void setAwbNo(String awbNo) {
        this.awbNo = awbNo;
    }

    private String houseNo;

    @Basic
    @javax.persistence.Column(name = "HOUSE_NO", nullable = true, insertable = true, updatable = true, length = 30)
    public String getHouseNo() {
        return houseNo;
    }

    public void setHouseNo(String houseNo) {
        this.houseNo = houseNo;
    }

    private String cargodescription;

    @Basic
    @javax.persistence.Column(name = "CARGODESCRIPTION", nullable = true, insertable = true, updatable = true, length = 100)
    public String getCargodescription() {
        return cargodescription;
    }

    public void setCargodescription(String cargodescription) {
        this.cargodescription = cargodescription;
    }

    private String companycode;

    @Basic
    @javax.persistence.Column(name = "COMPANYCODE", nullable = false, insertable = true, updatable = true, length = 50)
    public String getCompanycode() {
        return companycode;
    }

    public void setCompanycode(String companycode) {
        this.companycode = companycode;
    }

    private String carriercode;

    @Basic
    @javax.persistence.Column(name = "CARRIERCODE", nullable = true, insertable = true, updatable = true, length = 5)
    public String getCarriercode() {
        return carriercode;
    }

    public void setCarriercode(String carriercode) {
        this.carriercode = carriercode;
    }

    private String flightno;

    @Basic
    @javax.persistence.Column(name = "FLIGHTNO", nullable = true, insertable = true, updatable = true, length = 12)
    public String getFlightno() {
        return flightno;
    }

    public void setFlightno(String flightno) {
        this.flightno = flightno;
    }

    private Timestamp flightdate;

    @Basic
    @javax.persistence.Column(name = "FLIGHTDATE", nullable = true, insertable = true, updatable = true)
    public Timestamp getFlightdate() {
        return flightdate;
    }

    public void setFlightdate(Timestamp flightdate) {
        this.flightdate = flightdate;
    }

    private String airport;

    @Basic
    @javax.persistence.Column(name = "AIRPORT", nullable = true, insertable = true, updatable = true, length = 3)
    public String getAirport() {
        return airport;
    }

    public void setAirport(String airport) {
        this.airport = airport;
    }

    private BigDecimal pcs;

    @Basic
    @javax.persistence.Column(name = "PCS", nullable = false, insertable = true, updatable = true, precision = -127)
    public BigDecimal getPcs() {
        return pcs;
    }

    public void setPcs(BigDecimal pcs) {
        this.pcs = pcs;
    }

    private BigDecimal weight;

    @Basic
    @javax.persistence.Column(name = "WEIGHT", nullable = false, insertable = true, updatable = true, precision = -127)
    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    private BigDecimal awbpcs;

    @Basic
    @javax.persistence.Column(name = "AWBPCS", nullable = true, insertable = true, updatable = true, precision = -127)
    public BigDecimal getAwbpcs() {
        return awbpcs;
    }

    public void setAwbpcs(BigDecimal awbpcs) {
        this.awbpcs = awbpcs;
    }

    private BigDecimal awbweight;

    @Basic
    @javax.persistence.Column(name = "AWBWEIGHT", nullable = true, insertable = true, updatable = true, precision = -127)
    public BigDecimal getAwbweight() {
        return awbweight;
    }

    public void setAwbweight(BigDecimal awbweight) {
        this.awbweight = awbweight;
    }

    private String createOpe;

    @Basic
    @javax.persistence.Column(name = "CREATE_OPE", nullable = true, insertable = true, updatable = true, length = 100)
    public String getCreateOpe() {
        return createOpe;
    }

    public void setCreateOpe(String createOpe) {
        this.createOpe = createOpe;
    }

    private Timestamp createTime;

    @Basic
    @javax.persistence.Column(name = "CREATE_TIME", nullable = false, insertable = true, updatable = true)
    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    private String createType;

    @Basic
    @javax.persistence.Column(name = "CREATE_TYPE", nullable = false, insertable = true, updatable = true, length = 1)
    public String getCreateType() {
        return createType;
    }

    public void setCreateType(String createType) {
        this.createType = createType;
    }

    private BigDecimal status;

    @Basic
    @javax.persistence.Column(name = "STATUS", nullable = true, insertable = true, updatable = true, precision = -127)
    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    private String msgid;

    @Basic
    @javax.persistence.Column(name = "MSGID", nullable = true, insertable = true, updatable = true, length = 100)
    public String getMsgid() {
        return msgid;
    }

    public void setMsgid(String msgid) {
        this.msgid = msgid;
    }

    private String sendcode;

    @Basic
    @javax.persistence.Column(name = "SENDCODE", nullable = true, insertable = true, updatable = true, length = 2)
    public String getSendcode() {
        return sendcode;
    }

    public void setSendcode(String sendcode) {
        this.sendcode = sendcode;
    }

    private String sendresponse;

    @Basic
    @javax.persistence.Column(name = "SENDRESPONSE", nullable = true, insertable = true, updatable = true, length = 400)
    public String getSendresponse() {
        return sendresponse;
    }

    public void setSendresponse(String sendresponse) {
        this.sendresponse = sendresponse;
    }

    private Timestamp arrivalDate;

    @Basic
    @javax.persistence.Column(name = "ARRIVAL_DATE", nullable = true, insertable = true, updatable = true)
    public Timestamp getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(Timestamp arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    private BigDecimal officeid;

    @Basic
    @javax.persistence.Column(name = "OFFICEID", nullable = true, insertable = true, updatable = true, precision = -127)
    public BigDecimal getOfficeid() {
        return officeid;
    }

    public void setOfficeid(BigDecimal officeid) {
        this.officeid = officeid;
    }

    private BigDecimal sendcount;

    @Basic
    @javax.persistence.Column(name = "SENDCOUNT", nullable = true, insertable = true, updatable = true, precision = -127)
    public BigDecimal getSendcount() {
        return sendcount;
    }

    public void setSendcount(BigDecimal sendcount) {
        this.sendcount = sendcount;
    }

    private String flag;

    @Basic
    @javax.persistence.Column(name = "FLAG", nullable = true, insertable = true, updatable = true, length = 50)
    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    private String exts;

    @Basic
    @javax.persistence.Column(name = "EXTS", nullable = true, insertable = true, updatable = true, length = 100)
    public String getExts() {
        return exts;
    }

    public void setExts(String exts) {
        this.exts = exts;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CCms3201Entity that = (CCms3201Entity) o;

        if (airport != null ? !airport.equals(that.airport) : that.airport != null) return false;
        if (arrivalDate != null ? !arrivalDate.equals(that.arrivalDate) : that.arrivalDate != null) return false;
        if (awbNo != null ? !awbNo.equals(that.awbNo) : that.awbNo != null) return false;
        if (awbPre != null ? !awbPre.equals(that.awbPre) : that.awbPre != null) return false;
        if (awbpcs != null ? !awbpcs.equals(that.awbpcs) : that.awbpcs != null) return false;
        if (awbweight != null ? !awbweight.equals(that.awbweight) : that.awbweight != null) return false;
        if (cargodescription != null ? !cargodescription.equals(that.cargodescription) : that.cargodescription != null)
            return false;
        if (carriercode != null ? !carriercode.equals(that.carriercode) : that.carriercode != null) return false;
        if (companycode != null ? !companycode.equals(that.companycode) : that.companycode != null) return false;
        if (createOpe != null ? !createOpe.equals(that.createOpe) : that.createOpe != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (createType != null ? !createType.equals(that.createType) : that.createType != null) return false;
        if (exts != null ? !exts.equals(that.exts) : that.exts != null) return false;
        if (flag != null ? !flag.equals(that.flag) : that.flag != null) return false;
        if (flightdate != null ? !flightdate.equals(that.flightdate) : that.flightdate != null) return false;
        if (flightno != null ? !flightno.equals(that.flightno) : that.flightno != null) return false;
        if (houseNo != null ? !houseNo.equals(that.houseNo) : that.houseNo != null) return false;
        if (msgid != null ? !msgid.equals(that.msgid) : that.msgid != null) return false;
        if (officeid != null ? !officeid.equals(that.officeid) : that.officeid != null) return false;
        if (pcs != null ? !pcs.equals(that.pcs) : that.pcs != null) return false;
        if (recid != null ? !recid.equals(that.recid) : that.recid != null) return false;
        if (sendcode != null ? !sendcode.equals(that.sendcode) : that.sendcode != null) return false;
        if (sendcount != null ? !sendcount.equals(that.sendcount) : that.sendcount != null) return false;
        if (sendresponse != null ? !sendresponse.equals(that.sendresponse) : that.sendresponse != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (weight != null ? !weight.equals(that.weight) : that.weight != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = recid != null ? recid.hashCode() : 0;
        result = 31 * result + (awbPre != null ? awbPre.hashCode() : 0);
        result = 31 * result + (awbNo != null ? awbNo.hashCode() : 0);
        result = 31 * result + (houseNo != null ? houseNo.hashCode() : 0);
        result = 31 * result + (cargodescription != null ? cargodescription.hashCode() : 0);
        result = 31 * result + (companycode != null ? companycode.hashCode() : 0);
        result = 31 * result + (carriercode != null ? carriercode.hashCode() : 0);
        result = 31 * result + (flightno != null ? flightno.hashCode() : 0);
        result = 31 * result + (flightdate != null ? flightdate.hashCode() : 0);
        result = 31 * result + (airport != null ? airport.hashCode() : 0);
        result = 31 * result + (pcs != null ? pcs.hashCode() : 0);
        result = 31 * result + (weight != null ? weight.hashCode() : 0);
        result = 31 * result + (awbpcs != null ? awbpcs.hashCode() : 0);
        result = 31 * result + (awbweight != null ? awbweight.hashCode() : 0);
        result = 31 * result + (createOpe != null ? createOpe.hashCode() : 0);
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (createType != null ? createType.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (msgid != null ? msgid.hashCode() : 0);
        result = 31 * result + (sendcode != null ? sendcode.hashCode() : 0);
        result = 31 * result + (sendresponse != null ? sendresponse.hashCode() : 0);
        result = 31 * result + (arrivalDate != null ? arrivalDate.hashCode() : 0);
        result = 31 * result + (officeid != null ? officeid.hashCode() : 0);
        result = 31 * result + (sendcount != null ? sendcount.hashCode() : 0);
        result = 31 * result + (flag != null ? flag.hashCode() : 0);
        result = 31 * result + (exts != null ? exts.hashCode() : 0);
        return result;
    }
}
