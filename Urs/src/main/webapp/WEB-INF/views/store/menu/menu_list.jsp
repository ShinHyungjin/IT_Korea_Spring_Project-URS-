<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List<Menu> menuList = (List)request.getAttribute("menuList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <%@ include file="../inc/header.jsp" %>
  
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
       url:"/store/menu/del",
       type:"get",
       data:{
          menu_id:obj
       },
       success:function(data){
    	 //서버로 부터완료응답을 받으면 로딩바 효과를 중단
			var json = JSON.parse(data);
			if(json.result == 1){
			alert(json.msg);
			location.href="/store/menu"; //추후 로그인 페이지로 보낼예정
			}else{
			alert(json.msg);	
			}
			
			$("#loader").removeClass("loader");//class동적제거
          }
       });
    }
 
 
 

</script>

</head>
 
<body>
  <%@include file="../inc/top.jsp" %>
  <!-- Page Content -->
  <div class="container">
  <div style="height:56px"> </div>
    <div class="row">
      <div class="col-12">
      <table class="table table-hover" id="table">
           <thead>
                <tr class="table-primary">
                  <th scope="col">메뉴 ID</th>
                  <th scope="col">메뉴명</th>
                  <th scope="col">메뉴 사진</th>
                  <th scope="col">가격</th>
                  <th scope="col">재고 상태</th>
                  <th scope="col">삭제</th>
                </tr>
        </thead>
        <tbody class="menu_table" id="menu_table">
        <%for(Menu menu : menuList){ %>
          <tr>
            <th scope="row"><%=menu.getMenu_id()%></th>
            <td><a href="/store/menu/menudetail?menu_id=<%=menu.getMenu_id()%>"><%=menu.getMenu_name()%></a></td>
            <td><img src="/resources/data/menu/<%=menu.getMenu_id()%>.<%=menu.getMenu_image() %>" width="100rem" height="100rem"></td>
            <td><%=menu.getMenu_price()%></td>
            <td><%=menu.getMenu_stock()%></td>
            <td><button class="btn btn-primary" mdbWavesEffect type="button" onClick="remove(<%=menu.getMenu_id()%>);">삭제</button></td>
          </tr>
          <%} %>
          
          <tr>
          <td colspan="6"><button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem"  onclick="location.href='/store/menu/add';">메뉴추가</button></td>
          </tr>
        </tbody>
      </table>
        </div>
      </div>
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