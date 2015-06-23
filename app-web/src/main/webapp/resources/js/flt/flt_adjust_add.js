/**
 * Created by jimmy on 2015/3/12.
 */

var saveUrl = baseHref + "flt/adjust/save.do";
var formId = "#frmEdit";
var trBoxId = "#trBox";

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


// 计算费用总和
function calcuFeeTotal() {
    var feeTr = $("tbody tr:visible", "table#fltFeeTable");
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
    //if(_fee!=0){
    $(_total).val(_fee);
    //}
}
// 添加费用明细条目
function addTr() {
    var trTemplateHtml = $("#trTemplate").html();
    var index = $(trBoxId + " tr").length;
    var currentDate = $("#hidDate").val();
    trTemplateHtml = trTemplateHtml.replace(/#INDEX#/gi, index);
    trTemplateHtml = trTemplateHtml.replace(/#CURRENT_DATE#/gi, currentDate);
    $(trBoxId).append(trTemplateHtml);

    /**自动转大写*/
    $("input.autoUpper").unbind("blur").blur(function () {
        $(this).val(ylib.trimAndUpper($(this).val()));
    });
}

// 移除费用明细条目
function removeTr(obj) {
    if ($(obj).attr("disabled") == "disabled"
        || $(obj).attr("disabled") == true)
        return false;
    $(obj).closest("tr").remove();
    //重新计算总费用值
    calcuFeeTotal();
}

function switchDetail(obj) {
    var tableId = "#fltFeeTable";
    var labelId = "#lblSwitchDetail";
    if ($(obj).attr("checked")) {
        showDetail();
        var index = $(trBoxId + " tr").length;
        if (index <= 0) {
            addTr();
        }
    }
    else {
        hideDetail();
    }
}

function showDetail() {
    $("#fltFeeTable").show();
    $("#lblSwitchDetail").html("隐藏明细");
    $("#switchDetail").attr("checked", "checked");
}

function hideDetail() {
    $("#fltFeeTable").hide();
    $("#lblSwitchDetail").html("显示明细");
    $("#switchDetail").removeAttr("checked")
}

$(document).ready(function () {
    var index = $(trBoxId + " tr").length;
    if (index <= 0) {
        hideDetail();
    }
});
