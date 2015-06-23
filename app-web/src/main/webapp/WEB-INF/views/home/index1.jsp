<%@ taglib prefix="input" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>欢迎开始</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/bas/agt_group.js")}
    <script type="text/javascript">

    </script>
</head>
<body class="Common" style="min-width: 960px;height:100%">


<div class="formContainer">
    <h3 class="fTitle">主页面 -> ${userName}</h3>
</div>
</body>
</html>
