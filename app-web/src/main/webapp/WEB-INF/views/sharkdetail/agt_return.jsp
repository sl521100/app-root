<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-退货明细查询</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/agt_return.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">退货明细查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/flt/return/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="center" style="width:760px">
            <tbody>
            <tr>
                <td class="label">
                    登记日期
                </td>
                <td>
                    <form:input path="beginOperateDate" type="text" class="inputText Wdate"
                                style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="登记开始日期"/><span>—</span><form:input
                        path="endOperateDate" type="text" class="inputText Wdate" style="width: 90px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="登记截止日期"/>
                </td>

                <td class="label">
                    填开代理人
                </td>
                <td>
                    <form:input
                            path="issuingAgent"
                            style="width: 65px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/>
                </td>

                <td class="label">
                    始发站
                </td>
                <td>
                    <form:input path="origin"
                                style="width: 55px !important;" class="inputText autoUpper" type="text"/>
                </td>
                <td class="label">运单类型</td>
                <td><form:select path="awbType" style="width: 55px !important;">
                    <form:options items="${awbTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select>
                    <form:input path="awbPre"
                                style="width: 46px !important;" maxlength="5" class="inputText autoUpper"
                                type="text"/><form:input
                            path="awbNo"
                            style="width: 72px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/></td>

            </tr>
            <tr>
                <td class="label">
                    退货日期
                </td>
                <td>
                    <form:input path="beginReturnDate" type="text" class="inputText Wdate"
                                style="width: 90px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="退货开始日期"/><span>—</span><form:input
                        path="endReturnDate" type="text" class="inputText Wdate" style="width: 90px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="退货截止日期"/>

                </td>
                <td class="label">
                    操作代理人
                </td>
                <td>
                    <form:input
                            path="handlingAgent"
                            style="width: 65px !important;"
                            class="inputText autoUpper"
                            type="text" maxlength="15"/>
                </td>


                <td class="label">
                    已撤销
                </td>
                <td>
                    <form:select path="isCancel" style="width: 57px !important;">
                        <form:options items="${cancelList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    国内/国际
                </td>
                <td>
                    <form:select path="di" style="width: 55px !important;">
                        <form:options items="${diList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询" style="width:60px">查询</form:button>
                    <form:button id="btnExport" onclick="return doExport()" value="导出"
                                 style="width:60px">导出</form:button>
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
            <th>运单号</th>
            <th>品名</th>
            <th>运单<br/>件数</th>
            <th>运单<br/>重量</th>
            <th>退货<br/>件数</th>
            <th>退货<br/>重量</th>
            <th>退货客户名称</th>
            <th>退货原因</th>
            <th style="display:none">备注</th>
            <th>登记时间</th>
            <th style="display: none">登记人</th>
            <th style="display: none">登记营业点</th>
            <th>是否<br/>撤销</th>
            <th style="display: none">撤销人</th>
            <th style="display: none">撤销时间</th>
            <th style="display: none">撤销营业点</th>
            <th>起始站</th>
            <th>目的站</th>
            <th style="display: none;">国际国内</th>
            <th>填开<br/>代理人</th>
            <th>操作<br/>代理人</th>
            <th style="display:none">费用</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.awbPre}-${item.awbNo}</td>
                <td>${item.cargoNm}</td>
                <td><spring:eval expression="item.awbPcs"/></td>
                <td><spring:eval expression="item.awbWeight"/></td>
                <td>${item.pcs}</td>
                <td>${item.weight}</td>
                <td>${item.shipper}</td>
                <td>${item.returnReason}</td>
                <td style="display: none">${item.remark}</td>
                <td><spring:eval expression="item.opeDate"/></td>
                <td style="display: none">${item.opeMan}</td>
                <td style="display: none">${item.opeDepartId}</td>
                <td>${item.canceled}</td>
                <td style="display:none">${item.canMan}</td>
                <td style="display:none"><spring:eval expression="item.canDate"/></td>
                <td style="display:none">${item.canDepartId}</td>
                <td>${item.awbOrigin}</td>
                <td>${item.awbDest}</td>
                <td style="display:none">${item.di}</td>
                <td>${item.awbIssuingAgent}</td>
                <td>${item.awbHandlingAgent}</td>
                <td style="display:none"><spring:eval expression="item.fee"/></td>
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