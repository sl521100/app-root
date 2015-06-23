/**
 * Created by Jacob on 2015/3/25.
 */

var saveUrl = baseHref + "rule/carrier/save.do";
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
