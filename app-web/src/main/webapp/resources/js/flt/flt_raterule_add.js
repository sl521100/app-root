/**
 * Created by Jacob on 2015/3/27.
 */

var saveUrl = baseHref + "rule/carrier/fee/rate/save.do";
var formId = "#frmRateRuleEdit";

function doSave() {
    if (!ylib.checkInput(formId)) {
        return false;
    }

    // 协议recid
   // var rateId = $("input:hidden[name='rateId']", window.parent.document).val();// 获取父窗口 fkAgreeId
    // 当前表单设计 fkRateId
    //$("input:hidden[name='fkFltRateId']", "form" + formId).val(rateId);


    var id = "#btnSave";
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", saveUrl).submit();
    return false;
}
