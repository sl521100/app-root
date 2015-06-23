<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/common/meta.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
${f:addCss("resources/css/form.css")}
${f:addCss("resources/css/tableform.css")}
<style type="text/css">
        fieldset
        {
            border: 1px dashed #999; 
            margin-left: 5px; 
            margin-right: 5px;
            margin-bottom:8px;
            padding:5px;
        }
        .report input[type='text']{width:70px;}
</style>
<script type="text/javascript">
         function sumfee() {
            var main = 0,ratefee = 0;
            $("#tbbulletin input[name='FEE']").each(function () {
                var v = $(this).val();
                if (v && !isNaN(v)) main += Math.round(parseFloat(v));
            });
            $("#main").val(main);

            $("#tbbulletin input[name='RFEE']").each(function () {
                var v = $(this).val();
                if (v && !isNaN(v)) ratefee += Math.round(parseFloat(v));
            });
            $("#main1").val(ratefee);

            $("#tbbulletin input[name='FFEE']").each(function () {
                var v = $(this).val();
                if (v && !isNaN(v)) main += Math.round(parseFloat(v));
            });
            $("#red").val(main);
            $("#net").val(Math.round(main / 1.06));
        }

        function rebinddayflagsofbulletin() {
            var $sl = $("#slbulletin");
            $sl.empty();
            var url = baseHref+"agt/bulletin/dayflags.do";//$.getUrl("Report/AgtBulletin/GetAllBulletinDayFlags");
            var callback=function(data){
              var arr = $.parseJSON(data);
              for (var i in arr) {
                var v = String(arr[i]);
                $sl.append("<option value='" + v + "'>" + v.substring(0, 4) + "-" + v.substring(4, 6) + "-" + v.substring(6) + "</option>");
              }
            };
            doajax(url,null,callback);
        }

        function rebindbulletin(obj) {
            $("#lgdbulletin").text("快报");
            $("#divbulletin input").val("");
            $("#divbulletin a[name='annotation']").attr("title", '无批注');
            for (var attr in obj) {
                if(attr.indexOf("est")==0)$("#hid" + attr).val(obj[attr]);
                else $("#" + attr).val(obj[attr]);
            }

            if (obj.billdate) {
                var dt=new Date(obj.billdate);
                $("#lgdbulletin").text("快报(" + dt.getFullYear()+(dt.getMonth()<9? "-0":"-")+(dt.getMonth()+1) + "月)");//obj.billdate.substring(0, 7)
                $("#hidbilldate").val(obj.billdate);//obj.billdate.substring(0, 7).replace(/-/g, '')
            }
            $("#hiddayflag").val(obj.dayflag);
            $("#tbbulletin a[name='annotation']").each(function () {
                var $a = $(this);
                var v = $a.closest("td").find("input:hidden[name='note']").val();
                if (v) $a.attr("title", v);
            });
        }

        function getbulletin() {
            var bulletin = {};
            $("#tbbulletin input:visible").each(function () {
                bulletin[$(this).attr("id")] = Math.round($(this).val());
            });

            $("#tbbulletin input:hidden[name='note']").each(function () {
                bulletin[$(this).attr("id")] = $(this).val();
            });
            bulletin.billdate = $("#hidbilldate").val();
            bulletin.estType=$("#hidestType").val();
            bulletin.estDate=$("#hidestDate").val();
            bulletin.estBegdate=$("#hidestBegdate").val();
            bulletin.estEnddate=$("#hidestEnddate").val();
//            var d = $("#hidbulletindt").val();
//            if (!d || d.length != 6 || isNaN(d) || parseInt(d) < 1) {
//                return "";
//            }
            //bulletin.BILLDATE = d.substring(0, 4) + "-" + d.substring(4) + "-01";

            return bulletin;
        }
        function bindDate(obj){
          var y,m,d;
          if(obj){
            var $e = $(obj);
            var v = $e.val();
            y = v.substring(0, 4);
            m = v.substring(5, 7); 
            d = v.substring(8);
            if (m.indexOf("0")==0) m = m.substring(1);
            if (d.indexOf("0")==0) d = d.substring(1);
          }else{
            var now = new Date();
            y=now.getFullYear();
            m=now.getMonth()+1;
            d=now.getDate();
            $("#txtCurDate").val(y + "-" + (String(m).length == 1 ? ("0" + m) : m) + "-" + (String(d).length == 1 ? ("0" + d) : d));
          }
          var curlst=new Date(y, m * 1, 0);
          
          var cury = curlst.getFullYear(), curm = curlst.getMonth() + 1, curlstd = curlst.getDate();
          var curlstdt = cury + "-" + (String(curm).length == 1 ? ("0" + curm) : curm) + "-" + (String(curlstd).length == 1 ? ("0" + curlstd) : curlstd);
          $("#txtREndDate").val(curlstdt);
          if (curlstd > d * 1) {
              var nxtd = d * 1 + 1;
              $("#txtRStartDate").val(cury + "-" + (String(curm).length == 1 ? ("0" + curm) : curm) + "-" + (String(nxtd).length == 1 ? ("0" + nxtd) : nxtd));
          } else {
              $("#txtRStartDate").val(curlstdt);
          }
        }
        
        function doajax(url,obj,callback,un){
          $.ajax({
			type : "post",
			url : url,
			dataType : "text",
			data : obj,
			error : function(xmlHttpRequest, textStatus, errorThrown) {
				if (textStatus == "timeout") {
					alert("请求超时，请稍后重试！");
				} else {
					alert(textStatus);
					alert("网络忙，请稍后重试!");
				}
			},
			success : function(data, textStatus) {
				callback(data);
			},
			beforeSend : function() {
				loading();
			},
			complete : function() {
				if(!un)unloading();
			}
		  });
        }
		function loading() {
	        art.dialog({
	            title: "Loading",
	            id: "loading",
	            lock: true,
	            background: '#000', // 背景色
	            opacity: 0.2, // 透明度
	            esc: false,
	            padding: "20px 50px",
	            drag: false,
	            resize: false,
	            init: function () { $(".aui_close").hide(); },
	            fixed: true
	        });
    	}
	    function unloading() {
	        $(".aui_close").show();
	        if (art.dialog.list['loading'] == undefined)
	            return;
	        else {
	            art.dialog.list['loading'].close();
	        }
	    }
        $(document).ready(function () {
            rebinddayflagsofbulletin();
            bindDate();
			
            $("#txtCurDate").blur(function () {
                bindDate(this);
            });

            $("#btnbulletinquery").click(function () {
                var v = $("#slbulletin").val();
                if (!v) return;
                var url = baseHref+"agt/bulletin/lastbydayflag.do";//$.getUrl("Report/AgtBulletin/GetBulletinByDayFlag");
                var callback=function(data){
                  if (!data) {
                          alert("无记录");
                          return;
                        }
                        var cnt = data;//result.Content;
	                    if (!cnt) {
	                        alert("无记录");
	                        return;
	                    }
	                    var obj = $.parseJSON(cnt);
	                    rebindbulletin(obj);
                };
                doajax(url,{dayflag:v*1},callback);
            });

            $("#QueryModel").change(function () {
                var v = $(this).val();
                if ("A" == v) {
                    $("#tdlbRegion,#tdiptRegionF,#tdiptRegionT").hide();
                    $("#divdailysum table tbody,#divdailysum2 table tbody").empty();
                    //$("#fs1").show();
                    $("#fs2").hide();
                } else if ("S" == v) {
                    $("#tdlbRegion,#tdiptRegionF,#tdiptRegionT").show();
                    $("#divdailysum table tbody,#divdailysum2 table tbody").empty();
                    //$("#fs1").show();
                    $("#fs2").hide();
                } else if ("SD" == v) {
                    $("#tdlbRegion,#tdiptRegionF,#tdiptRegionT").show();
                    $("#divdailysum table tbody,#divdailysum2 table tbody").empty();
                    $("#fs2").show(); $("#hidbegdt,#hidenddt").val("");
                    //$("#fs1").hide();
                }
            });

            $("#view").click(function () {
                $("#divdailysum table tbody").empty();
                $("#divdailysum2 table tbody").empty();
                $("#hidbegdt,#hidenddt").val("");

                var jsonCondition = {};
                jsonCondition.isTimeBucket = 'Y';
                jsonCondition.dayFlag = parseInt($("#txtCurDate").val().replace(/-/g, ''));
                if (jsonCondition.dayFlag <= 0 || String(jsonCondition.dayFlag).length != 8) {
                    alert("查询条件非法");
                    return;
                }

                var url = baseHref+"agt/bulletin/viewdailysum.do";//$.getUrl("Report/AgtBulletin/QueryDailySumOfInternation");
                var parm={condition: $.toJSON(jsonCondition)};
                var callback=function(data){
                  if(data){
                    var obj=$.parseJSON(data);
                    var $tb=$("#tbdailysum");
                    var ths=$("thead tr th",$tb);
                    var html="<tr>";
                    ths.each(function(){
                      var attr=$(this).attr("tag");
                      html +="<td tag='"+attr+"' "+($(this).is(":hidden")? "style='display:none;'":"")+">"+obj[attr]+"</td>";
                    });
                    html +="</tr>";
                    $tb.append(html);
                  }else alert('查询失败');
                };
                var sd=false;
                if ("SD" == $("#QueryModel").val())sd=true;
                doajax(url,parm,callback,sd);
                
                if (sd) {
                    jsonCondition.isTimeBucket = 'N';
                    jsonCondition.beginDate = $("#txtRStartDate").val();
                    jsonCondition.endDate = $("#txtREndDate").val();

                    $("#hidbegdt").val(jsonCondition.beginDate);
                    $("#hidenddt").val(jsonCondition.endDate);
                    parm.condition= $.toJSON(jsonCondition);
                    var callback2=function(data){
                      if(data){
	                    var arr=$.parseJSON(data);
	                    var $tb=$("#tbdailysum2");
	                    var ths=$("thead tr th",$tb);
	                    for(var i in arr){
	                      var html="<tr tag='"+arr[i].customer+"'>";
	                      ths.each(function(){
	                        var attr=$(this).attr("tag");
	                        html +="<td tag='"+attr+"' "+($(this).is(":hidden")? "style='display:none;'":"")+">"+(arr[i][attr]=="avg"? "平均值":arr[i][attr])+"</td>";
	                      });
	                      html +="</tr>";
	                      $tb.append(html);
	                    }
	                    
	                  }else alert('?');
                    };
                    doajax(url,parm,callback2); 
                }
                
            });
            $("#estimate").click(function () {
                $("#lgdbulletin").text("快报");
                $("#divbulletin input").val("");
                $("#divbulletin a[name='annotation']").attr("title", '无批注');
                var m = $("#QueryModel").val();
                var jsonCondition = {};
                if ('A' == m) {
                    jsonCondition.isTimeBucket = 'N';
                    jsonCondition.dayFlag = parseInt($("#txtCurDate").val().replace(/-/g, ''));
                } else if ('S' == m) {
                    jsonCondition.isTimeBucket = 'Y';
                    jsonCondition.dayFlag = parseInt($("#txtCurDate").val().replace(/-/g, ''));
                    jsonCondition.beginDate = $("#txtRStartDate").val();
                    jsonCondition.endDate = $("#txtREndDate").val();
                } else if ('SD' == m) {
                    jsonCondition.dayFlag = parseInt($("#txtCurDate").val().replace(/-/g, ''));
                    jsonCondition.beginDate = $("#txtRStartDate").val();
                    jsonCondition.endDate = $("#txtREndDate").val();

                    if (jsonCondition.beginDate == $("#hidbegdt").val() && jsonCondition.endDate == $("#hidenddt").val() && $("#divdailysum2").find("tr[tag='avg']").length == 1)
                        jsonCondition.isTimeBucket = 'SD';
                    else jsonCondition.isTimeBucket = 'SDRECOM';
                }
                var url = baseHref+"agt/bulletin/estimate.do";//$.getUrl("Report/AgtBulletin/EstimateBulletin");
                var parm={condition:$.toJSON(jsonCondition)};
                var callback=function(data){
                  var obj = $.parseJSON(data);
                  if (!obj) return;

                    var main = 0, avg = 0, days = 0;
                    var $tr = null;
                    if ('SD' == jsonCondition.isTimeBucket) {
                        $tr = $("#divdailysum2").find("tr[tag='avg']");
                        var array = $("#hidbegdt").val().split("-");
                        var begdt = new Date(array[0], array[1], array[2]);
                        array = $("#hidenddt").val().split("-");
                        var enddt = new Date(array[0], array[1], array[2]);
                        days = parseInt((enddt - begdt) / 86400000) + 1;
                    }

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='cgo']").text()) * days;
                    if (obj.cgo != undefined && obj.cgo != null && !isNaN(obj.cgo))
                        $("#cgo").val(Math.round(parseFloat(obj.cgo) + (isNaN(avg) ? 0 : avg)));
                    else $("#cgo").val(isNaN(avg) ? 0 : avg);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='cgoFee']").text()) * days;
                    var cgofee = parseFloat(obj.cgofee);
                    cgofee = Math.round((isNaN(cgofee) ? 0 : cgofee) + (isNaN(avg) ? 0 : avg));
                    main += cgofee;
                    $("#cgofee,#cgofeerate").val(cgofee);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='cgoe']").text()) * days;
                    if (obj.cgoe != undefined && obj.cgoe != null && !isNaN(obj.cgoe))
                        $("#cgoe").val(Math.round(parseFloat(obj.cgoe) + (isNaN(avg) ? 0 : avg)));
                    else $("#cgoe").val((isNaN(avg) ? 0 : avg));

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='cgoeFee']").text()) * days;
                    var cgoefee = parseFloat(obj.cgoefee);
                    cgoefee = Math.round((isNaN(cgoefee) ? 0 : cgoefee) + (isNaN(avg) ? 0 : avg));
                    main += cgoefee;
                    $("#cgoefee,#cgoefeerate").val(cgoefee);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='expressFee']").text()) * days;
                    var expressfee = parseFloat(obj.expressmoney);
                    expressfee = Math.round((isNaN(expressfee) ? 0 : expressfee) + (isNaN(avg) ? 0 : avg));
                    main += expressfee;
                    $("#expressmoney,#expressmoney1").val(expressfee);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='bupFee']").text()) * days;
                    var bupfee = parseFloat(obj.bupmoney);
                    bupfee = Math.round((isNaN(bupfee) ? 0 : bupfee) + (isNaN(avg) ? 0 : avg));
                    main += bupfee;
                    $("#bupmoney,#bupmoney1").val(bupfee);

                    $("#main,#main1").val(main);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='sceneFee']").text()) * days;
                    var scene = parseFloat(obj.scene);
                    scene = Math.round((isNaN(scene) ? 0 : scene) + (isNaN(avg) ? 0 : avg));
                    main += scene;
                    $("#scene").val(scene);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='arrDeclare']").text()) * days;
                    var arr = parseFloat(obj.arr);
                    arr = Math.round((isNaN(arr) ? 0 : arr) + (isNaN(avg) ? 0 : avg));
                    main += arr;
                    $("#arr").val(arr);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='ciq']").text()) * days;
                    var ciq = parseFloat(obj.ciq);
                    ciq = Math.round((isNaN(ciq) ? 0 : ciq) + (isNaN(avg) ? 0 : avg));
                    main += ciq;
                    $("#ciq").val(ciq);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='f4store']").text()) * days;
                    var f4store = parseFloat(obj.f4store);
                    f4store = Math.round((isNaN(f4store) ? 0 : f4store) + (isNaN(avg) ? 0 : avg));
                    main += f4store;
                    $("#f4store").val(f4store);

                    if ($tr != null) avg = parseFloat($tr.find("td[tag='houseFee']").text()) * days;
                    var housefee = parseFloat(obj.housefee);
                    housefee = Math.round((isNaN(housefee) ? 0 : housefee) + (isNaN(avg) ? 0 : avg));
                    main += housefee;
                    $("#housefee").val(housefee);

                    $("#red").val(main);
                    $("#net").val(Math.round(main / 1.06));
                    $("#tbbulletin input[name='RATE']").val("1");
                    $("#hiddayflag").val(obj.dayflag);
                    $("#hidbilldate").val(obj.billdate);
            $("#hidestType").val(obj.estType);
            $("#hidestDate").val(obj.estDate);
            $("#hidestBegdate").val(obj.estBegdate);
            $("#hidestEnddate").val(obj.estEnddate);
                    var bdate = new Date(obj.billdate);
                    $("#lgdbulletin").text("快报(" + bdate.getFullYear() + "-" + (bdate.getMonth()<9? ("0"+(bdate.getMonth()+1)):(bdate.getMonth()+1)) + "月)");
                };
                doajax(url,parm,callback);
                
            });

            $("#tbbulletin input:visible").blur(function () {
                var v = $(this).val();
                if (v && !isNaN(v)) $(this).val(Math.round(parseFloat($(this).val())));
                else $(this).val('');
                var name = $(this).attr("name");
                if (name) sumfee();
            }).change(function () {
                
            });

            $("#tbbulletin input[name='FEE']").blur(function () {
                var fee = $(this).val();
                var $tr = $(this).closest("tr");
                if (fee && !isNaN(fee)) {
                    var rf = $tr.find("input[name='RATE']");
                    if (rf.length < 1) $tr.find("input[name='RFEE']").val(fee);
                    else {
                        var r = rf.val();
                        $tr.find("input[name='RFEE']").val(Math.round(fee * r));
                    }
                } else $tr.find("input[name='RFEE']").val('');
                var name = $(this).attr("name");
                if (name) sumfee();
            });

            $("#adjustweight").blur(function () {
                var v = $(this).val();
                if (v && !isNaN(v)) {
                    var kg = parseFloat(v);
                    var fee = Math.round(kg * 0.4);
                    var $tr = $(this).closest("tr");
                    $tr.find("input[name='FEE']").val(fee);
                    var rf = $tr.find("input[name='RATE']");
                    if (rf.length < 1) $tr.find("input[name='RFEE']").val(fee);
                    else {
                        var r = rf.val();
                        $tr.find("input[name='RFEE']").val(Math.round(fee * r));
                    }
                } //else $(this).closest("tr").find("input[name='FEE']").val('');
                //sumfee();
                var name = $(this).attr("name");
                if (name) sumfee();
            });

            

            $("a[name='annotation']").click(function () {
                var $a = $(this);
                $("#txtareanote").val("");
                var defaults = {
                    title: "批注",
                    content: $("#divnote")[0],
                    lock: true,
                    width: 'auto',
                    height: 'auto',
                    background: '#bcc7d8', // 背景色
                    opacity: 0.8, // 透明度
                    button: [{
                        name: "确定", callback: function () {
                            var v = $("#txtareanote").val();
                            $a.closest("td").find("input:hidden").val(v);
                            if (v) $a.attr("title", v);
                            else $a.attr("title", '无批注');
                            return true;
                        }
                    }]
                };
                $("#txtareanote").val($a.closest("td").find("input:hidden").val());
                $.dialog(defaults);
            });

            $("#BulletinSave").click(function () {
                var bulletin = getbulletin();

                var d = bulletin.billdate;
                if (!d || isNaN(d) || parseInt(d) < 1) {
                    alert("快报账期非法");
                    return;
                }
                /*bulletin.billdate = d.substring(0, 4) + "-" + d.substring(4) + "-01";*/
                var url = baseHref+"agt/bulletin/add.do";
                var callback=function(data){
                  if (!data) {
                    alert("保存失败");
                    return;
                  }
                     if(Number(data)==1){
                       $("#divbulletin input").val("");
                	   $("#divbulletin a[name='annotation']").attr("title", '无批注');
                       alert("保存成功");
                     }else alert("保存失败");
                     
                  rebinddayflagsofbulletin();
                  return;
                };
                doajax(url,{model: $.toJSON(bulletin)},callback);
            });
            $("#BulletinExp").click(function () {
                var bulletin = getbulletin();
                var d = bulletin.billdate;
                 if (!d || isNaN(d) || parseInt(d) < 1) {
                    alert("快报账期非法");
                    return;
                }
                /*bulletin.BILLDATE = d.substring(0, 4) + "-" + d.substring(4) + "-01"; */
                bulletin.dayflag = $("#hiddayflag").val();

                var url = baseHref+"agt/bulletin/export.do";
                //doajax(url,{json: $.toJSON(bulletin)},callback);
                
                    $("form[name='download']").remove();
                    var $f = $("<form name='download' action='"+url+"' method='post'><input type='hidden' name='bulletinobj' value='" + $.toJSON(bulletin) + "'/></form>");
                    $f.appendTo("body")
                    $f.css('display', 'none')
                    $f.submit();
            });
        });
    </script>
