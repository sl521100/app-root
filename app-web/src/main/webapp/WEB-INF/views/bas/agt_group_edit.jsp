<%@ taglib prefix="input" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>代理人组信息编辑</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/bas/agt_group.js")}
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
                <td class="label">分组名称(中文)</td>
                <td>
                    <form:input path="groupNameCn" style="width: 80px !important; "
                                require-msg="分组名称(中文)"
                                class="inputText" type="text" require="true" maxlength="10"/>
                    <form:hidden path="recId"/>
                </td>
            </tr>
            <tr>
                <td class="label">分组名称(英文)</td>
                <td>
                    <form:input path="groupNameEn" style="width: 80px !important; "
                                require-msg="分组名称(英文)"
                                class="inputText" type="text" require="true" maxlength="10"/>
                </td>
            </tr>
            <tr>
                <td class="label">组代码</td>
                <td>
                    <form:input path="partitionId" style="width: 80px !important; " require-msg="组代码"
                                class="inputText autoUpper" type="text" require="true" maxlength="6"/>
                </td>
            </tr>
            <tr>
                <td class="label">国内国际</td>
                <td>
                    <form:select path="di" style="width: 55px !important;">
                        <form:options items="${diList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td class="label">代理人</td>
                <td>
                    <form:input path="agentCode" style="width: 80px !important; " require-msg="代理人"
                                class="inputText autoUpper" type="text" require="true" maxlength="3"/>
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
        $("#groupNameCn").focus().select();
    }
</script>
</body>
</html>
