/**
 * Created by Jacob on 2015/3/25.
 */

var exportUrl = baseHref + "rule/carrier/export.do";
var listUrl = baseHref + "rule/carrier/list.do";
var showUrl = baseHref + "rule/carrier/show.do";
var deleteUrl = baseHref + "rule/carrier/delete.do";
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

function doQuery() {
    var id = "#btnQuery";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

function doAdd() {
    art.dialog.open(showUrl, {width: 760, height: 200, title: "添加-航空公司协议信息"});
    return false;
}

function showDetail(id) {
    art.dialog.open(showUrl + '?id=' + id, {width: 760, height: 200, title: "编辑-航空公司协议信息"});
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除-航空公司协议信息"});
    }
    return false;
}

function doArgDialogClose() {
    return doQuery();
}



