/**
 * Created by jimmy on 2015/2/27.
 */
if (top.location != self.location) {
    top.location = self.location;
}

$(document.body).css({
    "overflow-x": "hidden",
    "overflow-y": "hidden"
});

$("document").ready(
    function () {
        $(".sublist").bgIframe();

        if ($.browser.msie
            && /msie 6\.0/i.test(navigator.userAgent)) {
            try {
                $(window.frames["frmright"].document).find("html")
                    .css("overflow-y", "scroll");
            } catch (e) {
            }
            ;
        }
        $(".menu>.wrap>ul>li>a").hover(function () {
            var status = $(this).data("status") || {};
            if (status.hideID) {
                clearTimeout(status.hideID);
            }
            $(this).next().slideDown(200);
        }, function () {
            var status = $(this).data("status") || {};
            var ele = $(this);
            status.hideID = setTimeout(function () {
                ele.next().slideUp(200);
            }, 20);
            $(this).data("status", status);
        });
        $(".menu>.wrap>ul>li>a").next().hover(function () {
            $(this).prev().addClass("hoverflag");
            var status = $(this).prev().data("status") || {};
            if (status.hideID) {
                clearTimeout(status.hideID);
            }
        }, function () {
            $(this).prev().removeClass("hoverflag");
            var status = $(this).prev().data("status") || {};
            var ele = $(this);
            status.hideID = setTimeout(function () {
                ele.slideUp(200);
            }, 20);
            $(this).prev().data("status", status);
        });

        var menu_width = 0;
        $("div.wrap .navigation li").each(function (index, item) {
            menu_width += $(item).width();
        });
        if (typeof menu_width == "number" && menu_width > 990) {
            $(".navigation").parent().css("width",
                menu_width + 10 + "px");
        }
    });

function openInIframe(obj, targetUrl, topMenuId) {
    try {
        if (window.document.title) {
            window.document.title = $(obj).text();
        } else {
            window.document.getElementsByTagName('title')[0].innerHTML = $(
                obj).text();
        }
    } catch (e) {
    }
    try {
        if (targetUrl.substr(0, 1) == "#"
            || targetUrl.substr(0, 2) == "/#") {
            document.getElementById("frmright").contentWindow
                .NavigationTo($(obj).attr("href"));
            return false;
        }
    } catch (e) {
    }
    return true;
}
