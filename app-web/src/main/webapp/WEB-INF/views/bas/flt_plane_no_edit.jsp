<%@ taglib prefix="input" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <%@ include file="/WEB-INF/views/common/meta.jsp" %>
  <title>航空公司飞机号编辑</title>
  ${f:addCss("resources/css/form.css")}
  ${f:addCss("resources/css/tableform.css")}
  ${f:addCss("resources/css/ctas.css")}
  ${f:addJs("resources/js/bas/flt_plane_no.js")}
  <style type="text/css">
    .inputText,select {margin-left: 10px;}
  </style>
</head>
<body class="Common" style="height:100%">
<div class="formContainer" style="width: 250px; margin: 0 auto;padding-top:5%;">
  <form:form modelAttribute="data" action="ud/fltplaneno/save.do" method="post" id="frmEdit">
    <table class="table-form">
      <tbody>
      <tr>
        <td class="label">航空公司代码</td>
        <td>
          <form:input path="carrier" style="width: 80px !important;" require-msg="航空公司代码"
                      class="inputText autoUpper" type="text" require="true" maxlength="3"/>
          <form:hidden path="recId"/>
        </td>
      </tr>
      <tr>
        <td class="label">分公司ID</td>
        <td>
          <form:input path="subCompanyId" style="width: 80px !important;" require-msg="分公司ID"
                      class="inputText autoUpper" type="text" require="true" maxlength="10"/>
        </td>
      </tr>
      <tr>
        <td class="label">分公司名称</td>
        <td>
          <form:input path="subCompanyDsc" style="width: 80px !important;" require-msg="分公司名称"
                      class="inputText autoUpper" type="text" require="true" maxlength="10"/>
        </td>
      </tr>
      <tr>
        <td class="label">飞机号</td>
        <td>
          <form:input path="planeNo" style="width: 80px !important;" require-msg="飞机号"
                      class="inputText autoUpper" type="text" require="true" maxlength="6"/>
        </td>
      </tr>
      <tr>
        <td class="label">执飞开始日期</td>
        <td>
          <form:input path="starDate" style="width: 80px !important;" require-msg="执飞开始日期"
                      class="inputText Wdate" type="text" require="true" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/>
        </td>
      </tr>
      <tr>
        <td class="label">执飞结束日期</td>
        <td>
          <form:input path="endDate" style="width: 80px !important;" require-msg="执飞结束日期"
                      class="inputText Wdate" type="text" require="true" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/>
        </td>
      </tr>
      <tr>
        <td class="label">备注</td>
        <td>
          <form:input path="remark" style="width: 150px !important;"
                      class="inputText" type="text" maxlength="30"/>
        </td>
      </tr>
      <tr>
        <td class="label">飞机类型</td>
        <td>
          <form:select path="planeUseMode" style="width: 80px !important;">
            <form:options items="${planeUseModeList}" itemValue="value" itemLabel="name"/>
          </form:select>
        </td>
      </tr>
      <f:if check="8010">
        <tr>
          <td style="text-align: center;" colspan="2">
            <form:button id="btnSave" onclick="return doSave()" value="保存"
                         style="width:65px">保存</form:button>
          </td>
        </tr>
      </f:if>
      </tbody>
    </table>
  </form:form>
</div>
<script type="text/javascript">
  var errMsg = "${errMsg}";
  if (errMsg != undefined && errMsg != "") {
    alert(errMsg);
    $("#carrier").focus().select();
  }
</script>
</body>
</html>