<title>代理人(国际)快报</title>
</head>
<body style="min-width: 960px">
<div class="form">
	<h3 class="fTitle">代理人快报(国际)</h3>
</div>
<div class="formContainer2">
  <table width="99%" align="center" class="table-form" style="margin: 0; padding: 0">
        <tr>
            <td>
                <div class="form">
                    <table class="table-form" align="left" style="width: 800px;">
                        <tbody>
                            <tr>
                                <td align="right">
                                    <label class="formbox-title">估算类型</label>
                                </td>
                                <td>
                                    <select id="QueryModel" style="width: 150px !important;">
                                      <option value="A">按平均数估算</option>
                                      <option value="S">按指定日期估算</option>
                                      <option value="SD">按指定日期双周平均估算</option>
                                    </select>
                                </td>
                                <td align="right">
                                    <label class="formbox-title">当前日期</label>
                                </td>
                                <td>
                                    <input type="text" class="inputText Wdate" style="width: 89px !important;" runat="server" visible=true 
                                        id="txtCurDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" />    
                                </td>
                                <td align="right" id="tdlbRegion" style="display: none">
                                    <label class="formbox-title">指定起止日期</label>
                                </td>
                                <td id="tdiptRegionF" style="display: none">
                                  <input type="text" class="inputText Wdate" style="width: 89px !important;" 
                                      id="txtRStartDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});" />   
                                </td>
                                <td id="tdiptRegionT" style="display: none">  
                                  <input type="text" class="inputText Wdate" style="width: 89px !important;" 
                                      id="txtREndDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd', autoPickDate: true});"/>
                                </td>
                                <td align="left">
                                    <input type="button" id="view" style="width: 90px;" value="查看日报总和"/>
                                </td>
                                <td align="left">
                                    <input type="button" id="estimate" style="width: 90px;" value="估算"/>
                                </td>
                                <td align="left">
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<div id="SearchResult">
  <fieldset title="总和" id="fs1">
      <legend>日报总和</legend>
      <div id="divdailysum">
      <table id="tbdailysum" class="table-default" >
        <thead>
        <tr>
            <th tag="acgo">
                指定货货量
            </th>
            <th tag="acgoFee">
                指定货金额
            </th>
            <th tag="uacgo">
                非指定货货量
            </th>
            <th tag="uacgoFee">
                非指定货金额
            </th>
            <th tag="cgo">
            进港货货量
            </th>
            <th tag="cgoFee">
            进港货费用
            </th>
            <th tag="scene">
            现场提货货量
            </th>
            <th tag="sceneFee">
            现场提货费用
            </th>
            <th tag="express">
            快件货量
            </th>
            <th tag="expressFee">
            快件费用
            </th>
            <th style="display:none;" tag="bup">
            整板箱货量
            </th>
            <th style="display:none;" tag="bupFee">
            整板箱费用
            </th>
            <th tag="house">
                分单发货货量
            </th>
            <th tag="houseFee">
                分单发货金额
            </th>
            <th tag="f4store">
                仓储费金额
            </th>
            <th style="display:none;" tag="shortspti">
            进港短驳费用
            </th>
            <th tag="cgoe">
                出港货货量
            </th>
            <th tag="cgoeFee">
                出港货费用
            </th>
            <th style="display:none;" tag="shortspte">
            出港短驳费用
            </th>
            <th tag="arrDeclare">
                运抵费
            </th>
            <th style="display:none;" tag="packing">
                打板费
            </th>
            <th style="display:none;" tag="adjPor">
                出港调整
            </th>
            <th tag="adjCiq">
                检疫调整费用				
            </th>
            <th tag="amount">
                进港合计费用
            </th>
            <th tag="por">
                出港合计费用
            </th>
            <th tag="ciq">
                检疫费用
            </th>
            <th tag="income">
                总收入
            </th>
        </tr>
    </thead>
        <tbody>
        </tbody>
      </table>
      </div>
    </fieldset>
    <fieldset id="fs2" style="display:none;">
    <legend>指定日总和</legend>
    <input type="hidden" id="hidbegdt"/>
    <input type="hidden" id="hidenddt"/>
    <div id="divdailysum2">
    <table id="tbdailysum2" class="table-default" >
        <thead>
        <tr>
        <th tag="customer">指定日</th>
            <th tag="acgo">
                指定货货量
            </th>
            <th tag="acgoFee">
                指定货金额
            </th>
            <th tag="uacgo">
                非指定货货量
            </th>
            <th tag="uacgoFee">
                非指定货金额
            </th>
            <th tag="cgo">
            进港货货量
            </th>
            <th tag="cgoFee">
            进港货费用
            </th>
            <th tag="scene">
            现场提货货量
            </th>
            <th tag="sceneFee">
            现场提货费用
            </th>
            <th tag="express">
            快件货量
            </th>
            <th tag="expressFee">
            快件费用
            </th>
            <th style="display:none;" tag="bup">
            整板箱货量
            </th>
            <th style="display:none;" tag="bupFee">
            整板箱费用
            </th>
            <th tag="house">
                分单发货货量
            </th>
            <th tag="houseFee">
                分单发货金额
            </th>
            <th tag="f4store">
                仓储费金额
            </th>
            <th style="display:none;" tag="shortspti">
            进港短驳费用
            </th>
            <th tag="cgoe">
                出港货货量
            </th>
            <th tag="cgoeFee">
                出港货费用
            </th>
            <th style="display:none;" tag="shortspte">
            出港短驳费用
            </th>
            <th tag="arrDeclare">
                运抵费
            </th>
            <th style="display:none;" tag="packing">
                打板费
            </th>
            <th style="display:none;" tag="adjPor">
                出港调整
            </th>
            <th tag="adjCiq">
                检疫调整费用				
            </th>
            <th tag="amount">
                进港合计费用
            </th>
            <th tag="por">
                出港合计费用
            </th>
            <th tag="ciq">
                检疫费用
            </th>
            <th tag="income">
                总收入
            </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    </div>
    </fieldset>
    <fieldset>
      <legend id="lgdbulletin">快报</legend>
      <label>快报日期:</label>
      <select id="slbulletin" style="width:110px;"></select>
      <input type="button" value="快报查询" id="btnbulletinquery" style="width:90px;"/>
      <div class="report" id="divbulletin">
        <input type="hidden" id="hiddayflag" />
        <input type="hidden" id="hidbilldate"/>
        <input type="hidden" id="hidestType"/>
        <input type="hidden" id="hidestDate"/>
        <input type="hidden" id="hidestBegdate"/>
        <input type="hidden" id="hidestEnddate"/>
        <table id="tbbulletin" style="width:700px;">
          <tr>
          <td></td>
          <td>吨位(KG)</td>
          <td>金额</td>
          <td>折算率</td>
          <td>折算金额</td>
          <td>税前金额</td>
          <td></td>
          <td></td>
          </tr>
          <tr>
          <td>国际进港</td>
          <td><input type="text" class="inputText autoUpper" id="cgo" name="KG"/></td>
          <td><input type="text"  class="inputText autoUpper" id="cgofee" name="FEE"/></td>
          <td><input type="text"  class="inputText autoUpper" value="1" id="cgorate" name="RATE"/></td>
          <td><input type="text"  class="inputText autoUpper" id="cgofeerate" name="RFEE"/></td>
          <td><input type="text"  class="inputText autoUpper" id="charter" name="FFEE"/></td>
          <td>-包机</td>
          <td></td>
          </tr>
          <tr>
          <td>国际出港</td>
          <td><input type="text"  class="inputText autoUpper" id="cgoe" name="KG"/></td>
          <td><input type="text"  class="inputText autoUpper" id="cgoefee" name="FEE"/></td>
          <td><input type="text"  class="inputText autoUpper" value="1" id="cgoerate" name="RATE"/></td>
          <td><input type="text"   class="inputText autoUpper" id="cgoefeerate" name="RFEE"/></td>
          <td><input type="text"  class="inputText autoUpper" id="adjustmoney2" name="FFEE"/></td>
          <td>调整数
          <a title="无批注" name="annotation" class="action-link">批注</a>
          <input type="hidden" id="adjust2note" name="note"/>
          </td>
          <td><%--<textarea id="ADJUST2NOTE"></textarea>--%>
          
          </td>
          </tr>
          <tr>
          <td>当月调整数</td>
          <td><input type="text"  class="inputText autoUpper" id="adjustweight" name="KG"/></td>
          <td><input type="text"  class="inputText autoUpper" id="adjustmoney" name="FEE"/></td>
          <td></td>
          <td><input type="text"  class="inputText autoUpper" id="adjustmoney1" name="RFEE"/></td>
          <td><input type="text"  class="inputText autoUpper" id="scene" name="FFEE"/></td>
          <td>现场提货</td>
          <td></td>
          </tr>
          <tr>
          <td>快件</td>
          <td></td>
          <td><input type="text"  class="inputText autoUpper" id="expressmoney" name="FEE"/></td>
          <td></td>
          <td><input type="text"  class="inputText autoUpper" id="expressmoney1" name="RFEE"/></td>
          <td><input type="text"  class="inputText autoUpper" id="bozton" name="FFEE"/></td>
          <td>宝帧通分成</td>
          <td></td>
          </tr>
          <tr>
          <td>BUP</td>
          <td></td>
          <td><input type="text"  class="inputText autoUpper" id="bupmoney" name="FEE"/></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="bupmoney1" name="RFEE"/></td>
          <td><input type="text" class="inputText autoUpper" id="arr" name="FFEE"/></td>
          <td>运抵</td>
          <td></td>
          </tr>
          <tr>
          <td>合计</td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="main"/></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="main1"/></td>
          <td><input type="text" class="inputText autoUpper" id="ciq" name="FFEE"/></td>
          <td>校验检疫</td>
          <td></td>
          </tr>
          <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="drayage" name="FFEE"/></td>
          <td>西区PDX/DHL短驳费</td>
          <td></td>
          </tr>
          <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="f4store" name="FFEE"/></td>
          <td>仓储</td>
          <td></td>
          </tr>
          <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="housefee" name="FFEE"/></td>
          <td>分单发货</td>
          <td></td>
          </tr>
          <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><input type="text" class="inputText autoUpper" id="red"/></td>
          <td>红冲(主营)
          <a title="无批注" name="annotation" class="action-link">批注</a>
          <input type="hidden" id="rednote" name="note"/>
          </td>
          <td>
          <%--<textarea id="REDNOTE"></textarea>--%>
          
          </td>
          </tr>
          <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td><input type="text"  class="inputText autoUpper" id="net"/>
          <a title="无批注" name="annotation" class="action-link">批注</a>
          <input type="hidden" id="netnote" name="note"/>
          </td>
          <td><%--<textarea id="NETNOTE"></textarea>--%>
          
          </td>
          </tr>
        </table>
      </div>
      <input type="button" value="保存快报" style="width: 90px;" id="BulletinSave"/>
        <input type="button" value="导出快报" style="width: 90px;" id="BulletinExp"/>
    </fieldset>
    <div id="divnote" style="display:none;">
      <textarea id="txtareanote" class="inputText" style="width:350px;height:80px">
      </textarea>
    </div>
</div>
	
</body>
</html>