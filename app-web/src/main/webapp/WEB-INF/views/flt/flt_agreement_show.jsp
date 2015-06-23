<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>计费规则-航空公司协议维护</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_agree_show.js")}
    <script type="text/javascript">
        var pageIndex = "${pageIndex}";
        var pageSize = "${pageSize}";
        var totalPages = "${totalPages}";
        var totalCounts = "${totalCounts}";
    </script>
</head>
<body class="Common" style="min-width: 960px">
<h3 class="fTitle">航空公司协议维护</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="rule/carrier/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <form:hidden path="agreeType"/>
        <table class="table-form" style="width: 800px!important;" align="center">
            <tbody>
            <tr>
                <td class="label">航空公司代码</td>
                <td><form:input path="carrier" class="inputText autoUpper"
                                style="width: 100px !important;" type="text"/>
                </td>
                <td class="label">协议起始日期</td>
                <td>
                    <form:input path="agreeStartDate" type="text" class="inputText Wdate"
                                style="width: 120px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议起始日期"/></td>
                <td class="label">协议终止日期</td>
                <td>
                    <form:input path="agreeEndDate" type="text" class="inputText Wdate" style="width: 120px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议终止日期"/>
                </td>

                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询"
                                 style="width:65px">查询</form:button>
                    <f:if check="8020">
                        <form:button id="btnAdd" onclick="return doAdd()" value="添加" style="width:65px">添加</form:button>
                    </f:if>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>


<div class="form" style="clear:both;margin-top:10px!important;padding-top:5px">
    <table class="table-default table-list">
        <thead class="ecolor">
        <tr>
            <th>序号</th>
            <th>航空公司代码</th>
            <th>航空公司名称</th>
            <th>协议代码</th>
            <th>协议起始日期</th>
            <th>协议终止日期</th>
            <th>币种</th>
            <th>币种描述</th>
            <th>账单语种</th>
            <th>备注</th>
            <f:if check="8020">
                <th>操作</th>
            </f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${agreeList}" varStatus="i">
            <tr>
                <td>${i.index+1}</td>
                <td>${item.carrierCode}<input name="recid" value="${item.recId}" type="hidden"/></td>
                <td>${item.carrierName}</td>
                <td>${item.agreementCode}</td>
                <td><fmt:formatDate value="${item.agreementStartDate}" type="both" pattern="yyyy-MM-dd"/></td>
                <td><fmt:formatDate value="${item.agreementEndDate}" type="both" pattern="yyyy-MM-dd"/></td>
                <td>${item.currency}</td>
                <td>${item.currencyDsc}</td>
                <td>${item.billLanguage}</td>
                <td>${item.remark}</td>
                <f:if check="8020">
                    <td><a href="javascript:void(0)"
                           id="btnEdit" class="action-link"
                           onclick="return showDetail(${item.recId})"><span>编辑</span></a>
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