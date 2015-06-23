<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>账单开账-机器人列表</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/robot/list.js")}
</head>
<body class="Common" style="min-width: 960px">
<h3 class="fTitle">机器人监控列表</h3>

<div class="formContainer" style="text-align: center;align-content: center">
    <a href="javascript:void(0)" class="action-link" onclick="showLog('AGT_MONTH')">代理人月报机器人计算历史记录</a>&nbsp;|&nbsp;
    <a href="javascript:void(0)" class="action-link" onclick="showLog('AGT_DAY')">代理人日报机器人计算历史记录</a>&nbsp;|&nbsp;
    <a href="javascript:void(0)" class="action-link" onclick="showLog('FLT_MONTH')">航空公司月报机器人计算历史记录</a>&nbsp;|&nbsp;
    <a href="javascript:void(0)" class="action-link" onclick="refreshStatus()">刷新机器人状态</a>
    &nbsp;<input type="checkbox" value="true" id="autoRefresh" onclick="autoRefresh(this)" /><label for="autoRefresh">自动刷新</label>
</div>
<div class="form" style="clear:both;margin-top:10px!important;padding-top:5px">
    <table class="table-default table-list">
        <thead class="ecolor">
        <tr>
            <th>机器人名称</th>
            <th>机器人ID</th>
            <th style="display: none">服务器信息</th>
            <th>启动时间</th>
            <th>最后报告时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${list}">
            <tr id="${item.robotId}">
                <td>${item.robotName}</td>
                <td>${item.robotUUID}</td>
                <td style="display: none">${item.serverIP}&nbsp;/&nbsp;${item.serverHostName}</td>
                <td><spring:eval expression="item.startTime"/></td>
                <td><spring:eval expression="item.lastReportTime"/></td>
                <td>${item.taskStatus }</td>
                <td>${item.canAssignTask?"<a href=\"javascript:void(0)\" id=\"btnStart\" class=\"action-link\" onclick=\"assign(this)\"><span>开始计算</span></a>":""}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div id="assignTask" style="display: none;">
    <label>请输入计算账期：</label>
    <input tyep="text" id="taskBillDate" class="inputText" maxlength="8" style="width:70px" />
    <label id="lblFormat">格式：yyyyMM，例如：201506</label>
</div>

</body>
</html>