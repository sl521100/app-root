<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>计费规则-代理人协议</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/agt/agt_agree.js")}
    <script type="text/javascript">
        var pageIndex = "${pageIndex}";
        var pageSize = "${pageSize}";
        var totalPages = "${totalPages}";
        var totalCounts = "${totalCounts}";
    </script>
</head>
<body class="Common" style="min-width: 960px">
<h3 class="fTitle">代理人协议</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="rule/agent/query.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" style="width:auto!important;" align="center">
            <tbody>
            <tr>
                <td class="label">代理人简称</td>
                <td><form:input path="agentCode" class="inputText autoUpper"
                                style="width: 60px !important;" maxlength="3" type="text"/>
                </td>

                <td class="label">协议起止日期</td>
                <td><form:input path="beginDate" type="text" class="inputText Wdate" style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="协议生效开始日期"/><span>—</span><form:input
                        path="endDate" type="text" class="inputText Wdate" style="width: 90px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="协议生效截止日期"/></td>

                <td></td>
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
            <th>代理人简称</th>
            <th>代理人名称</th>
            <th>协议代码</th>
            <th>协议起始日期</th>
            <th>协议结束日期</th>
            <th>备注</th>
            <f:if check="8020">
                <th>操作</th>
            </f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${list}">
            <tr>
                <td>${item.agentCode}</td>
                <td>${item.agentName}</td>
                <td>${item.agreementCode}</td>
                <td><spring:eval expression="item.agreementStartDate"/></td>
                <td><spring:eval expression="item.agreementEndDate"/></td>
                <td>${item.remark}</td>
                <f:if check="8020">
                    <td><a href="javascript:void(0)" onclick="return showDetail(${item.recId})"
                           class="action-link">编辑</a>&nbsp;<a
                            href="javascript:void(0)" onclick="return doDelete(${item.recId})"
                            class="action-link">删除</a>
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