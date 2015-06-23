<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>${title }</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    <script type="text/javascript">
        //获取父窗口传过来的变量，测试用
        if (art.dialog.data('result')) {
            document.getElementById('hdResult').value = art.dialog.data('result');
        }

        function doClose() {
            var origin = artDialog.open.origin;
            origin.doArgDialogClose();//约定父窗口，必须有该函数
            art.dialog.close();
        }
    </script>
</head>
<body>
<div class="form" style="padding: 20px;text-align: center">
    <input type="hidden" id="hdResult"/>
    <h1 style="font-size:20px">${msg}</h1>
    <br/>
    <input type="button" value="关闭" onclick="doClose()" style="width:65px"/>
</div>
</body>
</html>