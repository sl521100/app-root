<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/agt/agt_agree_add.js")}
    <title>计费规则-代理人协议</title>
</head>
<body>

<div class="formContainer" style="width:610px;">
    <form:form modelAttribute="data"
               action="rule/agent/save.do" method="post" id="frmEdit">
        <form:hidden path="recId" />
        <form:hidden path="currency" />
        <form:hidden path="currencyDsc" />
        <form:hidden path="billLanguage" />
        <table class="table-form" border="0" align="center" style="margin:auto;width:580px">
            <tr>
                <td class="label">代理人简称</td>
                <td><form:input path="agentCode" class="inputText autoUpper"
                                style="width: 50px !important;" maxlength="3" type="text" require="true"
                                require-msg="代理人简称"/></td>
                <td class="label">协议开始日期</td>
                <td><form:input path="agreementStartDate" type="text" class="inputText Wdate"
                                style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议开始日期"/></td>
                <td class="label">协议截止日期</td>
                <td><form:input path="agreementEndDate" type="text" class="inputText Wdate"
                                style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议截止日期"/></td>
            </tr>
            <tr>
                <td class="label">协议代码</td>
                <td><form:input path="agreementCode" class="inputText autoUpper"
                                style="width: 50px !important;" maxlength="20" type="text" require="true"
                                require-msg="协议代码"/></td>
                <td class="label">代理人名称</td>
                <td colspan="3"><form:input path="agentName" class="inputText autoUpper"
                                            style="width: 320px !important;" maxlength="100" type="text" require="true"
                                            require-msg="代理人名称"/></td>
            </tr>
            <tr>
                <td class="label">备注</td>
                <td colspan="4"><form:input path="remark" class="inputText autoUpper"
                                            style="width: 235px !important;" maxlength="50" type="text"/></td>
                <td align="center"><form:button id="btnSave" onclick="return doSave()" value="保存"
                                                style="width:75px;margin-right:15px">保存</form:button></td>
            </tr>
        </table>
    </form:form>
</div>
</body>
</html>