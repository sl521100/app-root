<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/agt/agt_bill_adjust.js")}
    <script type="text/javascript">
        var pageIndex = "${pageIndex}";
        var pageSize = "${pageSize}";
        var totalPages = "${totalPages}";
        var totalCounts = "${totalCounts}";


    </script>
    <title>账单调整-代理人账单调整</title>
</head>
<body style="min-width: 960px">
<div class="form">
    <h3 class="fTitle">代理人账单调整</h3>
</div>
<div class="formContainer">
    <form:form modelAttribute="queryDto"
               action="agt/adjust/list.do" method="post" id="frmQuery">
        <form:hidden path="pageIndex"/>
        <%--<form:hidden path="pageSize" value="50"/>--%>
        <input type="hidden" name="pageSize" id="pageSize" value="50" />
        <table class="table-form" style="width: auto;!important;" align="center">
            <tbody>
            <tr>
                <td><label class="label">代理人</label></td>
                <td><form:input path="agentCode" class="inputText autoUpper"
                                style="width: 60px !important;" type="text"/>
                </td>
                <td><label class="label">国内/国际</label></td>
                <td><form:select path="di" style="width: 60px !important;">
                    <form:options items="${diList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><label class="label">进港/出港</label></td>
                <td><form:select path="ei" value="${ei }" style="width: 60px !important;">
                    <form:options items="${eiList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td><label class="label">费用类型</label></td>
                <td><form:select path="feeType"
                                 style="width:120px !important;" value="${feeType }">
                    <form:options items="${feeTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><label class="label">帐期</label></td>
                <td><form:select path="billDate">
                    <form:options items="${billList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td>
                    <form:button id="btnQueryAgtFee" onclick="return doQuery()" value="查询"
                                 style="width:65px">查询</form:button>
                    <f:if check="8050">
                    <form:button id="btnAdd" onclick="return doAdd()" value="添加" style="width:65px">添加</form:button>
                    <form:button id="btnExportExcel" onclick="return exportAgtFee()" value="导出"
                                 style="width:65px;display:none">导出</form:button>
                    </f:if>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>

<div style="clear:both;margin-top:10px!important;padding-top:5px"
     class="form">
    <table class="table-default table-list">
        <thead class="ecolor">
        <tr>
            <th>代理人</th>
            <th>费用类型</th>
            <th>国内国际</th>
            <th>进港出港</th>
            <th>调整金额(元)</th>
            <th>剔除货量</th>
            <th>备注</th>
            <f:if check="8050">
            <th>操作</th>
            </f:if>
        </tr>
        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th>${totalFee}</th>
            <th></th>
            <th></th>
            <f:if check="8050">
            <th></th>
            </f:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${adjustList}">

            <tr>
                <td>${item.agentCode}<input name="recid" value="${item.recid}" type="hidden"/></td>
                <td>${item.feeDesc}</td>
                <td>${f:getDiDesc(item.di)}</td>
                <td>${f:getEiDesc(item.ei)}</td>
                <td>${item.fee }</td>
                <td>${item.isDeduct=="Y"?"是":""}</td>
                <td>${item.remark}</td>
                <f:if check="8050">
                <td><a href="#" onclick="return showDetail(${item.recid})" id="btnEdit"
                       class="action-link"><span>编辑</span></a>
                    <a href="#" onclick="return doDelete(${item.recid})"
                       id="btnDelete" class="action-link"><span>删除</span></a>
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