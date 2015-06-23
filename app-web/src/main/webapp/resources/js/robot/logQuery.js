
var listUrl = baseHref + "robot/logList.do";
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
    $("#pageIndex").val(page);
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

function showPageInfo() {
    $("#page-info").html(pageSize + "条/页，共" + totalCounts + "条，第" + pageIndex + "页，共" + totalPages + "页");
}

function loading() {
    var loadingHtml = "<div id='_m'></div><div id='_lo'><img src='" + baseHref + "resources/images/common/loading.gif'/><br/>loading...</div>";
    $("body").append(loadingHtml);
}

function unloading() {
    $("#_m").remove();
    $("#_lo").remove();
}

function doQuery() {
    var id = "#btnQuery";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

