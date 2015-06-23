<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-仓储收费货量明细查询</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/agt_stock.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">仓储收费货物查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/flt/stock/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="center" style="width:auto!important;" border="0">
            <tbody>
            <tr>
                <td class="label">
                    机场
                </td>
                <td>
                    <form:select path="airdrome"  style="width: 80px !important;">
                        <form:options items="${airdromeList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>

                <td class="label">
                    收费日期
                </td>
                <td colspan="3">
                    <form:input path="sDate" type="text" class="inputText Wdate"
                                style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="收费开始日期"/><span>—</span><form:input
                        path="eDate" type="text" class="inputText Wdate" style="width: 90px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="收费截止日期"/>

                </td>
                <td class="label">
                    代理人组
                </td>
                <td>
                    <form:select path="agtGroup" style="width: 125px !important;">
                        <form:options items="${agtGroupList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    代理人
                </td>
                <td>
                    <form:input
                            path="agentCode"
                            style="width: 45px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    结算方式
                </td>
                <td>
                    <form:select path="payMode" style="width: 80px !important;">
                        <form:options items="${paymodeList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    国内/国际
                </td>
                <td>
                    <form:select path="di" style="width: 80px !important;">
                        <form:options items="${diList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>

                <td class="label">
                    运单类型
                </td>
                <td>
                    <form:select path="awbType" style="width: 55px !important;">
                        <form:options items="${stockAwbtype}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>

                <td class="label">运单号</td>
                <td>
                   <form:input
                        path="awbNo"
                        style="width: 120px !important;"
                        class="inputText autoUpper"
                        type="text" maxlength="12"/></td>
                <td colspan="2" align="right">
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
            <th>代理</th>
            <th>收费凭证号</th>
            <th>运单号</th>
            <th>分单号</th>
            <th>机场</th>
            <th>库区</th>
            <th>仓库</th>
            <th>柜台</th>
            <th>件数(件)</th>
            <th>重量(KG)</th>
            <th>仓储费(￥)</th>
            <th>航班号</th>
            <th>进港日期</th>
            <th>收费日期</th>
            <th>出库日期</th>
        </tr>
        <tr>
            <th>总合计</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th>${totalPcs}</th>
            <th>${totalWt}</th>
            <th>${totalFee}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.agtCode}</td>
                <td>${item.chargeNo}</td>
                <td>${item.awbNumber}</td>
                <td>${item.hawbNo}</td>
                <td>${item.airdromeName}</td>
                <td>${item.areaName}</td>
                <td>${item.storeHouse}</td>
                <td>${item.deptName}</td>
                <td>${item.pcs}</td>
                <td>${item.weight}</td>
                <td>${item.fee}</td>
                <td>${item.flightNo}</td>
                <td><spring:eval expression="item.importTime"/></td>
                <td><spring:eval expression="item.receiveTime"/></td>
                <td><spring:eval expression="item.outTime"/></td>
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