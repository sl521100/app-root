<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>航空公司协议信息-编辑</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_agree_add.js")}
</head>
<body>
<div class="form">
    <form:form modelAttribute="agree"
               action="rule/carrier/save.do" method="post" id="frmEdit">
        <form:hidden path="recId"/>
        <table class="table-form" style="width:750px">
            <tbody>
            <tr>
                <td class="label">航空公司代码</td>
                <td><form:input path="carrierCode" class="inputText autoUpper"
                                value="${carrierCode }" style="width:80px !important;"
                                type="text" require="true" require-msg="航空公司代码"/>
                </td>
                <td class="label">航空公司名称</td>
                <td colspan="5"><form:input path="carrierName" class="inputText autoUpper"
                                            value="${carrierName }" style="width:100%;"
                                            type="text"/></td>
                <td class="label">协议代码</td>
                <td><form:input path="agreementCode" class="inputText autoUpper"
                                value="${agreementCode }" style="width:60px !important;"
                                type="text" require="true" require-msg="协议代码"/></td>
            </tr>
            <tr>
                <td class="label">协议起始日期</td>
                <td><form:input path="agreementStartDate" type="text" class="inputText Wdate"
                                style="width: 80px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议起始日期"/></td>

                <td class="label">协议终止日期</td>
                <td><form:input path="agreementEndDate" type="text" class="inputText Wdate"
                                style="width: 80px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议终止日期"/></td>
                <td class="label">账单币种</td>
                <td><form:input path="currency" class="inputText autoUpper"
                                value="${currency }" style="width:65px !important;"
                                type="text"/>
                </td>
                    <%--</tr>
                    <tr>--%>

                <td class="label">币种描述</td>
                <td><form:input path="currencyDsc" class="inputText autoUpper"
                                value="${currencyDsc }" style="width:65px !important;"
                                type="text"/>
                </td>

                <td class="label">账单语种</td>
                <td><form:input path="billLanguage" class="inputText autoUpper"
                                value="${billLanguage }" style="width:60px !important;"
                                type="text"/>
                </td>
                    <%--<td><form:button id="btnSave" onclick="return doSave();" value="保存"
                                     style="width:60px">保存</form:button></td>--%>
            </tr>
            <tr>
                <td class="title">
                    备注
                </td>
                <td colspan="8">
                    <form:input path="remark" class="inputText autoUpper" maxlength="200"/>
                </td>
                <td>
                    <f:if check="8020">
                        <form:button id="btnSave" onclick="return doSave();" value="保存"
                                     style="width:60px">保存</form:button>
                    </f:if>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>
</body>
</html>