<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="/WEB-INF/views/common/meta.jsp" %>
    <title>航空公司账单调整-${title }</title>
    ${f:addCss("resources/css/form.css")}
    ${f:addCss("resources/css/tableform.css")}
    ${f:addCss("resources/css/ctas.css")}
    ${f:addJs("resources/js/flt/flt_adjust_add.js")}
</head>
<body>
<div class="form">
    <table width="100%">
        <tr>
            <td align="right"><input type="checkbox" value="1" id="switchDetail" onclick="switchDetail(this)"/>
                <label for="switchDetail" style="cursor:pointer;" id="lblSwitchDetail">显示明细</label></td>
        </tr>
    </table>
</div>
<div class="form">
    <table style="display: none;">
        <tbody id="trTemplate">
        <tr>
            <td><input type="text" style="width: 30px !important;" maxlength="3" value="" class="inputText autoUpper"
                       name="feeList[#INDEX#].awbPre">&nbsp;<input type="text"
                                                                   style="width: 65px !important;"
                                                                   value="" class="inputText autoUpper"
                                                                   name="feeList[#INDEX#].awbNo" maxlength="8"></td>
            <td><input type="text" class="inputText autoUpper" value="" style="width:70px;" name="feeList[#INDEX#].flightNo"
                       maxlength="7"></td>
            <td><input style="width: 80px !important;" onclick="WdatePicker();" class="inputText Wdate"
                       value="#CURRENT_DATE#" name="feeList[#INDEX#].flightDate" maxlength="10"></td>
            <td><input type="text" class="inputText autoUpper" onblur="calcuFeeTotal();" value="" name="feeList[#INDEX#].amount"
                       maxlength="10"  require="true" require-msg="费用金额"></td>
            <td><input type="text" class="inputText autoUpper" value="" name="feeList[#INDEX#].remark" maxlength="50"></td>
            <td style="text-align:center"><a onclick="removeFltFee(this);"
                                             href="javascript:void(0);"><span style="color:#0000ff">移除</span></a></td>
        </tr>
        </tbody>
    </table>

    <form:form modelAttribute="feeWrapper"
               action="flt/adjust/save.do" method="post" id="frmEdit">
        <form:hidden path="recid"/>
        <input type="hidden" id="hidDate"
               value="${currentDate}"/>
        <table class="table-default" id="fltFeeTable" style="width:750px">
            <colgroup>
                <col width="16%"/>
                <col width="9%"/>
                <col width="12%"/>
                <col width="15%"/>
                <col width="36%"/>
                <col width="12%"/>
            </colgroup>
            <thead class="ecolor">
            <tr>
                <th>运单号</th>
                <th>航班号</th>
                <th>航班日期</th>
                <th>金额(元)</th>
                <th>明细备注</th>
                <th>操作&nbsp;<a href="javascript:void(0);" onclick="addTr();"
                               id="btnAddFltFee" style="color:blue;text-decoration:underline">(添加)</a></th>
            </tr>
            </thead>
            <tbody id="trBox">
            <c:forEach items="${feeWrapper.feeList}" var="fee" varStatus="i">
                <tr>
                    <td><form:input
                            path="feeList[${i.index}].awbPre" class="inputText autoUpper"
                            value="${fee.awbPre }" maxlength="3" style="width: 30px !important;"
                            type="text"/>&nbsp;<form:input maxlength="8" path="feeList[${i.index}].awbNo"
                                                           class="inputText autoUpper" onblur="validateAwbNo(this);"
                                                           value="${fee.awbNo }" style="width: 65px !important;"
                                                           type="text"/></td>
                    <td><form:input path="feeList[${i.index}].flightNo"
                                    style="width:70px;" maxlength="7" value="${fee.flightNo }" class="inputText autoUpper"
                                    type="text"/>
                    </td>
                    <td><form:input path="feeList[${i.index}].flightDate" type="text" class="inputText Wdate"
                                    style="width: 80px !important;" maxlength="10"
                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" require="false"
                                    require-msg="航班日期"/>

                    <td><form:input path="feeList[${i.index}].amount" onblur="calcuFeeTotal();"
                                    value="${fee.amount }" class="inputText autoUpper" type="text" maxlength="10"/></td>
                    <td><form:input path="feeList[${i.index}].remark"
                                    value="${fee.remark }" class="inputText autoUpper" type="text" maxlength="100"/></td>
                    <td style="text-align:center"><a href="javascript:void(0);"
                                                     onclick="removeTr(this);" id="btnRemoveFltFee"
                                                     style="color:#0000ff">移除</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <table class="table-form" style="width:750px">
            <tbody>
            <tr>
                <td class="label">承运人</td>
                <td><form:input path="airlineId" class="inputText autoUpper"
                                value="${airlineId }" style="width:30px !important;"
                                type="text" require="true" require-msg="承运人"/>
                </td>
                <td class="label">费用类型</td>
                <td><form:select path="feeType"
                                 style="width:115px !important;" value="${feeType }">
                    <form:options items="${feeTypeList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td class="label">费用总额</td>
                <td><form:input path="totalFee" class="inputText"
                                value="${totalFee }" style="width:40px !important;"
                                type="text" require="true" require-msg="费用总额"/></td>
                <td><form:select path="di" value="${di }">
                    <form:options items="${diList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>
                <td><form:select path="ei" value="${ei }">
                    <form:options items="${eiList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td class="label">帐期</td>
                <td><form:select path="billDate"
                                 style="width:65px !important;" value="${billDate }">
                    <form:options items="${billList}" itemValue="value"
                                  itemLabel="name"/>
                </form:select></td>

                <td class="label">扣除货量</td>
                <td><form:select path="isDeduct"
                                 style="width:40px !important;" value="${isDeduct }">
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
                    <form:input path="remark" class="inputText autoUpper" maxlength="200"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form:form>
</div>
</body>
</html>