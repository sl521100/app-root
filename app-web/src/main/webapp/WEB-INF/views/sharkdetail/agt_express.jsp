<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-快件货物明细</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/agt_express.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">代理快件信息查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/agt/express/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="center" style="width:auto!important;" border="0">
            <tbody>
            <tr>
                <td class="label">航班号</td>
                <td>
                    <form:input path="fltPre"
                                style="width: 25px !important;" maxlength="2" class="inputText autoUpper"
                                type="text"/><form:input
                        path="fltNo"
                        style="width: 40px !important;"
                        class="inputText autoUpper"
                        type="text" maxlength="5"/>
                    &nbsp;代理人&nbsp; <form:input
                        path="agentCode"
                        style="width: 30px !important;"
                        class="inputText autoUpper"
                        type="text" maxlength="3"/>
                </td>

                <td class="label">运单号</td>
                <td>
                    <form:input path="awbFullNo"
                                style="width: 75px !important;" maxlength="12" class="inputText autoUpper"
                                type="text"/></td>
                <td class="label">
                    货站
                </td>
                <td>
                    <form:input
                            path="opestation"
                            style="width: 55px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/>
                </td>
                <td class="label">
                    航班日期
                </td>
                <td>
                    <form:input path="sDate" type="text" class="inputText Wdate"
                                style="width: 82px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="航班开始日期"/><span>—</span><form:input
                        path="eDate" type="text" class="inputText Wdate" style="width: 82px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="航班截止日期"/>
                </td>
                <td class="label">帐期</td>
                <td><form:select path="billNo" onchange="return billNoChange();" style="width:65px!important">
                    <form:options items="${billList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td >
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
            <th>代理人</th>
            <th>运单号</th>
            <th>航班号</th>
            <th>航班日期</th>
            <th>到达重量</th>
            <th>费用</th>
            <th>货站</th>
        </tr>
        <tr>
            <th>总合计</th>
            <th></th>
            <th></th>
            <th></th>
            <th>${totalWt}</th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.agtCode}</td>
                <td>${item.awbNumber}</td>
                <td>${item.flightNo}</td>
                <td><spring:eval expression="item.flightDate"/></td>
                <td>${item.weight}</td>
                <td>${item.fee}</td>
                <td>${item.opestation}</td>
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