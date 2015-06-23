var saveUrl = baseHref + "rule/agent/save.do";
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


function doArgDialogClose(){
    return doQuery();
}


