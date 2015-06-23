<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>计费规则-代理人费用规则维护</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/agt/agt_rate_list.js")}
</head>
<body class="Common" style="min-width: 960px">
<h3 class="fTitle">代理人费用规则维护</h3>
<input type="hidden" value="${agree.agentCode}" name="hAgentCode" id="hAgentCode" />
<input type="hidden" value="${agree.recId}" name="hAgreeId" id="hAgreeId" />
<form:form modelAttribute="queryDto"
           action="rule/agent/fee/list.do" method="post" id="frmQuery">
    <div class="formContainer">
        <table class="table-form" style="width: auto!important;" align="center">
            <tbody>
            <tr>
                <td class="label">代理人简称</td>
                <td><form:input path="agentCode" class="inputText autoUpper"
                                style="width: 40px !important;" type="text" maxlength="3"/>
                </td>
                <td>
                    <form:input path="agentName" class="inputText autoUpper" disabled="true"
                                style="width: 200px !important;" type="text"/>
                </td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询"
                                 style="width:65px">查询</form:button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <h3 class="fLine">代理人协议详情</h3>

    <div class="formContainer">
        <table class="table-form" style="width:auto!important;" align="center">
            <tbody>
            <tr>
                <td class="label">协议代码</td>
                <td><form:select path="agreeCode" style="width: 90px !important;"
                                 onchange="return doAgreeChange(this)">
                    <form:options items="${agreeTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select>
                </td>
                <td class="label">协议起始日期</td>
                <td><form:input path="agreeStartDate" type="text" class="inputText " disabled="true"
                                style="width: 80px !important;"/></td>

                <td class="label">协议终止日期</td>
                <td><form:input path="agreeEndDate" type="text" class="inputText" disabled="true"
                                style="width: 80px !important;"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</form:form>

<div class="form" style="clear:both;margin-top:10px!important;padding-top:5px">
    <table class="table-default table-list">
        <thead class="ecolor">
        <tr>
            <th>序号</th>
            <th>规则描述</th>
            <th>费用类型</th>
            <th>费率</th>
            <th>最低收费</th>
            <th>最高收费</th>
            <th>国内国际</th>
            <th>货物邮件</th>
            <th>进港出港</th>
            <th>航站</th>
            <th>货站</th>
            <th>备注</th>
            <th>操作&nbsp;<a href="javascript:void(0);" onclick="doAdd();"
                           id="btnAddRate"
                           style="color:blue;text-decoration:underline;${agreeCount>0?'':'display:none'}">(添加)</a></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${rateList}" varStatus="i">
            <tr>
                <td>${i.index+1}
                    <input name="recId" value="${item.recId}" type="hidden"/>
                    <input name="fkRecId" value="${item.fkAgreeId}" type="hidden"/></td>
                <input name="feeType" value="${item.feeType}" type="hidden"/>
                <td>
                        ${item.feeRuleDsc}
                </td>
                <td>${item.feeDsc}</td>
                <td>${item.rate}</td>
                <td>${item.minPrice}</td>
                <td>${item.maxPrice}</td>
                <td>${f:getDiDesc(item.di)}</td>
                <td>${item.cargoMailFlag=="AWBA"?"货物":(item.cargoMailFlag=="AWBM"?"邮件":"全部")}</td>
                <td>${f:getEiDesc(item.ei)}</td>
                <td>${item.airport=="SHA"?"虹桥":(item.airport=="PVG"?"浦东":"全部")}</td>
                <td>${item.opeStation}</td>
                <td>${item.remark}</td>
                <td><a href="javascript:void(0)"
                       id="btnEdit" class="action-link" onclick="return showDetail(${item.recId})"><span>编辑</span></a>
                    <a href="javascript:void(0)" onclick="return doDelete(${item.recId})"
                       id="btnDelete" class="action-link"><span>删除</span></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>


</body>
</html>
