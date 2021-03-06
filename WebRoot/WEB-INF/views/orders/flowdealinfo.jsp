<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>全部流量订单-订单管理-流量运营中心</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="<%=basePath%>static/css/app.min.css?20150209">
<link rel="stylesheet" href="<%=basePath%>static/css/grid/bsgrid.all.min.css">
<meta name="csrf_token">
<meta http-equiv="Expires " content="0 ">
<meta http-equiv="kiben " content="no-cache ">
<%@include file="/WEB-INF/views/common/_ie8support.html"%>
</head>
<body>
	<section id="container">
		<jsp:include page="/WEB-INF/views/common/_top_menu.jsp" flush="true" />
		<jsp:include page="/WEB-INF/views/common/_sidebar.jsp" flush="true" />
		<SECTION id="main-content">
			<SECTION class="wrapper">
				<DIV class="col-md-12">
					<DIV class="panel">
						<DIV class="panel-heading">
						<b class="">${begindateForQuery }</b>&nbsp;&nbsp;至&nbsp;&nbsp;<b>${enddate}</b>&nbsp;&nbsp;&nbsp;
						<c:if test="${status eq 'usered'}"> 
							已使用订单详情
						</c:if>
							
						<c:if test="${status eq 'amount'}"> 
							订单总详情
						</c:if>
						<c:if test="${status eq 'notuser'}"> 
							未使用订单详情
						</c:if>
						
						
						</DIV>
						<DIV class="panel-body">
							<FORM class="form-inline" id="searchForm" role="form" method="get" action="#">
								<input type="hidden" value="1" id="pagenum" />
								<input type="hidden" id="pagesize" value="15" />
								<input type="hidden"  name="status" value="${status }"/>
								<input type="hidden"  name="customerName" value="${customerName }"/>
								<input type="hidden"  name="orderSource" value="${orderSource }"/>
								<input type="hidden"  name="begindateForQuery" value="${begindateForQuery }"/>
								<input type="hidden"  name="enddate" value="${enddate }"/>
								<input type="hidden"  name="distributorName" value="${distributorName }"/>
								<input type="hidden"  name="userCountry"  value="${userCountry }" />
							</FORM>
							
							<p id="status" style="display: none;">${status}</p>
							<table id="searchTable">
								<tr>
									<th w_render="orderidOP" width="10%;">交易ID</th>
									<th w_index="SN" width="10%;">设备机身码</th>
									<th w_index="customerName" width="10%;">客户</th>
									<th w_index="userCountry" width="10%;">国家</th>
									<th w_index="orderAmount" width="5%;">总金额</th>
									<th w_index="flowDays" width="3%;">天数</th>
									<th w_render="OPrealityUserDays" width="3%;">实际使用天数</th>
									<th w_index="ifActivate" width="3%;">是否激活</th>
									<th w_index="panlUserDate" width="10%;">预约开始时间</th>
									<th w_index="flowExpireDate" width="10%;">到期时间</th>
									<th w_index="lastUpdateDate" width="10%;">上次接入时间</th>
									<th w_index="orderStatus" width="5%;">订单状态</th>
									<th w_index="userDay" width="5%;">设备使用天数</th>
									<th w_index="creatorUserName" width="6%;">创建人</th>
									<th w_index="creatorDate" width="10%;">创建时间</th>
								</tr>
							</table>
						</DIV>
					</DIV>
					<DIV class="panel">
						<br />
						<label class="checkbox-items" style="padding: 0 15px;">
							<INPUT class="qb" name="all" value="1" type="checkbox">
							全部
						</label>
						<button id="b">
							<a href="javascript:void(0);">导出到 Excel</a>
						</button>
						<br />
						<br />
					</DIV>
					
					<div><p>备注:</p>
						<p>1、实际使用天数将不会统计在4.20号以前使用过的天数</p>
					</div>
					
				</DIV>
			</SECTION>
		</SECTION>
	</section>
	<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					Hello world!
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">保存</button>
					<button type="button" class="btn btn-primary">取消</button>
				</div>
			</div>
		</div>
	</div>

	<script src="<%=basePath%>static/js/app.min.js?20150209"></script>
	<script src="<%=basePath%>static/js/grid/grid.zh-CN.js"></script>
	<script src="<%=basePath%>static/js/grid/bsgrid.all.min.js"></script>
	<script src="<%=basePath%>static/js/bootbox.min.js"></script>

	<SCRIPT type="text/javascript">
    bootbox.setDefaults("locale","zh_CN");
    	  var gridObj;
          $(function(){
             var pagesize=parseInt($("#pagesize").val());
             gridObj = $.fn.bsgrid.init('searchTable',{
                 url:'<%=basePath%>orders/flowdealorders/flowdealall',
                 pageSizeSelect: true,
                 pageSize:pagesize,
                 autoLoad:false,
                 otherParames:$('#searchForm').serializeArray(),
                 pageSizeForGrid:[15,30,50,100],
                 additionalAfterRenderGrid: function(parseSuccess, gridData, options) {
                	 if(parseSuccess){
                		 $("#pagenum").val(options.curPage);	
                		 var a = $("#searchTable_pt_pageSize").val();
                		 var sta= $("#searchTable_pt_startRow").html();
                		 var end= $("#searchTable_pt_endRow").html();
                		 var cur = $("#searchTable_pt_curPage").html();
                		 var total = $("#searchTable_pt_totalRows").html();
                		 $("#b a").attr("href","exportexecl?customerName=${customerName}&orderStatus=${orderStatus}&distributorName=${distributorName}&begindateForQuery=${begindateForQuery}&enddate=${enddate}&status=${status}&sta="+sta+"&end="+end+"&cur="+cur+"&pagesize="+pagesize+"&total="+total);
                		 $("#pagesize").val(a);
                		 $(".qb").click(function(){
          	        	   if($(this).is(':checked')){
          	        		   $("#b a").attr("href","exportexecl?customerName=${customerName}&orderStatus=${orderStatus}&distributorName=${distributorName}&begindateForQuery=${begindateForQuery}&enddate=${enddate}&status=${status}&all=1&sta="+sta+"&end="+end+"&cur="+cur+"&pagesize="+pagesize+"&total="+total);
          	        	   }
          	           });
                	 }
                 } 
             });
               if($("#pagenum").val()!=""){
	        	   gridObj.page($("#pagenum").val());
	           }else{
	        	   gridObj.page(1);
	           };	          
          });
         
        function orderidOP(record, rowIndex, colIndex, options) {
        	 return '<a title="'+record.flowDealID+'" href="<%=basePath%>orders/flowdealorders/info?flowDealID=' + record.flowDealID + '">详情</a>';
		}
        
        function OPrealityUserDays(record, rowIndex, colIndex, option){
        	 var beginTime='${begindateForQuery }';
        	 var endTime='${enddate}';
       		 return  '<a href="<%=basePath%>devicelogs/flowBySnAndDateTwo?flowOrderID='+record.flowDealID+'&beginTime='+beginTime+'&endTime='+endTime+'TiflowOrderID='+record.flowDealID+'&SN='+record.SN+'">'+record.realityUserDays+'</a>';
        }
        
		//刷新
		function re() {
			$("#order_ID").val('');
			$("#order_customerName").val('');
			gridObj.options.otherParames = $('#searchForm').serializeArray();
			gridObj.refreshPage(); 
		}
	</SCRIPT>
	<jsp:include page="/WEB-INF/views/common/_footer.jsp" flush="true">
		<jsp:param name="matchType" value="exactly" />
	</jsp:include>
</body>
</html>