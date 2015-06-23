<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>文件列表</title>
</head>
<body>
<ul>
    <c:forEach var="item" items="${keys}" varStatus="status">
        <li>${status.index+1}
            &nbsp;<span ${item.isDirectory()?"style='color:#ccc'":""}>${item.path}</span>&nbsp;&nbsp;<a
                    href="javascript:void(0)"
                    style="display: none"
                    onclick="delFile('${item.path}')"><span
                    class="bill-item-trial">删除</span></a></li>
    </c:forEach>

</ul>
</body>
</html>