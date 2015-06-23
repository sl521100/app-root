<%@ taglib prefix="input" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>${feeTypeTitle}收费项编辑</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/bas/fee_type.js")}
    <style type="text/css">
        .inputText,select {margin-left: 10px;}
    </style>
</head>
<body class="Common" style="height:100%">
<div class="formContainer" style="width: 250px;margin: 0 auto;padding-top:5%;">
    <form:form modelAttribute="data" action="ud/agtgroup/save.do" method="post" id="frmEdit">
        <table class="table-form">
            <tbody>
            <tr>
                <td class="label">费用类型</td>
                <td>
                    <form:input path="feeType" style="width: 90px !important; " require-msg="费用类型"
                                class="inputText autoUpper" type="text" require="true" maxlength="10"/>
                    <form:hidden path="recId"/>
                    <form:hidden path="feeSuitType"/>
                </td>
            </tr>
            <tr>
                <td class="label">中文描述</td>
                <td>
                    <form:input path="feeDsc" style="width: 90px !important; " require-msg="中文描述"
                                class="inputText autoUpper" type="text" require="true" maxlength="15"/>
                </td>
            </tr>
            <tr>
                <td class="label">英文描述</td>
                <td>
                    <form:input path="feeEgDsc" style="width: 90px !important; "
                                class="inputText autoUpper" type="text" maxlength="15"/>
                </td>
            </tr>
            <tr>
                <td class="label">备注</td>
                <td>
                    <form:input path="remark" style="width: 90px !important; "
                                class="inputText autoUpper" type="text" maxlength="20"/>
                </td>
            </tr>
            <f:if check="8010">
                <tr>
                    <td style="text-align: center;" colspan="2">
                        <form:button id="btnSave" onclick="return doSave()" value="保存"
                                     style="width:65px">保存</form:button>
                    </td>
                </tr>
            </f:if>
            </tbody>
        </table>
    </form:form>
</div>
<script type="text/javascript">
    var errMsg = "${errMsg}";
    if (errMsg != undefined && errMsg != "") {
        alert(errMsg);
        $("#feeType").focus().select();
    }
</script>
</body>
</html>
