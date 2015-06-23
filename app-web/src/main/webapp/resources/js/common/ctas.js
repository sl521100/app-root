/**
 * Created by jimmy on 2015/3/1.
 */

function loading(){
    var loadingHtml = "<div id='_m'></div><div id='_lo'><img src='" + baseHref + "resources/images/common/loading.gif'/><br/>loading...</div>";
    $("body").append(loadingHtml);
}

function unloading(){
    $("#_m").remove();
    $("#_lo").remove();
}

$(document).ready(function(){
    $("body").append("<img src='resources/images/common/loading.gif' style='display:none'/>");

    /**自动转大写*/
    $("input.autoUpper").blur(function(){
        $(this).val(ylib.trimAndUpper($(this).val()));
    });

    /**列表行，隔行高亮显示*/
    $("table.table-list tr").hover(function () {
        $(this).addClass("hcolor");
    }, function () {
        $(this).removeClass("hcolor");
    })
    $("table.table-list tr:even").addClass("ecolor");
})