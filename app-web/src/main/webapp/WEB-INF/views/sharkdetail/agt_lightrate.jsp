<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-短驳货物明细</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/agt_lightrate.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">短驳信息查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/agt/lightrate/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="center" style="width:auto!important;">
            <tbody>

            <tr>
                <td class="label">
                    代理人
                </td>
                <td>
                    <form:input
                            path="agentCode"
                            class="inputText autoUpper"
                            type="text" maxlength="15" cssStyle="width: 50px"/>
                </td>
                <td class="label">
                    进港/出港
                </td>
                <td>
                    <form:select path="ei">
                        <form:options items="${eiList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">航班号</td>
                <td>
                    <form:input
                        path="fltNo" style="width:50px!important"
                        class="inputText autoUpper"
                        type="text" maxlength="7"/></td>

                <td class="label">
                    航班日期
                </td>
                <td>
                    <form:input path="sDate" type="text" class="inputText Wdate"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                style="width:80px!important"
                                require-msg="航班开始日期"/><span>—</span><form:input
                        path="eDate" type="text" class="inputText Wdate" style="width:80px!important"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="航班截止日期"/>

                </td>

                <td class="label">帐期</td>
                <td><form:select path="billNo" onchange="return billNoChange();">
                    <form:options items="${billList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
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
            <th>代理人</th>
            <th>进出港</th>
            <th>驳运单号</th>
            <th>航班号</th>
            <th>日期</th>
            <th>驳运车次</th>
            <th>金额</th>
            <th>帐期</th>
        </tr>
        <tr>
            <th>总合计</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th>${totalFee}</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.agtCode}</td>
                <td>${f:getEiDesc(item.ei)}</td>
                <td>${item.lightrateNo}</td>
                <td>${item.flightNo}</td>
                <td><spring:eval expression="item.occrTime"/></td>
                <td>${item.lightrateSeq}</td>
                <td>${item.fee}</td>
                <td><spring:eval expression="item.billDate"/></td>
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