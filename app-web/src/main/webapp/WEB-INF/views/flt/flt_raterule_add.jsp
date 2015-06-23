<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2015/3/27
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>航空公司费率详情-编辑</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_raterule_add.js")}
</head>
<body>
<div class="form">
    <form:form modelAttribute="fltRateRule"
               action="rule/carrier/fee/rate/save.do" method="post" id="frmRateRuleEdit">
        <form:hidden path="recId"/>
        <form:hidden path="fkFltRateId"/>
        <table class="table-form" style="width:750px">
            <colgroup>
                <col width="8%">
                <col width="6%">
                <col width="6%">
                <col width="8%">
                <col width="6%">
                <col width="6%">
                <col width="8%">
                <col width="6%">
                <col width="4%">
                <col width="6%">
                <col width="12%">
                <col width="auto">
            </colgroup>
            <tbody>
            <tr>
                <td class="label">起始重量</td>
                <td>
                    <form:select path="minSigns" value="${minSigns }">
                        <form:options items="${minSignsList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                </td>
                <td><form:input path="minWeight" class="inputText autoUpper" value="${minWeight }" type="text"/>
                </td>

                <td class="label">结束重量</td>
                <td>
                    <form:select path="maxSigns" value="${maxSigns }">
                        <form:options items="${maxSignsList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                </td>
                <td><form:input path="maxWeight" class="inputText" type="text"/></td>

                <td class="label">最低收费</td>
                <td><form:input path="minPrice" class="inputText autoUpper" value="${minPrice }" type="text"/>
                </td>
                <td>费率</td>
                <td><form:input path="rate" class="inputText"
                                type="text" require="true" require-msg="费率"/></td>
                <td class="label">始止生效日期</td>
                <td><form:input path="startDate" type="text" class="inputText Wdate"
                                style="width: 80px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/>
                    <span>-</span>
                    <form:input path="endDate" type="text" class="inputText Wdate"
                                style="width: 80px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/></td>
            </tr>

            <tr>
                <td class="title">
                    备注
                </td>
                <td colspan="10">
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
