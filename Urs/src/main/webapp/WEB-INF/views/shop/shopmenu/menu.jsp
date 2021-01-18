<%@page import="com.sbj.urs.model.Common.Formatter"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
   String store_id = (String)request.getParameter("store_id");
   List<Menu> menuList = (List)request.getAttribute("menuList");
   List<String> result = new ArrayList<String>();   
%>
<!DOCTYPE html>
<html lang="en"><!-- Basic -->
<head>
   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">   
   
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
 
     <!-- Site Metas -->
    <title>Untact Reservation System</title> 
    <%@ include file="../inc/header2.jsp" %> <!-- 결제 template용 header2 --> 
    
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Site Icons -->    
    <link rel="apple-touch-icon" href="/resources/images/apple-touch-icon.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/resources/tablecss/bootstrap.min.css">    
   <!-- Site CSS -->
    <link rel="stylesheet" href="/resources/tablecss/style.css">    
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="/resources/tablecss/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/resources/tablecss/custom.css">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond../resources/tablejs/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
#selectMenu, #sendMenu{
   margin:auto;
   width:50%;   
}
#sd{
   width:500px;
}

</style>
<script>
var resultArr = new Array(); //선택한 메뉴 들어있는 List
var appendList = new Array();
appendList.push("<li><span>ID</span><span>Name</span><span>Quantity</span><span><strong>Total</strong></span><span>X</span></li>"); //default값
var beforeQuantity = new Array();
var a=1;
var n=1;
function minusVal(num){
   var cntNum = parseInt($($(".cnt")[num]).val());
   if(cntNum==1) {
      alert("최소 갯수입니다.");
      return false;
   }
   var c = --cntNum;      
   $($(".cnt")[num]).val(c);
   a = cntNum;
};
function plusVal(num){
   var cntNum = parseInt($($(".cnt")[num]).val());      
   var c = ++cntNum;      
   $($(".cnt")[num]).val(c);
   a = cntNum;
};

function del(num){ //완전히 안됨
   var ass = document.getElementById("selectMenu");   // Get the <ul> element with id="myList"
   ass.removeChild(ass.childNodes[num]);     
};

function addMenu(m_id,m_name,m_price,m_quantity) {
      var total = m_price*a; //총 금액
      var quantity = parseInt($($(".cnt")[m_quantity]).val()); //합 갯수            
      $("#selectMenu").append("<li><span>"+m_id+"</span><span>"+m_name+"</span><span id="+n+">"+quantity+"</span> <span><strong>"+total+"</strong></span><button type='button' style='background:#ff084e; color:white;' onClick='del(n)'>X</button></li>");
      beforeQuantity.push(quantity);
      appendList.push("<li><span>"+m_id+"</span><span>"+m_name+"</span><span id="+n+">"+quantity+"</span><span><strong>"+total+"</strong></span><button type='button' style='background:#ff084e; color:white;' onClick='del(n)'>X</button></li>");
      resultArr.push(m_id+","+m_name+","+quantity+","+total); //post로 보낼 Array
      n=n+1;      
            
};

// Table Map으로 파라미터 전송(메뉴선택 Array) --비동기
/*
function checkoutForm() {   
    //배열 선언        
    var objParams = {
          "store_id" : store_id(jsp)로 변경하기,
            "resultArr" : resultArr // 선택한 메뉴 저장            
        };
    //ajax 호출
    $.ajax({
        url         :   "/table",
        dataType    :   "json",
        contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
        type        :   "post",
        data        :   objParams,
        success     :   function(){
              location.href="/table";
                //console.log(retVal.indexMap);            
        }
        /*error       :   function(request, status, error){
            console.log("AJAX_ERROR");
        }*/
    //});
//}

//클릭시
function checkoutForm(){
   var menu_size = $("#selectMenu").children();
   if(menu_size.length<=1){
    alert("메뉴를 선택해주세요!");
    return false;
   }
   
   var resultStr = "";
   for(var i=0; i<resultArr.length; i++){
      resultStr+=resultArr[i]
      if(i!=resultArr.length-1) {resultStr += "/"; }    
   }
   
   $("input[name='resultArr']").val(resultStr);
   $("#sendForm").attr({
      action:"/table",
      method:"post"
   });
   $("#sendForm").submit();       
}
</script>

</head>

