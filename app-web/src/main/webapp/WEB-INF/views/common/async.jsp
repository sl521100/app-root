<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>please wait...</title>
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

    $(document).ready(function () {

        /*
         定时轮询执行进度
         */
        timerId = setInterval(function () {
            getStatus();
        }, 1000);
        getStatus();
    });

    /**
     获取执行进度
     */
    function getStatus() {
        var statusUrl = window.location.href + "/status";
        $.get(statusUrl, function (data) {
            if (data == null || data.status == null || data.status == "null") {
                updateStatus("准备中");
                return;
            }
            var status = data.status;
            updateStatus(status);
            var temp = status.split("/");
            if (temp[0] == temp[1]) {
                updateStatus("完成");
                clearInterval(timerId);//停止定时器
                clearStatus();//清理redis缓存
            }
        })
    }

    /**
     * 执行完成后，清理缓存
     */
    function clearStatus() {
        var clearStatusUrl = window.location.href + "/clear";
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

    <h1>当前处理进度：<span style="color:red" id="status">准备中</span></h1>
</div>
</body>
</html>
