<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>货站结算系统</title>
    ${f:addCss("resources/css/admin.css")}
    ${f:addCss("resources/css/menu.css")}
    ${f:addJs("resources/js/common/jquery-iframe.js")}
    ${f:addJs("resources/js/menu/index.js")}
</head>
<body scroll="no">

<table border="0" cellpadding="0" cellspacing="0" height="100%"
       width="100%">
    <tbody>
    <tr>
        <td valign="top" width="100%">
            <div class="menu-header">
                <div class="menu-header-bg"
                     style="background: url(resources/images/common/top-bg.jpg) no-repeat 0 bottom;">
                    <ul class="top-nav">
                        <li>欢迎您：${userName}</li>
                        <li><a href="logout.do"
                               style="color: #E17009">退出</a></li>
                        <li><a href="/" style="color: #E17009" target="_blank">航空物流信息服务平台</a>
                        </li>
                    </ul>
                    <h1 class="menu-logo">货站结算系统</h1>
                </div>
                <div style="position: absolute; margin: -50px 0px 0px 230px;">
                    <span style="color: white; font-weight: bolder; font-size: 20pt;">货站结算系统</span>
                    <span style="color:white;font-weight:bold">${env}</span>
                </div>
            </div>
            <div class="menu">
                <div style="width: 1024px;" class="wrap">
                    <ul class="cf navigation">
                        <c:forEach var="item" items="${menus}">
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);" id="${item.menuId}"><span
                                    class="span-first">${item.menuName}</span></a>

                                <div class="sublist none">
                                    <c:forEach var="subItem" items="${item.items}">
                                        <dl class="clearfix">
                                            <dd>
                                                <a target="${subItem.menuTarget==null?"frmright" : subItem.menuTarget}"
                                                   href="${f:buildMenuUrl(subItem.menuUrl)}"
                                                   onclick="return openInIframe(this,'${f:buildMenuUrl(subItem.menuUrl)}',${subItem.menuId})">${subItem.menuName}</a>
                                            </dd>
                                        </dl>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${menus==null}">
                            <!--默认菜单，sso取不到时,显示下面的内容-->
                            <li style="z-index: 1000;display:none"><a class="main-menu"
                                                                      href="javascript:void(0);" id="topMenu01"><span
                                    class="span-first">系统管理</span></a>

                                <div class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="#"
                                               onclick="return openInIframe(this,'#',1010);">公司管理</a>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="#"
                                               onclick="return openInIframe(this,'#',1020);">修改密码</a>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="#"
                                               onclick="return openInIframe(this,'#',1030);">个人信息</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);" id="topMenu02"><span
                                    class="span-first">基础数据</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright"
                                               href="#"
                                               onclick="return openInIframe(this,'#',2010);">航站管理</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="#"
                                               onclick="return openInIframe(this,'#',2020);">国家管理</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="ud/currency/query.do"
                                               onclick="return openInIframe(this,'ud/currency/query.do',2030);">汇率信息</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="ud/feetype/query.do?suitType=F"
                                               onclick="return openInIframe(this,'ud/feetype/query.do?suitType=F',2040);">航空公司收费项</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="ud/fltplaneno/query.do"
                                               onclick="return openInIframe(this,'ud/fltplaneno/query.do',2070);">代理人包机信息</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="ud/feetype/query.do?suitType=A"
                                               onclick="return openInIframe(this,'ud/feetype/query.do?suitType=A',2050);">代理人收费项</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="#"
                                               onclick="return openInIframe(this,'#',2060);">分子公司飞机号</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="#"
                                               onclick="return openInIframe(this,'#',2080);">代理人信息</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright"
                                               href="ud/agtgroup/query.do"
                                               onclick="return openInIframe(this,'ud/agtgroup/query.do',2090);">代理人分组</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);"
                                                          id="topMenu03"><span>计费规则</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="rule/carrier/query.do"
                                               onclick="return openInIframe(this,'rule/carrier/query.do',3010);">航空公司协议</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="rule/carrier/fee/query.do"
                                               onclick="return openInIframe(this,'rule/carrier/fee/query.do',3020);">航空公司费用规则</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="rule/agent/query.do"
                                               onclick="return openInIframe(this,'rule/carrier/fee/query.do',3030);">代理人协议</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="rule/agent/fee/query.do"
                                               onclick="return openInIframe(this,'rule/agent/fee/query.do',3040);">代理人费用规则</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="#"
                                               onclick="return openInIframe(this,'#',3050);">打板费用规则</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);"
                                                          id="topMenu04"><span>货量明细</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="detail/flt/flight/query.do"
                                               onclick="return openInIframe(this,'detail/flt/flight/query.do',4010);">航班货量明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/flt/flightsum/query.do"
                                               onclick="return openInIframe(this,'detail/flt/flightsum/query.do',4040);">各航班汇总</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/sharkagt/query.do"
                                               onclick="return openInIframe(this,'detail/agt/sharkagt/query.do',4020);">代理人货量明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/express/query.do"
                                               onclick="return openInIframe(this,'detail/agt/express/query.do',4020);">快件货物明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/lightrate/query.do"
                                               onclick="return openInIframe(this,'detail/agt/lightrate/query.do',4020);">短驳货物明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/pack/query.do"
                                               onclick="return openInIframe(this,'detail/agt/pack/query.do',4020);">打板货物明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/arr/query.do"
                                               onclick="return openInIframe(this,'detail/agt/arr/query.do',4020);">运抵申报货物明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/stock/query.do"
                                               onclick="return openInIframe(this,'detail/agt/stock/query.do',4020);">仓储收费货物明细</a>
                                        </dd>
                                        <dd style="display:none">
                                            <a target="frmright" href="#"
                                               onclick="return openInIframe(this,'#',4030);">出港代理人统计</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="detail/agt/return/query.do"
                                               onclick="return openInIframe(this,'detail/agt/return/query.do',4050);">退货明细</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);"
                                                          id="topMenu05"><span>账单查询</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_fltbill_d_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_fltbill_d_el.cpt',5010);">航空公司(国内)账单</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_fltbill_i_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_fltbill_i_el.cpt',5020);">航空公司(国际)账单</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbill_d_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbill_d_el.cpt',5030);">代理人(国内)账单</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbill_i_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbill_i_el.cpt',5040);">代理人(国际)账单</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbillofday_d_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbillofday_d_el.cpt',5050);">代理人(国内)日报</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbillofday_i_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbillofday_i_el.cpt',5060);">代理人(国际)日报</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbillofday_detail_i_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbillofday_detail_i_el.cpt',5061);">代理人(国际)日报明细</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="agt/bulletin/view.do"
                                               onclick="return openInIframe(this,'agt/bulletin/view.do',5062);">代理人(国际)快报</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="${rptBaseUrl}ctas_agtbill_rank_el.cpt"
                                               onclick="return openInIframe(this,'${rptBaseUrl}ctas_agtbill_rank_el.cpt',5062);">代理人排名汇总</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);"
                                                          id="topMenu06"><span>账单调整</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="flt/adjust/query.do"
                                               onclick="return openInIframe(this,'flt/otherfee/query.do',6010);">航空公司账单调整</a>
                                        </dd>
                                        <dd>
                                            <a target="frmright" href="agt/adjust/query.do"
                                               onclick="return openInIframe(this,'agt/adjust/query.do',6020);">代理人账单调整</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                            <li style="z-index: 1000;"><a class="main-menu"
                                                          href="javascript:void(0);"
                                                          id="topMenu07"><span>账单计算</span></a>

                                <div style="display: none;" class="sublist none">
                                    <dl class="clearfix">
                                        <dd>
                                            <a target="frmright" href="robot/list.do"
                                               onclick="return openInIframe(this,'robot/list.do',6010);">账单开账</a>
                                        </dd>
                                    </dl>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="main" style="width: 100%; height: 100%;" valign="top">
            <table style="width: 100%; height: 100%" border="0" cellpadding="0"
                   cellspacing="0">
                <tbody>
                <tr>
                    <td style="width: 100%; height: 100%" class="maincon">
                        <iframe
                                style="z-index: 1; width: 100%; height: 100%; visibility: inherit"
                                id="frmright" src="welcome.do" name="frmright" frameborder="0"></iframe>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>
</body>
</html>