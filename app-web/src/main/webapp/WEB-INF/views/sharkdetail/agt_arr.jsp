<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-运抵申报货物查询</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/agt_arr.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">运抵申报货物查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/flt/arr/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="center" style="width:760px">
            <tbody>
            <tr>
                <td class="label">
                    代理人
                </td>
                <td>
                    <form:input
                            path="agentCode"
                            style="width: 30px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="3"/>
                </td>
                <td class="label">航班号</td>
                <td>
                    <form:input
                            path="fltNo"
                            style="width: 45px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="7"/></td>
                <td class="label">运单号</td>
                <td>
                    <form:input
                            path="awbFullNo"
                            style="width: 80px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="12"/></td>
                <td class="label">
                    分单号
                </td>
                <td>
                    <form:input
                            path="hawbNo"
                            style="width: 65px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/>
                </td>
                <td class="label">
                    保存时间
                </td>
                <td>
                    <form:input path="sDate" type="text" class="inputText Wdate"
                                style="width: 85px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="运抵报告保存开始时间"/><span>—</span><form:input
                        path="eDate" type="text" class="inputText Wdate" style="width: 85px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="运抵报告保存截止时间"/>
                </td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询" style="width:60px">查询</form:button>
                    <form:button id="btnExport" onclick="return doExport()" value="导出"
                                 style="width:60px;display:none">导出</form:button>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>


<div class="form" style="clear:both;margin-top:10px!important;padding-top:5px">
    <table class="table-default table-list">
        <thead>
        <tr>
            <th>主单号</th>
            <th>分单号</th>
            <th>运抵报告保存时间</th>
            <th>是否已入海关</th>
            <th>放行件数</th>
            <th>放行重量</th>
            <th>运抵件数</th>
            <th>运抵重量</th>
            <th>操作员账号</th>
            <th>回执内容</th>
            <th>回执时间</th>
            <th>报关编号</th>
            <th>代理人</th>
            <th>航班号</th>
        </tr>
        <tr>
            <th>总合计</th>
            <th></th>
            <th></th>
            <th></th>
            <th>${fxTotalPcs}</th>
            <th>${fxTotalWt}</th>
            <th>${arrTotalPcs}</th>
            <th>${arrTotalWt}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.awbNumber}</td>
                <td>${item.hawbNo}</td>
                <td><spring:eval expression="item.sendTime"/></td>
                <td>${item.incuSdb}</td>
                <td>${item.fxPcs}</td>
                <td>${item.fxWt}</td>
                <td>${item.arrPcs}</td>
                <td>${item.arrWt}</td>
                <td>${item.opId}</td>
                <td>${item.resText}</td>
                <td><spring:eval expression="item.resTime"/></td>
                <td>${item.formId}</td>
                <td>${item.agtCode}</td>
                <td>${item.flightNo}</td>
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