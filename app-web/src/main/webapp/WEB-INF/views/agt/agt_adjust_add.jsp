<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/agt/agt_adjust_add.js")}

    <title>账单调整-代理人账单调整</title>
</head>
<body>
<div class="form">
    <table width="100%">
        <tr>
            <td align="right"><input type="checkbox" value="1" id="switchDetail" onclick="switchDetail(this)"/>
                <label for="switchDetail" style="cursor:pointer;" id="lblSwitchDetail">显示明细</label></td>
        </tr>
    </table>
    <table style="display: none;">
        <tbody id="trTemplate">
        <tr>
            <td style='width:150px;'><input name='agtAdjustDetailList[#seq#].awbPre' class='inputText autoUpper' value=''
                                            style='width: 40px !important;' type='text'/>
                <input name='agtAdjustDetailList[#seq#].awbNo' class='inputText autoUpper' value=''
                       style='width: 100px !important;'
                       type='text'/></td>
            <td><input name='agtAdjustDetailList[#seq#].flightNo' style='width:90px;' value='' class='inputText autoUpper'
                       type='text'/></td>
            <td><input name='agtAdjustDetailList[#seq#].flightDate' value='#currentDate#' class='inputText Wdate'
                       onclick='WdatePicker();' style='width: 80px !important;'/></td>
            <td><input name='agtAdjustDetailList[#seq#].fee' value='' onblur='calcuFeeTotal();' class='inputText'
                       type='text'/></td>
            <td><input name='agtAdjustDetailList[#seq#].remark' value='' class='inputText' type='text'/></td>
            <td><a href='javascript:void(0);' style="color:#0000ff" name="removeAgtTr" onclick='removeAgtFeeTr(this);'>移除</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="form">
    <form:form modelAttribute="feeWrapper"
               action="agt/adjust/add.do" method="post" id="frmEdit">
        <input type="hidden" id="hidDate"
               value="${currentDate}"/>
        <table class="table-default" id="agtFeeTable" style="width:760px">

            <colgroup>
                <col width="22%"/>
                <col width="9%"/>
                <col width="12%"/>
                <col width="12%"/>
                <col width="32%"/>
                <col width="12%"/>
            </colgroup>
            <thead class="ecolor">
            <tr>
                <th>运单号</th>
                <th>航班号</th>
                <th>航班日期</th>
                <th>金额(元)</th>
                <th>备注</th>
                <th>操作&nbsp;<a href="javascript:void(0);" onclick="addTr();"
                               id="btnAddAgtFee" style="color:blue;text-decoration:underline">(添加)</a></th>
            </tr>
            </thead>
            <tbody id="tbodyDetail">
            <c:forEach items="${feeWrapper.agtAdjustDetailList}" var="fee" varStatus="i">
                <tr>
                    <td><form:input
                            path="agtAdjustDetailList[${i.index}].awbPre" class="inputText autoupper"
                            value="${fee.awbPre }" style="width: 40px !important;"
                            type="text"/> <form:input path="agtAdjustDetailList[${i.index}].awbNo"
                                                      class="inputText autoUpper" onblur="validateAwbNo(this);"
                                                      value="${fee.awbNo }" style="width: 100px !important;"
                                                      type="text"/><input type="hidden" name="hidIndex"
                                                                          value="${i.index}"/></td>
                    <td><form:input path="agtAdjustDetailList[${i.index}].flightNo"
                                    style="width:90px;" value="${fee.flightNo }" class="inputText autoUpper"
                                    type="text"/>
                        <form:hidden path="agtAdjustDetailList[${i.index}].recId"/></td>
                    <td><form:input path="agtAdjustDetailList[${i.index}].flightDate" type="text"
                                    class="inputText Wdate" style="width: 80px !important;"
                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"
                                    require="false" require-msg="航班日期"/>
                    <td><form:input path="agtAdjustDetailList[${i.index}].fee" onblur="calcuFeeTotal();"
                                    value="${fee.fee }" class="inputText" type="text"/></td>
                    <td><form:input path="agtAdjustDetailList[${i.index}].remark"
                                    value="${fee.remark }" class="inputText" type="text"/></td>
                    <td><a href="javascript:void(0);" style="color:#0000ff"
                           onclick="removeAgtFeeTr(this);" id="btnRemoveAgtFee">移除</a></td>
                </tr>
            </c:forEach>
                <%--<tr id="trAddFeeCopy" class="css_help_nodisplay"></tr>--%>
            </tbody>
        </table>

        <table class="table-form" style="width:750px">
            <tbody>
            <tr>
                <td class="label">代理人</td>
                <td><form:input path="agtAdjust.agentCode" class="inputText autoUpper"
                                value="${agtAdjust.agentCode }" style="width:30px !important;"
                                type="text"/>
                    <form:hidden path="agtAdjust.recid"/></td>
                <td class="label">费用类型</td>
                <td><form:select path="agtAdjust.feeType"
                                 style="width:115px !important;" value="${agtAdjust.feeType }" onchange="setEi(this)">

                    ${feeTypeOptions}
                </form:select></td>
                <td class="label">费用总额</td>
                <td><form:input path="agtAdjust.fee" class="inputText" id="totalFee"
                                value="${agtAdjust.fee }" style="width:40px !important;"
                                type="text"/></td>
                <td><form:select path="agtAdjust.di" value="${agtAdjust.di }">
                    <form:options items="${diList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><form:select path="agtAdjust.ei" value="${agtAdjust.ei }">
                    <form:options items="${eiList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td class="label">帐期</td>
                <td><form:select path="agtAdjust.billDate"
                                 style="width:70px !important;" value="${agtAdjust.billDate }">
                    <form:options items="${billList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td class="label">扣除货量</td>
                <td><form:select path="agtAdjust.isDeduct"
                                 style="width:40px !important;" value="${agtAdjust.isDeduct }">
                    <form:options items="${yesOrNoList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><form:button id="btnSave" onclick="return doSave();" value="保存"
                                 style="width:60px">保存</form:button></td>
            </tr>
            <tr>
                <td class="title">
                    备注
                </td>
                <td colspan="12">
                    <form:input path="agtAdjust.remark" class="inputText" maxlength="200"/>
                </td>
            </tr>
            </tbody>
        </table>

    </form:form>
</div>
</body>
</html>