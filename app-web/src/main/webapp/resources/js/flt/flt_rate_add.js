/**
 * Created by Jacob on 2015/3/26.
 */

var saveUrl = baseHref + "rule/carrier/fee/save.do";
var formId = "#frmEdit";

$(document).ready(function () {
    // 费用类型 选择列表
    var feeSel = $("select[name='feeType']", "form#frmEdit");

    // 计费方式 选择俩表
    var rateSel = $("select[name='rateType']", "form#frmEdit");

    // 描述 赋值到隐藏域
    feeTypeChange(feeSel);
    rateTypeChange(rateSel);

});

function doSave() {
    if (!ylib.checkInput(formId)) {
        return false;
    }
    // 协议recid
    var agreeId = $("table#tbAgree input:hidden[name='recId']", window.parent.document).val();// 获取父窗口 fkAgreeId
    // 当前表单设计 fkAgreeId
    $("input:hidden[name='fkAgreeId']", "form" + formId).val(agreeId);
    // 提交当前表单
    var id = "#btnSave";
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", saveUrl).submit();
    return false;
}

function feeTypeChange(obj) {
    // 将费用描述赋值到隐藏域
    var feeDsc = $(obj).children("option:selected").html();// 当前选中 费用描述值
    // 赋值
    $("input:hidden[name='feeDsc']", $(obj).closest("td")).val(ylib.trim(feeDsc));

    return false;
}

function rateTypeChange(obj) {
    // 计费规则
    var rateDsc = $(obj).children("option:selected").html(); // 当前计费方式 描述值
    // 赋值
    $("input:hidden[name='rateDsc']", $(obj).closest("td")).val(ylib.trim(rateDsc));

    // 计费方式 为 "按重量阶梯费率" 不设置费率值
    var rateType = $(obj).children("option:selected").val(); // 当前选中计费方式值
    var ratObj = $("input:hidden[name='rate']", $(obj).closest("tr"));
    if (rateType == "B") {
        ratObj.val(rateDsc);
    } else {
        ratObj.val(0);
    }
    return false;
}
