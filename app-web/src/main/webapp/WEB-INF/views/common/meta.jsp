<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib	prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/common/tld/fun.tld" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<base href="${f:getBaseUrl()}">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
${f:addCss("resources/css/global.css")}
${f:addCss("resources/css/common.css")}
${f:addCss("resources/js/common/My97DatePicker/skin/WdatePicker.css")}
${f:addCss("resources/css/simplePagination/simplePagination.css")}
${f:addCss("resources/js/common/artDialog/skins/default.css")}
${f:addJs("resources/js/common/jquery-1.7.1.min.js")}
${f:addJs("resources/js/common/jquery.json.min.js")}
${f:addJs("resources/js/common/My97DatePicker/WdatePicker.js")}
${f:addJs("resources/js/common/simplePagination/jquery.simplePagination.js")}
${f:addJs("resources/js/common/artDialog/jquery.artDialog.js")}
${f:addJs("resources/js/common/artDialog/plugins/iframeTools.js")}
${f:addJs("resources/js/common/ylib.js")}
${f:addJs("resources/js/common/ctas.js")}
<script type="text/javascript">var baseHref="${f:getBaseUrl()}"</script>



