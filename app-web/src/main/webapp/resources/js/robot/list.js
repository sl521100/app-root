/**
 * Created by jimmy on 2015/6/11.
 */

var assignUrl = baseHref + "robot/assign.do";
var pageUrl = baseHref + "robot/list.do";
var formId = "#frmQuery";

$(document).ready(function () {
    var obj = ylib.parseURL(window.location.href);
    var pAutoRefresh = obj.params["autoRefresh"];
    $("#autoRefresh").removeAttr("checked");
    if (pAutoRefresh!=undefined && pAutoRefresh=="true"){
        $("#autoRefresh").attr("checked","checked");
        setTimeout(function(){
            loading();
            window.location = pageUrl + "?autoRefresh=true";
        },15000);
    }
});

function showLog(billType){
    var winTitle = "账单计算历史";
    if (billType=="FLT_MONTH"){
        winTitle="航空公司月报机器人计算历史记录";
    }
    else if(billType=="FLT_DAY"){
        winTitle="航空公司日报机器人计算历史记录";
    }
    else if(billType=="AGT_DAY"){
        winTitle="代理人日报机器人计算历史记录";
    }
    else  if(billType=="AGT_MONTH"){
        winTitle="代理人月报机器人计算历史记录";
    }
    art.dialog.open(baseHref + 'robot/logQuery/' + billType + '.do', {width: 760, height: 380, title: winTitle});
    return false;
}

function autoRefresh(obj){
    loading();
    if ($(obj).attr("checked")){
        window.location = pageUrl + "?autoRefresh=true";
    }
    else{
        window.location = pageUrl;
    }
}

/**
 * 刷新机器人状态
 */
function refreshStatus() {
    loading();
    window.location = pageUrl;
}

function loading() {
    var loadingHtml = "<div id='_m'></div><div id='_lo'><img src='" + baseHref + "resources/images/common/loading.gif'/><br/>loading...</div>";
    $("body").append(loadingHtml);
}

function unloading() {
    $("#_m").remove();
    $("#_lo").remove();
}

function assign(obj) {
    //CTAS-ROBOT-CALC-SHAMU-FLT-MONTH-620502CA1CFF4CC7BCE74D6829B4E4F1
    var robotId = $(obj).closest("tr").attr("id");
    var t = robotId.split('-');
    var lblfmt = $("#lblFormat");
    var taskBillDate = $("#taskBillDate");
    if (t[5] == "MONTH") {
        lblfmt.html("格式：yyyyMM，例如：201506");
        taskBillDate.attr("maxlength", 6);
        taskBillDate.val(ylib.dateFormat(ylib.addMonth(new Date(), -1), "yyyyMM"));
    }
    else {
        lblfmt.html("格式：yyyyMMdd，例如：20150605");
        taskBillDate.attr("maxlength", 8);
        taskBillDate.val(ylib.dateFormat(ylib.addDay(new Date(), -1), "yyyyMMdd"));
    }

    art.dialog({
        id: 'assignTask',
        padding: 3,
        title: "开始计算",
        content: assignTask,
        fixed: true,
        drag: true,
        resize: false,
        ok: function () {
            var t = $("#taskBillDate");
            if (t.val().length <= 0) {
                alert("请输入账期！");
                t.focus();
                return false;
            }
            $.ajax({
                type: "POST",
                url: assignUrl,
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify({billDate: $("#taskBillDate").val(), robotId: robotId}),
                error: function (xmlHttpRequest, textStatus, errorThrown) {
                    if (textStatus == "timeout") {
                        alert("请求超时，请稍后重试！");
                    } else {
                        alert(textStatus);
                        alert("网络忙，请稍后重试!");
                    }
                },
                success: function (data, textStatus) {
                    if (data.result=="success"){
                        alert("提交成功,请等待计算完成！");
                        //进入自动刷新模式
                        $("#autoRefresh").attr("checked","checked");
                        autoRefresh(document.getElementById("autoRefresh"));
                    }
                    else{
                        alert("提交失败,该机器人暂时不可用，请稍候再试！");
                        refreshStatus();
                    }
                },
                beforeSend: function () {
                    loading();
                },
                complete: function () {
                    unloading();
                }
            });
        },
        cancel: function () {

        },
        close: function () {

        }
    });

    $("#taskBillDate").focus();


}
