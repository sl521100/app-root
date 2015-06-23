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
    ${f:addJs("resources/js/agt/agt_rate_add.js")}
    <title>代理人计费规则</title>
</head>
<body>

<div class="formContainer" style="width:610px;">
    <form:form modelAttribute="data"
               action="rule/agent/fee/save.do" method="post" id="frmEdit">
        <form:hidden path="fkAgreeId"/>
        <form:hidden path="feeDsc"/>
        <form:hidden path="recId"/>
        <table class="table-form" border="0" align="center" style="margin:auto;width:auto!important;">
            <tr>
                <td class="label">规则描述</td>
                <td><form:input path="feeRuleDsc" class="inputText autoUpper"
                                style="width: 120px !important;" maxlength="50" type="text" require="true"
                                require-msg="规则描述"/></td>
                <td class="label">费用类型</td>
                <td><form:select path="feeType" value="${feeType }" title="费用类型" onchange="setFeeDsc(this)" require="true"
                                 require-msg="费用类型">
                    <form:options items="${feeTypeList}" itemValue="value" itemLabel="name" />
                </form:select></td>
                <td class="label">费率</td>
                <td><form:input path="rate" class="inputText autoUpper"
                                style="width: 80px !important;" maxlength="6" type="text" require="true"
                                require-msg="费率"/></td>
            </tr>
            <tr>
                <td class="label">最低收费</td>
                <td><form:input path="minPrice" class="inputText autoUpper"
                                style="width: 120px !important;" maxlength="6" type="text" require="true"
                                require-msg="最低收费"/></td>
                <td class="label">最高收费</td>
                <td><form:input path="maxPrice" class="inputText autoUpper"
                                style="width: 180px !important;" maxlength="6" type="text" require="true"
                                require-msg="最高收费"/></td>
                <td class="label">国内国际</td>
                <td><form:select path="di" value="${di }" title="国内国际" style="width:80px!important">
                    <form:options items="${diList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
            </tr>
            <tr>
                <td class="label">货物邮件</td>
                <td><form:select path="cargoMailFlag" title="货物邮件" value="${cargoMailFlag }"
                                 style="width:120px!important">
                    <form:options items="${awbTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td class="label">进港出港</td>
                <td><form:select path="ei" value="${ei }" title="进港出港" style="width:180px!important">
                    <form:options items="${eiList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td class="label">航站</td>
                <td><form:select path="airport" title="航站" value="${airport }" style="width:80px!important">
                    <form:options items="${airportList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
            </tr>
            <tr>
                <td class="label">货站</td>
                <td><form:input path="opeStation" class="inputText autoUpper"
                                style="width: 120px !important;" maxlength="6" type="text"/></td>
                <td class="label">备注</td>
                <td colspan="2"><form:input path="remark" class="inputText autoUpper"
                                            style="width: 235px !important;" maxlength="50" type="text"/></td>
                <td><form:button id="btnSave" onclick="return doSave()" value="保存"
                                 style="width:75px;margin-right:15px">保存</form:button></td>

            </tr>

        </table>
    </form:form>
</div>
</body>
</html>