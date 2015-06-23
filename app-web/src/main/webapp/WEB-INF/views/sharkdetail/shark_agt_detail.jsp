<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <%@ include file="/WEB-INF/views/common/meta.jsp" %>
  <title>货量明细-代理人货量明细查询</title>
  ${f:addCss("resources/css/form.css")}
  ${f:addCss("resources/css/tableform.css")}
  ${f:addCss("resources/css/ctas.css")}
  ${f:addJs("resources/js/sharkdetail/shark_agt_detail.js")}
  <script type="text/javascript">
    var pageIndex = ${pageIndex};
    var pageSize = ${pageSize};
    var totalPages = ${totalPages};
    var totalCounts = ${totalCounts};
  </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
  <h3 class="fTitle">代理人货量明细查询</h3>
  <div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="detail/agt/sharkagt/list.do" method="post" id="frmQuery">
      <form:hidden path="pageIndex" />
      <form:hidden path="pageSize" />
      <table class="table-form" align="left" style="width: 1000px;">
        <tbody>
          <tr>
            <td class="label">航班号</td>
            <td>
              <form:input path="carrier" style="width: 28px !important;" maxlength="2"
                    class="inputText autoUpper" type="text" require="true" require-msg="承运人"/>
              <form:input path="flightNo" style="width: 50px !important; margin-left: 0px;"
                    class="inputText autoUpper" type="text" maxlength="5"/>
            </td>
            <td class="label">航班日期</td>
            <td>
              <form:input path="beginDate" type="text" class="inputText Wdate" style="width: 80px !important;"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true" require-msg="航班开始日期"/><span>—</span>
              <form:input path="endDate" type="text" class="inputText Wdate" style="width: 80px !important;"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="true" require-msg="航班截止日期"/>
            </td>
            <td class="label">始发/目的</td>
            <td>
              <form:input path="origin" style="width: 39px !important;"
                    class="inputText autoUpper" type="text"/>
              <form:input path="dest" style="width: 39px !important;"
                    class="inputText autoUpper" type="text"/>
            </td>
            <td class="label">国内/国际</td>
            <td>
              <form:select path="di" style="width: 55px !important;">
                <form:options items="${diList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
            <td class="label">指定/非指定</td>
            <td>
              <form:select path="isAgent" style="width: 55px !important;">
                <form:options items="${isAgentTypeList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
            <td class="label">类型</td>
            <td>
              <form:select path="awbType" style="width: 55px !important;">
                <form:options items="${awbTypeList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
          </tr>
          <tr>
            <td class="label">进港/出港</td>
            <td>
              <form:select path="ei" style="width: 55px !important;">
                <form:options items="${eiList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
            <td class="label">代理人</td>
            <td>
              <form:input path="agent" style="width: 80px !important;"
                    class="inputText autoUpper" type="text" />
            </td>
            <td class="label">代理人组</td>
            <td>
              <form:select path="agtGroup" style="width: 60px !important;">
                <form:options items="${agentPartitionList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
            <td class="label">运单号</td>
            <td>
              <form:input path="awbPre" style="width: 39px !important;"
                    class="inputText autoUpper" type="text"/>
              <form:input path="awbNo" style="width: 60px !important;"
                    class="inputText autoUpper" type="text"/>
            </td>
            <td class="label">帐期</td>
            <td>
              <form:select path="billDate" id="billDate" style="width: 70px !important;" onchange="setDateByBillDate();">
                <form:options items="${billDateList}" itemValue="value" itemLabel="name"/>
              </form:select>
            </td>
            <td colspan="2">
              <form:button id="btnQuery" onclick="return doQuery()" value="查询" style="width:65px">查询</form:button>
              <form:button id="btnExport" onclick="return doExport()" value="导出" style="width:65px">导出</form:button>
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
          <th>代理人</th>
          <th>操作代理人</th>
          <th>件数</th>
          <th>重量(公斤) </th>
          <th>航班号</th>
          <th>航班日期</th>
          <th>始发站</th>
          <th>目的站</th>
          <th>备注</th>
          <th>国内海关监管</th>
          <th>费用</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="item" items="${data}">
          <tr>
            <td>${item.awbNo}</td>
            <td>${item.agent}</td>
            <td>${item.handleagent}</td>
            <td>${item.pcs}</td>
            <td>${item.weight}</td>
            <td>${item.flightNo}</td>
            <td><spring:eval expression="item.flightDate"/></td>
            <td>${item.origin}</td>
            <td>${item.dest}</td>
            <td>${item.remark}</td>
            <td>${item.customCtl}</td>
            <td>${item.fee}</td>
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
