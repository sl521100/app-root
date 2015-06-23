<%--
  Created by IntelliJ IDEA.
  User: Jacob
  Date: 2015/3/27
  Time: 13:24
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
    ${f:addJs("resources/js/flt/flt_raterule_show.js")}
</head>
<body>
<div class="form">
    <input name="rateId" value="${rateId}" type="hidden"/>
    <table class="table-default table-list " style="width:750px">
        <thead class="ecolor">
        <tr>
            <th>序号</th>
            <th>起始重量</th>
            <th>结束重量</th>
            <th>最低收费</th>
            <th>费率</th>
            <th>开始生效日期</th>
            <th>结束生效日期</th>
            <th>备注</th>
            <f:if check="8020">
                <th>操作&nbsp;<a href="javascript:void(0);" onclick="doAddRule(${rateId});"
                               id="btnAddRateRule" style="color:blue;text-decoration:underline;">(添加)</a></th>
            </f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${rateList}" varStatus="i">
            <tr>
                <td>${i.index+1}
                    <input name="recId" value="${item.recId}" type="hidden"/>
                    <input name="fkFltRateId" value="${item.fkFltRateId}" type="hidden"/>
                </td>
                <td>${item.minSigns}${item.minWeight}</td>
                <td>${item.maxSigns}${item.maxWeight}</td>
                <td>${item.minPrice}</td>
                <td>${item.rate}</td>
                <td><fmt:formatDate value="${item.startDate}" type="both" pattern="yyyy-MM-dd"/></td>
                <td><fmt:formatDate value="${item.endDate}" type="both" pattern="yyyy-MM-dd"/></td>
                <td>${item.remark}</td>
                <f:if check="8020">
                    <td><a href="#"
                           id="btnEdit" class="action-link"
                           onclick="return showDetail(${item.recId})"><span>编辑</span></a>
                        <a href="#" onclick="return doDelete(${item.recId})"
                           id="btnDelete" class="action-link"><span>删除</span></a>
                    </td>
                </f:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <label style="float:right;padding-top: 10px;${rateList.size()==0?'display:none;':''}"><span
            style="font-weight: bold">费用计算公式</span><span>=${formula}</span></label>
</div>
</body>
</html>

