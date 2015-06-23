<%@ taglib prefix="input" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>基础数据-代理人组信息查询</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/bas/agt_group.js")}
    <script type="text/javascript">
        var pageIndex = ${pageIndex};
        var pageSize = ${pageSize};
        var totalPages = ${totalPages};
        var totalCounts = ${totalCounts};
    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">
<h3 class="fTitle">代理人组信息查询</h3>

<div class="formContainer">
    <form:form modelAttribute="queryDto" action="ud/agtgroup/query.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <form:hidden path="pageSize"/>
        <form:hidden path="recId"/>
        <table class="table-form" align="center" style="width: auto;!important;">
            <tbody>
            <tr>
                <td class="label">组代码</td>
                <td>
                    <form:input path="partitionId" style="width: 50px !important; margin-left: 0px;"
                                class="inputText" type="text"/>
                </td>
                <td class="label">组名(中文)</td>
                <td>
                    <form:input path="groupNameCn" style="width: 50px !important; margin-left: 0px;"
                                class="inputText" type="text"/>
                </td>
                <td class="label">组名(英文)</td>
                <td>
                    <form:input path="groupNameEn" style="width: 50px !important; margin-left: 0px;"
                                class="inputText" type="text"/>
                </td>
                <td class="label">国内国际</td>
                <td>
                    <form:select path="di" style="width: 105px !important;">
                        <form:options items="${diList}" itemValue="value" itemLabel="name"/>
                    </form:select>
                </td>
                <td class="label">代理人</td>
                <td>
                    <form:input path="agentCode" style="width: 50px !important; margin-left: 0px;"
                                class="inputText autoUpper" type="text" maxlength="5"/>
                </td>
                <td>
                    <form:button id="btnQuery" onclick="return doQuery()" value="查询" style="width:65px">查询</form:button>
                    <f:if check="8010">
                        <form:button id="btnInsert" onclick="return showDetail()" value="新增"
                                     style="width:65px">新增</form:button>
                    </f:if>
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
            <th>分组代码</th>
            <th>组名(中文)</th>
            <th>组名(英文)</th>
            <th>国内国际</th>
            <th>代理人</th>
            <f:if check="8010">
                <th>操作</th>
            </f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${data}">
            <tr>
                <td>${item.partitionId}</td>
                <td>${item.groupNameCn}</td>
                <td>${item.groupNameEn}</td>
                <td>${f:getDiDesc(item.di)}</td>
                <td>${item.agentCode}</td>
                <f:if check="8010">
                    <td>
                        <a href="javascript:void(0)" id="btnEdit" class="action-link"
                           onclick="return showDetail(${item.recId})"><span>编辑</span></a>
                        <a href="#" onclick="return doDelete(${item.recId})" id="btnDelete"
                           class="action-link"><span>删除</span></a>
                        <input type="hidden" name="recId" value='${item.recId}'/>
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
