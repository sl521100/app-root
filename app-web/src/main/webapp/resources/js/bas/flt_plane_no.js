var editUrl = baseHref + "ud/fltplaneno/edit.do";
var listUrl = baseHref + "ud/fltplaneno/query.do";
var deleteUrl = baseHref + "ud/fltplaneno/delete.do";
var saveUrl = baseHref + "ud/fltplaneno/save.do";
var showUrl = baseHref + "ud/fltplaneno/show.do";

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
    $("#pageIndex").val(page);
    loading();
    $(formId).attr("action", listUrl).submit();
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
    var id = "#btnQuery";
    $("#pageIndex").val(1);
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).attr("action", listUrl).submit();
    return false;
}

function doSave() {
    var formId = "#frmEdit";
    if (!ylib.checkInput(formId)) {
        return false;
    }
    loading();
    $(formId).attr("action", saveUrl).submit();
    return false;
}

function showDetail(id) {
    if (id == undefined) {
        art.dialog.open(showUrl , {width: 350, height: 300, title: "新增航空公司飞机号"});
    }
    else {
        art.dialog.open(editUrl + '?id=' + id, {width: 350, height: 300, title: "编辑航空公司飞机号"});
    }
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除航空公司飞机号"});
    }
    return false;
}

function doArgDialogClose() {
    doQuery();
}
