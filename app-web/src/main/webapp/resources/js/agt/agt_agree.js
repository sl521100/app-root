/**
 * Created by Jacob on 2015/3/12.
 */
var listUrl = baseHref + "rule/agent/list.do";
var addUrl = baseHref + "rule/agent/show.do";
var deleteUrl = baseHref + "rule/agent/delete.do";
var formId = "#frmQuery";
$(document).ready(function () {

    var _url = window.location.href;
    var _parserUrl = ylib.parseURL(_url);
    var _action = _parserUrl.params.action;
    if (_action == "refresh") {
        submitForm();
    }

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
function submitForm() {

    var _form = $("form#frmQuery");
    loading();
    _form.submit();
    return false;

}

function doQuery() {
    var id = "#btnQueryAgtFee";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

// 添加调整费用 dialog
function doAdd(){
    art.dialog.open(addUrl,{width: 610, height: 125, title: "添加-代理人协议"}).lock();
    return false;
}
// 编辑调整费用 dialog
function showDetail(id) {
    art.dialog.open(addUrl+'?id=' + id, {width: 610, height: 125, title: "编辑-代理人协议"}).lock();
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl+'?id='+id, {width: 400, height: 150, title: "删除-代理人协议"});
    }
    return false;
}

function doArgDialogClose(){
    return doQuery();
}


