<%@page import="com.sbj.urs.model.Common.Formatter"%>
<%@page import="java.util.List"%>
<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="com.sbj.urs.model.domain.Receipt"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
   Receipt receipt = (Receipt)request.getAttribute("receipt");
   Member member = (Member)request.getAttribute("member");
   Store store = (Store)request.getAttribute("store");
   List<Menu> menuList = (List)request.getAttribute("menuList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
   <div style="height: 50px;"></div>
   <%@ include file="../inc/header.jsp" %>
<style type="text/css">
   .alert{
    display: none;
   }
   
   .loader {
     border: 16px solid #ff0000;
     border-radius: 50%;
     border-top: 16px solid #3498db;
     width: 100px;
     height: 100px;
     -webkit-animation: spin 2s linear infinite; /* Safari */
     animation: spin 2s linear infinite;
   }
   
      /* Safari */
   @-webkit-keyframes spin {
     0% { -webkit-transform: rotate(0deg); }
     100% { -webkit-transform: rotate(360deg); }
   }
   
   @keyframes spin {
     0% { transform: rotate(0deg); }
     100% { transform: rotate(360deg); }
   }   
   
   .list-group a {
       text-decoration: none;
       color: #b61c1c; /* For Example */
       cursor:pointer;
   }
   img {
      vertical-align:middle;
   }
</style>

<script>
   function remove() {
      $("#paymentForm").attr({
         action:"/store/manage/payment/paymentdetaildelete",
         method:"post"
      });      
      $("#paymentForm").submit();
   }

   </script>

</head>
 
<body>
   <%@include file="../inc/top.jsp" %>  
  <div style="background-color:#ffffff">
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">'<%=member.getUser_name()%>'고객의 결제 상세 내역</h2>
                    <form id="paymentForm">
                        <div class="row row-space">
                        
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">영수증 ID</label>
                                    <input class="input--style-4" type="text" name="receipt_id" id="receipt_id" value="<%=receipt.getReceipt_id()%>" readonly>
                                  <div class="receipt_id"></div>
                                </div>
                            </div>
                            
                               <div class="col-6">
                                   <div class="input-group">
                                       <label class="label">예약 고객 이름</label>
                                       <input class="input--style-4" type="text" id="user_name" name="user_name" value="<%=member.getUser_name()%>" readonly>             
                                   </div>
                               </div>
                           </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                <div class="input-group">
                                    <label class="label">예약 점포</label>
                                    <input class="input--style-4" type="text" id="store_name" name="store_name" value="<%=store.getStore_name()%>" readonly> 
                                </div>
                            </div>
                             
                             <div class="col-6">
                                <div class="input-group">
                                    <label class="label">예약 일자</label>
                                    <input class="input--style-4" type="text" id="receipt_regdate" name="receipt_regdate" value="<%=receipt.getReceipt_regdate()%>" readonly>
                                </div>
                            </div>
                     </div>
                     
                     <div class="row row-space">
                           <div class="col-12">
                              <label class="label">예약 메뉴</label>
                           </div>
                     </div>
                     <%int menudiv = 0; int menutotal = 0;%>
                     <%if(menuList.size() % 3 != 0) { menudiv = ( menuList.size() / 3 ) + 1; } else { menudiv =  menuList.size() / 3; } %>
                     <%for(int i=0; i<menudiv; i++) { %>
                        <%menutotal = i * 3; %>
                           <div class="row row-space">
                           <%for(int j=menutotal; j<menutotal+3; j++) { %>
                              <%if(j >= menuList.size()) {break;} %>
                              <%Menu menu = menuList.get(j); %>
                                  <div class="col-4">
                                     <div class="p-t-15">
                                          <div style="text-align: center" height="120px" width="120px">
                                              <img alt="menu_image" id="menu_image" src="/resources/data/menu/<%=menu.getMenu_id()%>.<%=menu.getMenu_image()%>"  width="120px" height="120px">
                                           </div>
                                        </div>
                                  </div>
                            <%}menutotal = i * 3; %>
                        </div>
                        <div class="row row-space">
                             <%for(int k=menutotal; k<menutotal+3; k++) { %>
                                <%if(k >= menuList.size()) {break;} %>
                                <%Menu menu = menuList.get(k); %>
                                    <div class="col-4">
                                       <div class="p-t-10">
                                          <label class="label" style="text-align:center" width="120px"><%=menu.getMenu_name()%></label>
                                      </div>
                                   </div>
                             <%}%>
                        </div>
                     <%} %>
                     <div class="p-t-15"> </div>
                     <div class="row row-space">
                           <div class="col-4">
                                    <label class="label">결제 금액</label>
                            </div>
                      </div>
                      
                     <div class="row row-space">
                        <div class="col-6">
                           <div class="input-group">
                              <input class="input--style-4" type="text" id="receipt_totalamount" name="receipt_totalamount" value="<%=Formatter.getCurrentcy(receipt.getReceipt_totalamount())%>" readonly>
                           </div>
                        </div>
                     </div>
                     
                <div id="loader" style="margin:auto"></div>
                <div class="p-t-15">
                   <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="remove();">삭제하기</button>
                   &nbsp;&nbsp;&nbsp;&nbsp;   
                    <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="location.href='/store/manage';">결제 리스트 목록</button>
               </div>
             </form>
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

</body>

</html>