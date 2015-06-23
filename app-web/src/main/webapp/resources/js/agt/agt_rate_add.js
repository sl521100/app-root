var saveUrl = baseHref + "rule/agent/fee/save.do";
var deleteUrl = baseHref + "rule/agent/fee/delete.do";
var formId = "#frmEdit";

function doSave() {
    if (!ylib.checkInput(formId)) {
        return false;
    }
    var id = "#btnSave";
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", saveUrl).submit();
    return false;
}




function setFeeDsc(obj) {
    var target = $(obj);
    var feeDsc = target.children("option:selected").html();
    $("#feeDsc").val(feeDsc);
}

function doArgDialogClose() {
    return doQuery();
}


