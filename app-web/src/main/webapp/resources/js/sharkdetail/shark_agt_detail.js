var exportUrl = baseHref + "detail/agt/sharkagt/export.do";
var listUrl = baseHref + "detail/agt/sharkagt/list.do";

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
    var formId = "#frmQuery";
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()){
        return false;
    }
    $("#pageIndex").val(page);
    loading();
    $(formId).attr("target", "_self").attr("action", listUrl).submit();
    return false;
}

function showPageInfo() {
    $("#page-info").html(pageSize + "条/页，共" + totalCounts + "条，第" + pageIndex + "页，共" + totalPages + "页");
}

function doQuery() {
    var formId = "#frmQuery";
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()){
        return false;
    }
    var id = "#btnQuery";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).attr("target", "_self").attr("action", listUrl).submit();
    return false;
}

function doExport() {
    var formId = "#frmQuery";
    if (!ylib.checkInput(formId)) {
        return false;
    }
    if (!checkQueryDateIntervals()){
        return false;
    }
    $(formId).attr("target", "_blank").attr("action", exportUrl).submit();
    return false;
}

function checkQueryDateIntervals(){
    var startDateId="#beginDate";
    var endDateId="#endDate";
    var intervals = Math.abs(ylib.dayMinus(ylib.str2date($(endDateId).val()),ylib.str2date($(startDateId).val())));
    if (intervals>=31){
        alert("查询时间段不能超过1个月！");
        $(endDateId).focus().select();
        return false;
    }
    return true;
}

function setDateByBillDate() {
    var billDate = $("#billDate").val();
    var dt = new Date(billDate);
    // 获取当前月的最后一天
    dt.setTime(new Date(dt.setMonth(dt.getMonth() + 1) - 24*3600*1000));
    $("#beginDate").val(billDate);
    $("#endDate").val(dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + dt.getDate());
}
