/**
 * Created by Jacob on 2015/3/27.
 */

var showUrl = baseHref + "rule/carrier/fee/rate/show.do";
var deleteUrl = baseHref + "rule/carrier/fee/rate/delete.do";

var rateListUrl = baseHref + "rule/carrier/fee/rate/list.do";


function doAddRule(id) {
    art.dialog.open(showUrl + '?fkId=' + id, {width: 760, height: 200, title: "添加-航空公司费率信息"}).lock();
    return false;
}

function showDetail(id) {
    art.dialog.open(showUrl + '?id=' + id, {width: 760, height: 200, title: "编辑-航空公司费率信息"}).lock();
    return false;
}

function doDelete(id) {
    if (confirm("确定要删除该条记录吗？")) {
        art.dialog.data('result', id);
        art.dialog.open(deleteUrl + '?id=' + id, {width: 400, height: 150, title: "删除-航空公司费率信息"});
    }
    return false;
}

function doArgDialogClose() {
    window.location.reload();
}
