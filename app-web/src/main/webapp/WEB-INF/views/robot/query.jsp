<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>账单计算历史</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/robot/logQuery.js")}
    <script type="text/javascript">
        var pageIndex = "${pageIndex}";
        var pageSize = "${pageSize}";
        var totalPages = "${totalPages}";
        var totalCounts = "${totalCounts}";
    </script>
</head>
<body class="Common">
<h3 class="fTitle" style="display: none">账单计算历史</h3>

<div class="formContainer" style="text-align: center;align-content: center;width:auto!important;">
    <form:form modelAttribute="queryDto"
               action="robot/logList.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="billType"/>
        <%--<form:hidden path="pageSize" value="50"/>--%>
        <input type="hidden" name="pageSize" id="pageSize" value="10"/>
        <table class="table-form" style="width: auto!important;" align="center">
            <tbody>
            <tr>
                <td class="label">账期</td>
                <td><form:input path="billDate" class="inputText autoUpper"
                                style="width: 60px !important;" type="text"/>
                </td>
                <td class="label">用户名</td>
                <td><form:input path="userCode" class="inputText autoUpper"
                                style="width: 60px !important;" type="text"/>
                </td>
                <td class="label">开始时间</td>
                <td><form:input path="beginTime" type="text" class="inputText Wdate" style="width: 85px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/><span>—</span><form:input
                        path="endTime" type="text" class="inputText Wdate" style="width: 85px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/></td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询"
                                 style="width:65px">查询</form:button>
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
            <th>账单类型</th>
            <th>账期</th>
            <th>用户名</th>
            <th>开始时间</th>
            <th>耗时</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.billType}</td>
                <td>${item.billDate}</td>
                <td>${item.userCode}</td>
                <td><spring:eval expression="item.startTime"/></td>
                <td><spring:eval expression="item.elapseTime"/></td>
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

<div id="assignTask" style="display: none;">
    <label>请输入计算账期：</label>
    <input tyep="text" id="taskBillDate" class="inputText" maxlength="8" style="width:70px"/>
    <label id="lblFormat">格式：yyyyMM，例如：201506</label>
</div>

</body>
</html>