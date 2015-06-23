/**
 * Created by Jacob on 2015/3/26.
 */

var listUrl = baseHref + "rule/carrier/fee/list.do";
var showUrl = baseHref + "rule/carrier/fee/show.do";
var deleteUrl = baseHref + "rule/carrier/fee/delete.do";

var rateListUrl = baseHref + "rule/carrier/fee/rate/list.do";
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
    art.dialog.open(showUrl, {width: 760, height: 200, title: "添加-航空公司费用规则信息"}).lock();
    return false;
}

function showDetail(id) {
    art.dialog.open(showUrl + '?id=' + id, {width: 760, height: 200, title: "编辑-航空公司费用规则信息"}).lock();
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除-航空公司费用规则信息"});
    }
    return false;
}

function doArgDialogClose() {
    return doQuery();
}

function agreeChange(obj) {
    var agreeCode = $(obj).children("option:selected").val();
    $("input:hidden[name='agreeCode']", "form" + formId).val(agreeCode);

    return doQuery();
}


// 费用规则 费率编辑
function showRateRuleDetail(id) {
    art.dialog.open(rateListUrl + '?id=' + id, {width: 760, height: 200, title: "编辑-航空公司费率详情",id:"ruleDlg"}).lock();
    return false;
}




