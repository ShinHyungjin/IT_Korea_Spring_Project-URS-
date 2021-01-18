<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List<Member> memberList = (List)request.getAttribute("memberList");
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>


function remove(obj){
      $.ajax({
         url:"/admin/store/memberdelete",
         type:"get",
         data:{
            member_id:obj
         },
         success:function(result){
           console.log(result);
            $("#member_table").empty();
            $("#member_table").removeClass("member_table");
            $("#member_table").addClass("member_table");
            $("#table").removeClass("table table-hover");
            $("#table").addClass("table table-hover");
            for(var i=0; i<result.length; i++) {
               var member = result[i];
               $("#member_table").append("<tr>");   
               $("#member_table").append("<th scope=\"row\">"+member.member_id+"</th>");
               $("#member_table").append("<th scope=\"row\">"+member.user_id+"</th>");
               $("#member_table").append("<td><a href=\"/admin/memberdetail?member_id="+member.member_id+"\">"+member.user_name+"</a></td>");
               $("#member_table").append("<td><img src=\"/resources/data/member/"+member.member_id+"."+member.user_image+"\" width=\"100rem\" height=\"100rem\"></td>");
               $("#member_table").append("<td>"+member.user_position+"</td>");
               $("#member_table").append("<td><button class=\"btn btn-primary\" mdbWavesEffect type=\"button\" onClick=\"remove("+member.member_id+");\">삭제</button></td>");
               $("#member_table").append("</tr>");
            }
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
           <table class="table table-hover">
              <thead>
                   <tr class="table-primary">
                     <th scope="col">No</th>
                     <th scope="col">유저 ID</th>
                     <th scope="col">유저 이름</th>
                     <th scope="col">유저 사진</th>
                     <th scope="col">고객/점포</th>
                     <th scope="col">삭제</th>
                    </tr>
              </thead>
              <tbody class="member_table" id="member_table">
                 <%for(Member member : memberList){ %>
                   <tr>
                     <th scope="row"><%=member.getMember_id()%></th>
                     <td><%=member.getUser_id()%></td>
                     <td><a href="/admin/memberdetail?member_id=<%=member.getMember_id()%>"><%=member.getUser_name()%></td>
                     <td><img alt="profile_image" id="blah" src="/resources/data/member/<%if(member.getUser_image() == null){ %>deafultProfile.jpg<%}else{%><%=member.getMember_id()+"."+member.getUser_image() %><%}  %>" width="100rem" height="100rem"></td>
                     <td><%=member.getUser_position() %></td>
                     <td><button class="btn btn-primary" mdbWavesEffect type="button" onClick="remove(<%=member.getMember_id()%>);">삭제</button></td>
                   </tr>
                   <%} %>
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