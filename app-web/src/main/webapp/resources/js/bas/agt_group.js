var editUrl = baseHref + "ud/agtgroup/edit.do";
var listUrl = baseHref + "ud/agtgroup/query.do";
var deleteUrl = baseHref + "ud/agtgroup/delete.do";
var saveUrl = baseHref + "ud/agtgroup/save.do";
var showUrl = baseHref + "ud/agtgroup/show.do";

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
        art.dialog.open(showUrl , {width: 350, height: 200, title: "新增代理人分组信息"});
    }
    else {
        art.dialog.open(editUrl + '?id=' + id, {width: 350, height: 200, title: "编辑代理人分组信息"});
    }
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除代理人分组信息"});
    }
    return false;
}

function doArgDialogClose() {
    doQuery();
}
