<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货量明细-各航班汇总</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/sharkdetail/flt_flight_sum.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">各航班汇总</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/flt/flightsum/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <table class="table-form" align="left">
            <tbody>
            <tr>
                <td class="label">航班号</td>
                <td><form:input path="carrier"
                                style="width: 28px !important;" maxlength="2" class="inputText autoUpper" type="text"
                                /><form:input
                        path="flightNo"
                        style="width: 50px !important; margin-left: 0px;"
                        class="inputText autoUpper"
                        type="text" maxlength="5"/></td>
                <td class="label">
                    航班日期
                </td>
                <td>
                    <form:input path="beginDate" type="text" class="inputText Wdate" style="width: 80px !important;"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                                require-msg="航班开始日期"/><span>—</span><form:input
                        path="endDate" type="text" class="inputText Wdate" style="width: 80px !important;"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true"
                        require-msg="航班截止日期"/>
                </td>
                <td class="label">
                    统计重量
                </td>
                <td>
                    <form:select path="weightType" style="width: 55px !important;">
                        <form:options items="${weightTypeList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    国内/国际货物
                </td>
                <td>
                    <form:select path="di" style="width: 55px !important;">
                        <form:options items="${diList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    直达/中转
                </td>
                <td>
                    <form:select path="transType" style="width: 65px !important;">
                        <form:options items="${transFlagList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td>
                    <form:checkbox path="calcSecurity" value="Y" label="安检费"/>
                    <form:checkbox path="calcGround" value="Y" label="地面服务费"/>
                </td>
            </tr>
            <tr>
                <td class="label">
                    始发/目的
                </td>
                <td>
                    <form:input path="origin"
                                style="width: 39px !important;" class="inputText autoUpper" type="text"/><form:input
                        path="dest"
                        style="width: 39px !important;"
                        class="inputText autoUpper"
                        type="text"/>
                </td>
                <td class="label">
                    运单
                </td>
                <td>
                    <form:select path="awbType" style="width: 62px !important;">
                        <form:options items="${awbTypeList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                    <form:input path="awbPre"
                                style="width: 40px !important;" maxlength="5" class="inputText" type="text"/><form:input
                        path="awbNo"
                        style="width: 65px !important;"
                        class="inputText"
                        type="text" maxlength="15"/>
                </td>
                <td class="label">
                    进港/出港
                </td>
                <td>
                    <form:select path="ei" style="width: 55px !important;">
                        <form:options items="${eiList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    国内/国际航班
                </td>
                <td>
                    <form:select path="fltDi" style="width: 55px !important;">
                        <form:options items="${diList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">
                    货包机
                </td>
                <td>
                    <form:select path="flightType" style="width: 65px !important;">
                        <form:options items="${flightTypeList}" itemValue="value"
                                      itemLabel="name"/>
                    </form:select>
                </td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询" style="width:65px">查询</form:button>
                    <form:button id="btnExport" onclick="return doExport()" value="导出"
                                 style="width:65px">导出</form:button>
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
            <th>
                航班号
            </th>
            <th>
                航班日期
            </th>
            <th>
                航段
            </th>
            <th>
                目的站
            </th>
            <th>
                飞机号
            </th>
            <th ${(queryDto.calcSecurity=="Y"||queryDto.calcGround=="Y")?"":"style='display:none'"}>
                收费名称
            </th>
            <th>货物件数(件)</th>
            <th ${queryDto.weightType=="GROSS_WEIGHT"?"":"style='display:none'"}>货物毛重(KG)</th>
            <th ${queryDto.weightType=="CHARGE_WEIGHT"?"":"style='display:none'"}>货物计重(KG)</th>
            <th colspan="2" ${queryDto.calcSecurity=="Y"?"":"style='display:none'"}>安检费</th>
            <th colspan="2" ${queryDto.calcGround=="Y"?"":"style='display:none'"}>地面服务费</th>
        </tr>
        <tr ${(queryDto.calcSecurity=="Y" || queryDto.calcGround=="Y") ? "":"style='display:none'"}>
            <td>

            </td>
            <td>

            </td>
            <td>

            </td>
            <td>

            </td>
            <td>

            </td>
            <td ${(queryDto.calcSecurity=="Y"||queryDto.calcGround=="Y")?"":"style='display:none'"}>

            </td>
            <td>

            </td>
            <td ${queryDto.weightType=="GROSS_WEIGHT"?"":"style='display:none'"}>

            </td>
            <td ${queryDto.weightType=="CHARGE_WEIGHT"?"":"style='display:none'"}>

            </td>
            <td ${queryDto.calcSecurity=="Y"?"":"style='display:none'"}>
                收费标准
            </td>
            <td ${queryDto.calcSecurity=="Y"?"":"style='display:none'"}>
                金额
            </td>
            <td ${queryDto.calcGround=="Y"?"":"style='display:none'"}>
                收费标准
            </td>
            <td ${queryDto.calcGround=="Y"?"":"style='display:none'"}>
                金额
            </td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>
                     ${item.carrierFlight}
                </td>
                <td>
                    <spring:eval expression="item.flightDate"/>
                </td>
                <td>
                    ${item.route}
                </td>
                <td>
                        ${item.dest}
                </td>
                <td>
                        ${item.planeNo}
                </td>
                <td ${(queryDto.calcSecurity=="Y"||queryDto.calcGround=="Y")?"":"style='display:none'"}>
                    ${item.flightDate==null?"":(queryDto.calcSecurity=="Y"&&queryDto.calcGround=="Y")?"安检费/地面服务费":(queryDto.calcSecurity=="Y"?"安检费":(queryDto.calcGround=="Y"?"地面服务费":""))}

                </td>
                <td>
                    <spring:eval expression="item.pcs"/>
                </td>
                <td ${queryDto.weightType=="GROSS_WEIGHT"?"":"style='display:none'"}>
                    <spring:eval expression="item.weight"/>
                </td>
                <td ${queryDto.weightType=="CHARGE_WEIGHT"?"":"style='display:none'"}>
                    <spring:eval expression="item.feeWeight"/>
                </td>
                <td ${queryDto.calcSecurity=="Y"?"":"style='display:none'"}>
                    <spring:eval expression="item.securityRate"/>
                </td>
                <td ${queryDto.calcSecurity=="Y"?"":"style='display:none'"}>
                    <spring:eval expression="item.securityFee"/>
                </td>
                <td ${queryDto.calcGround=="Y"?"":"style='display:none'"}>
                    <spring:eval expression="item.groundRate"/>
                </td>
                <td ${queryDto.calcGround=="Y"?"":"style='display:none'"}>
                    <spring:eval expression="item.groundFee"/>
                </td>
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