<%@page import="com.sbj.urs.model.Common.Formatter"%>
<%@page import="com.sbj.urs.model.domain.Reservation"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.sbj.urs.model.domain.Receipt"%>
<%@page import="com.sbj.urs.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%    
	List<Receipt> receiptList = (List)request.getAttribute("receiptList");
	List<Store> storereservationList = (List)request.getAttribute("storereservationList");
	List<List> reservationList = (List)request.getAttribute("reservationList");
	List<Menu> menuList = (List)request.getAttribute("menuList");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Appetizer - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
 
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <%@ include file="../inc/header.jsp" %>
   <!-- Icons font CSS-->
    <link href="/resources/regist/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/resources/regist/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">

    <!-- Vendor CSS-->
    <link href="/resources/regist/vendor/select2/select2.min.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="/resources/regist/css/main.css" rel="stylesheet" media="all">
 
 <style>
 .list-group a {
    text-decoration: none;
    color: #b61c1c; /* For Example */
    cursor:pointer;
}
 </style>
 
 <script> 
 function receipt_detail(i) {
	var receipt_id = $('#receipt-form [name="receipt_id'+i+'"]').val();
	var receipt_regdate = $('#receipt-form [name="receipt_regdate'+i+'"]').val();
	var receipt_totalamount = $('#receipt-form [name="receipt_totalamount'+i+'"]').val();
	var store_name = $('#receipt-form [name="store_name'+i+'"]').val();

	alert("영수증 ID : " + receipt_id + "\n" + "예약 점포 : " + store_name + "\n" + "결제 총 금액 : " + receipt_totalamount + "\n\n" + "결제 날짜 : " + receipt_regdate);
};
 
 
 </script>
 
  </head>
  <body>
    <%@ include file="../inc/top.jsp" %>

    <div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins">
    	<section class="ftco-section">
        	<div class="container">
            	<div class="row">
            		<%for(int i=0; i<receiptList.size(); i++) { %>
					<div class="col-md-4 ftco-animate" id="receipt-quickview">
            			<div class="blog-entry" onClick="javascript:receipt_detail(<%=receiptList.get(i).getReceipt_id()%>);">
              				<a class="block-20" style="background-image: url('/resources/data/store/<%=storereservationList.get(i).getMember_id()%>M.<%=storereservationList.get(i).getStore_image()%>');"></a>
              				<div class="text pt-3 pb-4">
                				<h1 class="heading"><a data-toggle="modal" data-target="#receipt<%=receiptList.get(i).getReceipt_id()%>" ><%=storereservationList.get(i).getStore_name()%></a></h1>
                				<p class="clearfix">
                  				<a class="float-left read"><%=receiptList.get(i).getReceipt_regdate()%></a>
                  				<a class="float-right meta-chat"><span></span><%=Formatter.getCurrentcy(receiptList.get(i).getReceipt_totalamount())%></a>
                				</p>
              				</div>
            			</div>
          			</div>
          			<form id="receipt-form">
          			<input type="hidden" id="receipt_id" name="receipt_id<%=receiptList.get(i).getReceipt_id()%>" value="<%=receiptList.get(i).getReceipt_id()%>">
            		<input type="hidden" id="receipt_regdate" name="receipt_regdate<%=receiptList.get(i).getReceipt_id()%>" value="<%=receiptList.get(i).getReceipt_regdate()%>">
            		<input type="hidden" id="receipt_totalamount" name="receipt_totalamount<%=receiptList.get(i).getReceipt_id()%>" value="<%=receiptList.get(i).getReceipt_totalamount()%>">
            		<input type="hidden" id="store_name" name="store_name<%=receiptList.get(i).getReceipt_id()%>" value="<%=storereservationList.get(i).getStore_name()%>">
          			</form>
          			<%} %>
    
          			
          
        
        		</div>
        		<!-- Row Div End -->
        		<div class="row no-gutters my-5">
          			<div class="col text-center">
            			<div class="block-27">
              				<ul>
                				<li><a href="#">&lt;</a></li>
                				<li class="active"><span>1</span></li>
                				<li><a href="#">2</a></li>
                				<li><a href="#">3</a></li>
                				<li><a href="#">4</a></li>
                				<li><a href="#">5</a></li>
                				<li><a href="#">&gt;</a></li>
              				</ul>
            			</div>
          			</div>
        		</div>
         	</div>
      	</section>
    </div>
 
   <%@ include file="../inc/footer.jsp" %>
 
  </body>
</html>