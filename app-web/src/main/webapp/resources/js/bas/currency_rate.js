var editUrl = baseHref + "ud/currency/edit.do";
var listUrl = baseHref + "ud/currency/query.do";
var deleteUrl = baseHref + "ud/currency/delete.do";
var saveUrl = baseHref + "ud/currency/save.do";
var showUrl = baseHref + "ud/currency/show.do";

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
    var billDate = $("#billDate");
    if (billDate.val().length > 0) {
        if (isNaN(parseInt(billDate.val()))) {
            alert("汇率月份输入不正确");
            billDate.focus();
            billDate.select();
            return false;
        }
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
    if (!checkInput()){
        return false;
    }
    loading();
    $(formId).attr("action", saveUrl).submit();
    return false;
}

function checkInput() {
    var billDate = $("#billDate");
    if (billDate.val().length > 0 && billDate.val().length < 6) {
        alert("请输入完整的汇率月份");
        billDate.focus();
        billDate.select();
        return false;
    }
    if (isNaN(parseInt(billDate.val()))) {
        alert("汇率月份输入不正确");
        billDate.focus();
        billDate.select();
        return false;
    }

    var currency = $("#currency");
    if (currency.val().length > 0 && currency.val().length < 3) {
        alert("请输入完整的币种");
        currency.focus();
        currency.select();
        return false;
    }

    var rate = $("#rate");
    if (isNaN(parseFloat(rate.val()))) {
        alert("请输入正确的汇率");
        rate.focus();
        rate.select();
        return false;
    }
    return true;
}

function showDetail(id) {
    if (id == undefined) {
        art.dialog.open(showUrl , {width: 350, height: 150, title: "新增汇率信息"});
    }
    else {
        art.dialog.open(editUrl + '?id=' + id, {width: 350, height: 150, title: "编辑汇率信息"});
    }
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除汇率信息"});
    }
    return false;
}

function doArgDialogClose() {
    doQuery();
}
