/**
 * Created by jimmy on 2015/4/13.
 */

var frmQueryId = "#frmQuery";
var btnQueryId = "#btnQuery";
var addUrl = baseHref + "rule/agent/fee/show.do";
var deleteUrl = baseHref + "rule/agent/fee/delete.do";
var listUrl = baseHref + "rule/agent/fee/list.do";

function doQuery() {
    var agentCode = $("#agentCode");
    var hAgentCode = $("#hAgentCode");
    var vAgentCode = agentCode.val();
    var vHagentCode = hAgentCode.val();
    if (vAgentCode.length > 0 && vHagentCode.length > 0 && vAgentCode != vHagentCode) {
        //说明是先查所有代理人的结果后，又输入了具体的代理人，此时忽略下拉框的选择
        $("#agreeCode").empty().val("");
    }
    $(btnQueryId).blur().attr("disabled", "disabled");
    loading();
    $(frmQueryId).removeAttr("target").attr("action", listUrl).submit();
    return false;
}

function doAgreeChange(obj) {
    var agreementCode = $(obj).val();
    if (agreementCode.length > 0) {
        $(btnQueryId).blur().attr("disabled", "disabled");
        loading();
        $(frmQueryId).removeAttr("target").submit();
    }
    return false;
}

function doAdd(){
    art.dialog.open(addUrl+"?agreeId="+$("#hAgreeId").val(),{width: 610, height: 125, title: "添加-代理人计费规则"}).lock();
    return false;
}

function showDetail(id){
    art.dialog.open(addUrl+"?id="+id,{width: 610, height: 125, title: "编辑-代理人计费规则"}).lock();
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除-代理人费用规则"});
    }
    return false;
}

function doArgDialogClose(){
    return doQuery();
}
