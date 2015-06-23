<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2015/3/26
  Time: 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>计费规则-航空公司费用规则维护</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_rate_show.js")}
    <script type="text/javascript">
        var pageIndex = "${pageIndex}";
        var pageSize = "${pageSize}";
        var totalPages = "${totalPages}";
        var totalCounts = "${totalCounts}";
    </script>
</head>
<body class="Common" style="min-width: 960px">
<h3 class="fTitle">航空公司费用规则维护</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="rule/carrier/fee/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <form:hidden path="agreeCode"/>
        <table class="table-form" style="width: 380px!important;" align="center">
            <tbody>
            <tr>
                <td class="label">航空公司代码</td>
                <td><form:input path="carrier" class="inputText autoUpper"
                                style="width: 60px !important;" type="text"/>
                </td>
                <td>
                    <form:input path="carrierName" class="inputText autoUpper" disabled="true"
                                style="width: 150px !important;" type="text"/>
                </td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询"
                                 style="width:65px">查询</form:button>

                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>
<h3 class="fLine">航空公司协议详情</h3>

<div class="formContainer">
    <%--<form:form modelAttribute="agree" action="rule/carrier/fee/list.do" method="post" id="frmRateQuery">--%>
    <table class="table-form" style="width:750px" id="tbAgree">
        <tbody>
        <tr>

            <td class="label">协议代码</td>
            <td><form:select path="agree.agreementCode" style="width: 90px !important;"
                             onchange="return agreeChange(this)">
                <form:options items="${agreeTypeList}" itemValue="value"
                              itemLabel="name"/>
            </form:select><input name="agree.carrierCode" value="${agree.carrierCode}" type="hidden"/>
                <form:hidden path="agree.recId"/>
            </td>

            <td class="label">协议起始日期</td>
            <td><form:input path="agree.agreementStartDate" type="text" class="inputText " disabled="true"
                            style="width: 80px !important;"/></td>

            <td class="label">协议终止日期</td>
            <td><form:input path="agree.agreementEndDate" type="text" class="inputText" disabled="true"
                            style="width: 80px !important;"/></td>
            <td class="label">账单币种</td>
            <td><form:input path="agree.currency" class="inputText autoUpper" disabled="true"
                            style="width:65px !important;"
                            type="text"/>
            </td>

            <td class="label">账单语种</td>
            <td><form:input path="agree.billLanguage" class="inputText autoUpper" disabled="true"
                            style="width:60px !important;"
                            type="text"/>
            </td>
        </tr>
        </tbody>
    </table>
    <%--</form:form>--%>
</div>

<div class="form" style="clear:both;margin-top:10px!important;padding-top:5px">
    <table class="table-default table-list">
        <thead class="ecolor">
        <tr>
            <th>序号</th>
            <th>规则描述</th>
            <th>费用类型</th>
            <th>计费方式</th>
            <th>费率</th>
            <th>国内国际</th>
            <th>客机/货机</th>
            <th>货物邮件</th>
            <th>中转直达</th>
            <th>中转类型</th>
            <th>进港出港</th>
            <th>航站</th>
            <th>货站</th>
            <f:if check="8020">
            <th>操作&nbsp;<a href="javascript:void(0);" onclick="doAdd();"
                           id="btnAddRate"
                           style="color:blue;text-decoration:underline;${agreeCount>0?'':'display:none'}">(添加)</a></th></f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${rateList}" varStatus="i">
            <tr>
                <td>${i.index+1}</td>
                <td>
                        ${item.feeRuleDsc}
                    <input name="recId" value="${item.recId}" type="hidden"/>
                    <input name="fkRecId" value="${item.fkAgreeId}" type="hidden"/>
                </td>
                <td><input name="feeType" value="${item.feeType}" type="hidden"/>${item.feeDsc}</td>
                <td><input name="rateType" value="${item.rateType}" type="hidden"/>${item.rateDsc}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.rateType=='B'}">
                            ${item.rateDsc}
                            <a href='#' id='btnRateRuleEdit' class='action-link'
                               onclick='return showRateRuleDetail(${item.recId})'><span>详情</span></a>
                        </c:when>
                        <c:otherwise>
                            ${item.rate}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${f:getDiDesc(item.di)}</td>
                <td>${item.fltMode=="A"?"货机":(item.fltMode=="C"?"客机":"全部")}</td>
                <td>${item.cargoMailFlag=="AWBA"?"货物":(item.cargoMailFlag=="AWBM"?"邮件":"全部")}</td>
                <td>${item.trainsFlag=="T"?"中转":(item.trainsFlag=="D"?"直达":"全部")}</td>
                <td>${f:getTranstypeDesc(item.trainsType)}</td>
                <td>${f:getEiDesc(item.ei)}</td>
                <td>${item.airport=="SHA"?"虹桥":(item.airport=="PVG"?"浦东":"全部")}</td>
                <td>${item.opeStation}</td>
                <f:if check="8020">
                <td><a href="javascript:void(0)"
                       id="btnEdit" class="action-link" onclick="return showDetail(${item.recId})"><span>编辑</span></a>
                    <a href="javascript:void(0)" onclick="return doDelete(${item.recId})"
                       id="btnDelete" class="action-link"><span>删除</span></a>
                </td>
                </f:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <table style="width:99%;margin:10px auto">
        <tr>
            <td>
                <div id="page-box"></div>
            </td>
            <td width="40%" style="text-align:right;vertical-align:middle" id="page-info">
            </td>
        </tr>
    </table>

</div>


</body>
</html>
