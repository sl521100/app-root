/**
 * Created by Jacob on 2015/4/3.
 */

var exportUrl = baseHref + "detail/agt/lightrate/export.do";
var listUrl = baseHref + "detail/agt/lightrate/list.do";
var formId = "#frmQuery";

$(document).ready(function () {

    $("#page-box").pagination({
        items: totalCounts,
        itemsOnPage: pageSize,
        currentPage: pageIndex,
        cssStyle: 'light-theme',
        prevText: '<',
        nextText: '>',
        onPageClick: function (page) {
            return gotoPage(page);
        }
    });
    showPageInfo();

});

function gotoPage(page) {
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()) {
        return false;
    }
    $("#pageIndex").val(page);
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

function showPageInfo() {
    $("#page-info").html(pageSize + "条/页，共" + totalCounts + "条，第" + pageIndex + "页，共" + totalPages + "页");
}

function doQuery() {
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()) {
        return false;
    }
    var id = "#btnQuery";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

function doExport() {
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()) {
        return false;
    }
    $(formId).attr("target", "_blank").attr("action", exportUrl).submit();
    return false;
}

function checkQueryDateIntervals() {
    var startDateId = "#beginOperateDate";
    var endDateId = "#endOperateDate";
    var intervals = Math.abs(ylib.dayMinus(ylib.str2date($(endDateId).val()), ylib.str2date($(startDateId).val())));
    if (intervals >= 90) {
        alert("查询时间段不能超过90天！");
        $(endDateId).focus().select();
        return false;
    }
    return true;
}

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function NewDate(str) {
    str = str.split('-');
    var date = new Date();
    date.setUTCFullYear(str[0], str[1] - 1, str[2]);
    date.setUTCHours(0, 0, 0, 0);
    return date;
}
function billNoChange() {
    var billNo = $("#billNo").val();
    billNo = billNo.substr(0, 4) + "-" + billNo.substr(4)+"-01";
    var billDate = NewDate(billNo);
    //

    var startDate = new Date(billDate);
    var endDate = new Date(billDate);

    //startDate = new Date(new Date().setDate(billDate.getDate()));
    // 当前月份的下个月份
    var nextM = new Date(endDate.setMonth(startDate.getMonth() + 1));
    endDate = new Date(endDate.setDate(nextM.getDate() - 1));
    // endDate.setDate(endDate.getDate() - 1);

    var sDateObj = $("#sDate");
    var eDateObj = $("#eDate");

    $(sDateObj).val(startDate.Format("yyyy-MM-dd"));
    $(eDateObj).val(endDate.Format("yyyy-MM-dd"));

}