<body>
<%@ include file="../inc/top.jsp" %>    
   <!-- Start header -->   
   <!-- End header -->
   
   <!-- Start All Pages -->
   <div class="all-page-title page-breadcrumb">
      <div class="container text-center">
         <div class="row">
            <div class="col-lg-12">
               <h1>Special Menu</h1>
            </div>
         </div>
      </div>
   </div>
   <!-- End All Pages -->
   
   <!-- Start Menu -->
   <div class="menu-box">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="heading-title text-center">
                  <h2>Special Menu</h2>
                  <p>Lorem Ipsum is simply dummy text of the printing and typesetting</p>
               </div>
            </div>
         </div>
         
            <!-- menu list start -->
            <div class="col-9">
               <div class="tab-content" id="v-pills-tabContent">
                  <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                     <div class="row">                                                   
                        <%for(int i=0; i<menuList.size(); i++){ %>
                        <%Menu menu = menuList.get(i); %>                                    
                        <div class="col-lg-4 col-md-6 special-grid drinks">
                           <div class="gallery-single fix">
                              <img src="/resources/data/menu/<%=menu.getMenu_id()%>.<%=menu.getMenu_image() %>" style="width: 250px; height:200px" class="img-fluid" alt="Image">
                              <div class="why-text">
                                 <input type="hidden" value="<%=menu.getMenu_id()%>"/>                                 
                                 <h4><%=menu.getMenu_name() %></h4>
                                 <p>                                 
                                 <form>
                                    <input type="button" value="장바구니 담기" onClick="addMenu('<%=menu.getMenu_id()%>','<%=menu.getMenu_name()%>','<%=menu.getMenu_price()%>','<%=i%>')"/>
                                    <input class="minus" type="button" value="-" style="font-size:20px; width:20px; height:40px;" onClick="minusVal(<%=i%>)"></input>
                                    <input class="cnt" type="text" style="width: 15px; font-size:20px;" value="1"></input>
                                    <input class="plus" type="button" value="+" style="font-size:20px; width:20px; height:40px;" onClick="plusVal(<%=i%>)"></input>
                                 </form>
                                 </p>                                 
                                 <h5><%=Formatter.getCurrentcy(menu.getMenu_price()) %></h5>
                              </div>
                           </div> 
                        </div>
                        <%} %>
                     </div>                                                      
                  </div>
                  <!-- menu list end -->
                  
                  <!-- menu event start -->                  
                  <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                     <div class="row">
                        <%for(int i=0; i<menuList.size(); i++){ %>
                        <%Menu menu = menuList.get(i); %>
                        <div class="col-lg-4 col-md-6 special-grid drinks">
                           <div class="gallery-single fix">
                              <img src="/resources/data/menu/<%=menu.getMenu_id()%>.<%=menu.getMenu_image() %>" class="img-fluid" alt="Image">
                              <div class="why-text">
                                 <h4>Special Drinks 1</h4>
                                 <p>Sed id magna vitae eros sagittis euismod.</p>
                                 <h5> $7.79</h5>
                              </div>
                           </div>                           
                        </div>
                        <%} %>                        
                                       
                        
                     </div>
                  </div>
                  <!-- menu event end -->
               </div>
            </div>            
         </div>
         
         <form id="sendForm">
         <input name="store_id" type="hidden" value="<%=store_id%>"/>
         <input name="resultArr" type="hidden" value=""/>
         
         <ul id="selectMenu" class="cart-total-chart">            
               <li><span>ID</span> <span>Name</span> <span>Quantity</span> <span><strong>Total</strong></span><span>X</span></li>                                             
            </ul>
            <ul id="sendMenu" class="cart-total-chart">              
                <p></p><a id="sendBtn" href="javascript:checkoutForm()" class="btn karl-checkout-btn">테이블 선택</a>               
            </ul>
            </form>
           
      </div>
   </div>
   <!-- End Menu -->
   
   <!-- Start QT -->
   <div class="qt-box qt-background">
      <div class="container">
         <div class="row">
            <div class="col-md-8 ml-auto mr-auto text-center">
               <p class="lead ">
                  " If you're not the one cooking, stay out of the way and compliment the chef. "
               </p>
               <span class="lead">Michael Strahan</span>
            </div>
         </div>
      </div>
   </div>
   <!-- End QT -->
         
   <!-- Start Footer -->   
 
   <!-- End Footer -->
   
   <a href="#" id="back-to-top" title="Back to top" style="display: none;"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></a>

   <!-- ALL JS FILES --> 
   <script src="/resources/tablejs/jquery-3.2.1.min.js"></script>
   <script src="/resources/tablejs/popper.min.js"></script>
   <script src="/resources/tablejs/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
   <script src="/resources/tablejs/jquery.superslides.min.js"></script>
   <script src="/resources/tablejs/images-loded.min.js"></script>
   <script src="/resources/tablejs/isotope.min.js"></script>
   <script src="/resources/tablejs/baguetteBox.min.js"></script>
   <script src="/resources/tablejs/form-validator.min.js"></script>
    <script src="/resources/tablejs/contact-form-script.js"></script>
    <script src="/resources/tablejs/custom.js"></script>
</body>
</html>