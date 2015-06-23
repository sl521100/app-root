<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>退出登录</title>
    <style type="text/css">
        body {
            margin: 0;
            padding: 20px 50px;
            font-family: "Microsoft YaHei", "微软雅黑", "宋体";
            background-color: #FFFFFF;
        }

        hr {
            margin-top: 1px;
            height: 1px;
            background-color: #000000;
        }

        .table_notice {
            width: 980px;
            font-size: 16px !important;
            border-spacing: 0px;
            border-collapse: separate;
        }

        .tr_title {
            height: 30px;
            line-height: 30px;
        }

        .tr_title td {
            border-bottom: 1px dotted #CCCCCC;
        }

        .a_title {
            text-decoration: none;
            outline: none;
        }

        .a_title, a.a_title:HOVER, a.a_title:VISITED {
            color: #0000FF;
        }

        div.div_content {
            word-wrap: break-word;
            word-break: break-all;
            overflow: hidden;
            width: 970px;
        }

        h2 {
            font-size: 20px;
            font-weight: bold
        }
    </style>
</head>
<body>
<h2 style="margin:0px;margin-top: 20px;padding: 0px;">请稍候</h2>
<hr>
<table class="table_notice">
    <span style='font-size:18px!important'>正在安全退出系统...</span>
</table>

<iframe src="${appLogoutUrl}" style="display:none"></iframe>

<iframe src="${ssoLogoutUrl}" style="display:none"></iframe>
</body>
</html>