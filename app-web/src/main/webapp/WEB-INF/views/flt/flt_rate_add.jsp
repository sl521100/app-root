<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2015/3/26
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>航空公司费用规则-编辑</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_rate_add.js")}
</head>
<body>
<div class="form">
    <form:form modelAttribute="fltRate"
               action="rule/carrier/fee/save.do" method="post" id="frmEdit">
        <form:hidden path="recId"/>
        <form:hidden path="fkAgreeId"/>
        <table class="table-form" style="width:750px">
            <colgroup>
                <col width="8%">
                <col width="8%">
                <col width="8%">
                <col width="8%">
                <col width="10%">
                <col width="8%">
                <col width="8%">
                <col width="4%">
                <col width="12%">
            </colgroup>
            <tbody>
            <tr>
                <td class="label">规则描述</td>
                <td colspan="2"><form:input path="feeRuleDsc" class="inputText autoUpper"
                                            value="${feeRuleDsc }"
                                            type="text"/>
                </td>

                <td colspan="2">
                    <form:select path="feeType" value="${feeType }" title="费用类型" onchange="return feeTypeChange(this)">
                        <form:options items="${feeTypeList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                    <form:hidden path="feeDsc"/>
                </td>
                <td colspan="2">
                    <form:select path="rateType" value="${rateType }" title="计费方式"
                                 onchange="return rateTypeChange(this)">
                        <form:options items="${rateTypeList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                    <form:hidden path="rateDsc"/>
                </td>
                <td class="label">费率</td>
                <td><form:input path="rate" class="inputText"
                                type="text" require="true" require-msg="费率"/></td>

            </tr>
            <tr>
                <td><form:select path="di" value="${di }" title="国内国际">
                    <form:options items="${diList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td><form:select path="fltMode" title="客机/货机" value="${fltMode }">
                    <form:options items="${fltModeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><form:select path="cargoMailFlag" title="货物邮件" value="${cargoMailFlag }">
                    <form:options items="${awbTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td><form:select path="trainsFlag" title="中转直达" value="${trainsFlag }">
                    <form:options items="${transFlagList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td><form:select path="trainsType" title="中转类型" value="${trainsType }">
                    <form:options items="${transTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>


                <td><form:select path="ei" value="${ei }" title="进港出港">
                    <form:options items="${eiList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td><form:select path="airport" title="航站" value="${airport }">
                    <form:options items="${airportList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>


                <td class="label">货站</td>
                <td><form:input path="opeStation" class="inputText autoUpper" value="${opeStation }" type="text"/>
                </td>


            </tr>
            <tr>
                <td class="title">
                    备注
                </td>
                <td colspan="7">
                    <form:input path="remark" class="inputText autoUpper" maxlength="200"/>
                </td>
                <td>
                    <f:if check="8020">
                        <form:button id="btnSave" style="width:60px;" onclick="return doSave();"
                                     value="保存">保存</form:button>
                    </f:if>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>
</body>
</html>
