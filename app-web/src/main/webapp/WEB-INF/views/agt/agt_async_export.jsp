<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>请稍后...</title>
    <style type="text/css">
        #msgBox {
            width: 400px;
            height: 80px;
            border: solid 1px #ccc;
            position: absolute;
            top: 38%;
            left: 50%;
            margin-left: -200px;
            margin-top: -50px;
            text-align: center;
            vertical-align: middle;
            padding-top: 20px;
            font-size: 16px;
        }

        #msgBox h1 {
            line-height: 35px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<script type="text/javascript" language="JavaScript">

    var timerId = null;//定时器ID
    var statusUrl = baseHref + "agtbill/detail/async/export/status";
    var clearUrl = baseHref + "agtbill/detail/async/export/clear";
    var downloadUrl = window.location.href.replace("export", "download");


    $(document).ready(function () {

        var key = $("#hidKey").val();
        statusUrl = statusUrl + "?key=" + key;
        clearUrl = clearUrl + "?key=" + key;
        /*
         定时轮询执行进度
         */
        timerId = setInterval(function () {
            getStatus(key);
        }, 1000);
        getStatus(key);
    });

    /**
     获取执行进度
     */
    function getStatus(key) {

        $.get(statusUrl, function (data) {
            if (data == null || data.status == null || data.status == "null") {
                updateStatus("准备中");
                return;
            }
            var status = data.status;
            updateStatus(status);
            var temp = status.split("/");
            if (temp[2] != null && temp[2] == 'NODATA') {
                updateStatus("完成(不存在代理人账单数据)");

                clearInterval(timerId);//停止定时器
                clearStatus(key);//清理redis缓存
            } else {
                if (temp[0] == temp[1]) {
                    updateStatus("完成");
                    clearInterval(timerId);//停止定时器
                    window.location = downloadUrl;
                    clearStatus(key);//清理redis缓存
                }
            }
        })
    }

    /**
     * 执行完成后，清理缓存
     */
    function clearStatus(key) {

        $.get(clearStatusUrl, function (data) {
            //alert(data.status);
        })
    }

    /**
     更新进度显示
     */
    function updateStatus(msg) {
        $("#status").html(msg);
    }
</script>
<div id="msgBox">
    <span>请稍候，服务器正在处理中...</span>
    <input type="hidden" id="hidKey" value="${key}"/>

    <h1>当前处理进度：<span style="color:red" id="status">准备中</span></h1>
</div>
</body>
</html>
