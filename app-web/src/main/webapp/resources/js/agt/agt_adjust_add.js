/**
 * Created by Jacob on 2015/3/12.
 */


var saveUrl = baseHref + "agt/adjust/save.do";
var trDetail = "tbody#tbodyDetail";
var formId = "#frmEdit";
// 表单数据 序列化为 Object
jQuery.prototype.serializeObject = function () {
    var obj = new Object();
    $.each(this.serializeArray(), function (index, param) {
        if (!(param.name in obj)) {
            obj[param.name] = param.value;
        }
    });
    return obj;
};

function setEi(obj) {
    var option = $(obj).find("option:selected");
    //alert(option.attr("ei"));
    //alert($("#agtAdjust\\.ei").val());
    $("#agtAdjust\\.ei").val(option.attr("ei"));
};


// 保存调整费用
function doSave() {
    var id = "#btnSave";
    $(id).blur().attr("disabled", "disabled");
    loading();
    $(formId).removeAttr("target").attr("action", saveUrl).submit();
    return false;
}

// 计算费用总和
function calcuFeeTotal() {
    var feeTr = $("tbody tr:visible", "table#agtFeeTable");
    // 费用值
    var _fee = 0;
    feeTr.each(function () {
        var feeTd = $("td", this).eq(3);
        var feeVal = $("input", feeTd).val();
        // 转为float
        if (feeVal == "" || feeVal == "undefined" || feeVal == null) {
            feeVal = 0;
        } else {
            feeVal = parseFloat(feeVal);
        }
        _fee += feeVal;
    });
    // 赋值到总费用
    var _total = $("input#totalFee");
    $(_total).val(_fee);
}
// 移除费用明细条目
function removeAgtFeeTr(obj) {
    if ($(obj).attr("disabled") == "disabled"
        || $(obj).attr("disabled") == true)
        return false;
    $(obj).closest("tr").remove();
    //重新计算总费用值
    calcuFeeTotal();
}
// 添加费用明细行
function addTr() {
    var trTemplate = $("tbody#trTemplate").html();

    var _tbDetail = $("tbody#tbodyDetail");
    var _index = $("tr:visible", _tbDetail).length;
    // 隐藏域当前日期
    var currentDate = $("#hidDate").val();
    // 替换序号值
    trTemplate = trTemplate.replace(/#seq#/gi, _index + 1);
    trTemplate = trTemplate.replace(/#currentDate#/gi, currentDate);

    // 添加行
    $(_tbDetail).append(trTemplate);
}
// 明细区域 切换
function switchDetail(obj) {
    var tableId = "#agtFeeTable";
    var labelId = "#lblSwitchDetail";

    if ($(obj).attr("checked")) {
        showDetail();
        var index = $(trDetail + " tr").length;
        if (index <= 0) {
            addTr();
        }
    }
    else {
        hideDetail();
    }
}

function showDetail() {
    $("#agtFeeTable").show();
    $("#lblSwitchDetail").html("隐藏明细");
    $("#switchDetail").attr("checked", "checked");
}

function hideDetail() {
    $("#agtFeeTable").hide();
    $("#lblSwitchDetail").html("显示明细");
    $("#switchDetail").removeAttr("checked")
}

$(document).ready(function () {
    var index = $(trDetail + " tr").length;
    if (index <= 0) {
        hideDetail();
    }
});