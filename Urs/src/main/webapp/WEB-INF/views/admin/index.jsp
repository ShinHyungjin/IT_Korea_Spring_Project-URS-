<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List<Category> categoryList = (List)request.getAttribute("categoryList");
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
function getStoreList(obj){
   $.ajax({
      url:"/admin/store",
      type:"get",
      data:{
         category_id:obj
      },
      success:function(result){
         $("#store_table").empty();
         $("#store_table").removeClass("store_table");
         $("#store_table").addClass("store_table");
         $("#table").removeClass("table table-hover");
         $("#table").addClass("table table-hover");
         for(var i=0; i<result.length; i++) {
            var store = result[i];
            $("#store_table").append("<tr>");   
            $("#store_table").append("<th scope=\"row\">"+store.store_id+"</th>");
            $("#store_table").append("<td><a href=\"/admin/store/storedetail?store_id="+store.store_id+"\">"+store.store_name+"</a></td>");
            $("#store_table").append("<td><img src=\"/resources/data/store/"+store.member_id+"M."+store.store_image+"\" width=\"100rem\" height=\"100rem\"></td>");
            $("#store_table").append("<td>"+store.store_pass+"</td>");
            $("#store_table").append("<td>"+store.store_name+"</td>");
            $("#store_table").append("<td><button class=\"btn btn-primary\" mdbWavesEffect type=\"button\" onClick=\"remove("+store.store_id+");\">삭제</button></td>");
            $("#store_table").append("</tr>");
         }
      }
   });
}

function remove(obj){
      $.ajax({
         url:"/admin/store/storedelete",
         type:"get",
         data:{
            store_id:obj
         },
         success:function(result){
            $("#store_table").empty();
            $("#store_table").removeClass("store_table");
            $("#store_table").addClass("store_table");
            $("#table").removeClass("table table-hover");
            $("#table").addClass("table table-hover");
            for(var i=0; i<result.length; i++) {
               var store = result[i];
               $("#store_table").append("<tr>");   
               $("#store_table").append("<th scope=\"row\">"+store.store_id+"</th>");
               $("#store_table").append("<td><a href=\"/admin/store/storedetail?store_id="+store.store_id+"\">"+store.store_name+"</a></td>");
               $("#store_table").append("<td><img src=\"/resources/data/store/"+store.member_id+"M."+store.store_image+"\" width=\"100rem\" height=\"100rem\"></td>");
               $("#store_table").append("<td>"+store.store_pass+"</td>");
               $("#store_table").append("<td>"+store.store_name+"</td>");
               $("#store_table").append("<td><button class=\"btn btn-primary\" mdbWavesEffect type=\"button\" onClick=\"remove("+store.store_id+");\">삭제</button></td>");
               $("#store_table").append("</tr>");
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
        <h1 class="my-4">Shop Name</h1>
        <div class="list-group">
        <%for(Category category : categoryList){ %>
          <a onClick="getStoreList(<%=category.getCategory_id()%>)" class="list-group-item"><img src="resources/data/category/<%=category.getCategory_image() %>" width="30rem" height="30rem" >&nbsp <%=category.getCategory_name()%></a>
          <%} %>
        </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">

        <div id="carouselExampleIndicators" class="carousel slide my-1" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" src="/resources/images/bg_1.jpg" width="900rem" height="350rem" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="/resources/images/bg_2.jpg" width="900rem" height="350rem" alt="Second slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="/resources/images/bg_3.jpg" width="900rem" height="350rem" alt="Third slide">
            </div>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>

        <div class="row">

     <table class="table table-hover" id="table">
        <thead>
          <tr class="table-primary">
            <th scope="col">등록순번</th>
            <th scope="col">가게 이름</th>
            <th scope="col">가게 대표 사진</th>
            <th scope="col">가게 예약 유무</th>
            <th scope="col">가게 종류</th>
            <th scope="col">점포 삭제</th>
          </tr>
        </thead>
        <tbody class="store_table" id="store_table">
        <%for(Store store : storeList){ %>
          <tr>
            <th scope="row"><%=store.getStore_id() %></th>
            <td><a href="/admin/store/storedetail?store_id=<%=store.getStore_id()%>"><%=store.getStore_name() %></a></td>
            <td><img src="/resources/data/store/<%=store.getMember_id()%>M.<%=store.getStore_image()%>" width="100rem"></td>
            <td><%=store.getStore_pass() %></td>
            <td><%=store.getCategory().getCategory_name()%></td>
            <td><button class="btn btn-primary" mdbWavesEffect type="button" onClick="remove(<%=store.getStore_id()%>);">삭제</button></td>
          </tr>
          <%} %>
        </tbody>
      </table>

        </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

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