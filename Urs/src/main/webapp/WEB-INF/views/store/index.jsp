<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Reservation"%>
<%@page import="com.sbj.urs.model.domain.Receipt"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   Store store = (Store)request.getAttribute("store");
   List<Receipt> receiptList = (List)request.getAttribute("receiptList");
   List<Member> memberList = (List)request.getAttribute("memberList");
   List<Store> storeList = (List)request.getAttribute("storeList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
   <!-- Bootstrap core CSS -->
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="/resources/css/shop-homepage.css" rel="stylesheet">

<style type="text/css">
.list-group a {
    text-decoration: none;
    color: #b61c1c; /* For Example */
    cursor:pointer;
}
td, th, tr{
   text-align:center;
   vertical-align:middle;
}
.table-hover > tbody > tr:hover {
  background-color: #D2D2D2;
}

</style>

<script>
 
function remove(obj){
    $.ajax({
       url:"/store/manage/payment/paymentdelete",
       type:"get",
       data:{
          receipt_id:obj
       },
       success:function(result){
          $("#receipt_table").empty();
          $("#receipt_table").removeClass("receipt_table");
          $("#receipt_table").addClass("receipt_table");
          $("#table").removeClass("table table-hover");
          $("#table").addClass("table table-hover");
          console.log(result);
          for(var i=0; i<result[0].length; i++) {
             var receipt = result[0][i];
             var member = result[1][i];
             var store = result[2][i];
             $("#receipt_table").append("<tr>");   
             $("#receipt_table").append("<th scope=\"row\">"+receipt.receipt_id+"</th>");
             $("#receipt_table").append("<td><a href=\"/store/manage/payment/paymentdetail?receipt_id="+receipt.receipt_id+"\">"+member.user_name+"</a></td>");
             $("#receipt_table").append("<td>"+store.store_name+"</td>");
             $("#receipt_table").append("<td>"+receipt.receipt_regdate+"</td>");
             $("#receipt_table").append("<td>"+receipt.receipt_totalamount+"</td>");
             $("#receipt_table").append("<td><button class=\"btn btn-primary\" mdbWavesEffect type=\"button\" onClick=\"remove("+receipt.receipt_id+");\">승인</button></td>");
             $("#receipt_table").append("</tr>");
              
          }
       }
    });
 }

</script>

</head>
 
<body>
 <%@include file="./inc/top.jsp" %>
  <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-3">
        <h1 class="my-4"><%=store.getStore_name() %></h1>
        <div class="list-group">
        </div>
      </div>
       <div class="col-lg-9">

        <div style="text-align: center;"><h1>주문 요청</h1></div>

        <div class="row">

     <table class="table table-hover" id="table">
        <thead>
          <tr class="table-primary">
            <th scope="col">결제 ID</th>
                  <th scope="col">예약 고객 이름</th>
                  <th scope="col">예약 점포</th>
                  <th scope="col">예약 날짜</th>
                  <th scope="col">결제 금액</th>
                  <th scope="col">결제 취소 처리</th>
          </tr>
        </thead>
        <tbody class="receipt_table" id="receipt_table">
           <%for(int i=0; i<receiptList.size(); i++){ %>
              <%Receipt receipt = receiptList.get(i); store = storeList.get(i); Member member = memberList.get(i); %>
                   <tr>
                     <th scope="row"><%=receipt.getReceipt_id()%></th>
                     <td><a href="/store/manage/payment/paymentdetail?receipt_id=<%=receipt.getReceipt_id()%>"><%=member.getUser_name()%></a></td>
                     <td><%=store.getStore_name()%></td>
                     <td><%=receipt.getReceipt_regdate()%></td>
                     <td><%=receipt.getReceipt_totalamount()%></td>
                     <td><button class="btn btn-primary" mdbWavesEffect type="button" onClick="remove(<%=receipt.getReceipt_id()%>);">승인</button></td>
                   </tr>
                <%} %>
           </tbody>
         </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2020</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>