<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Exception e = (Exception) request.getAttribute("ex");
%>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>ERROR</title>
</head>
<body style="margin:20px">
<H2>
    错误：<%=e.getClass().getSimpleName()%>
</H2>
<hr/>
<P>
    <strong>错误描述：</strong><%=e.getMessage()%>
</P>

<P>
    <strong>详细信息：</strong>
</P>
    <pre>
    <%
        e.printStackTrace(new java.io.PrintWriter(out));
    %>
    </pre>
</body>
</html>