<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
   Member member = (Member)request.getAttribute("member");
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
   function edit() {
      $("#memberForm").attr({
         action:"/admin/member/memberupdate",
         method:"post"
      });      
      $("#memberForm").submit();
   }
   
   function readURL(input) {
       if (input.files && input.files[0]) {
           var reader = new FileReader();
              
           reader.onload = function (e) {
                  $('#profile_image')
                      .attr('src', e.target.result)
                      .width(250)
                      .height(125);
           };
           reader.readAsDataURL(input.files[0]);
       }
   }
   
</script>

</head>
 
<body>
  <%@include file="../inc/top.jsp" %>
  <div style="background-color:#ffffff">
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">'<%=member.getUser_name()%>' 회원 정보 수정</h2>
                    <form id="memberForm" enctype="multipart/form-data">
                        <div class="row row-space">
                        	<input type="hidden" id="member_id" name="member_id" value="<%=member.getMember_id()%>">
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">ID</label>
                                    <input class="input--style-4" type="text" name="user_id" id="user_id" value="<%=member.getUser_id()%>">
                                  <div class="store_id"></div>
                                </div>
                            </div>
                            
                               <div class="col-6">
                                   <div class="input-group">
                                       <label class="label">이름</label>
                                       <input class="input--style-4" type="text" id="user_name" name="user_name" value="<%=member.getUser_name()%>">             
                                   </div>
                               </div>
                           </div>
                           
                            <div class="row row-space">
                               <div class="col-12">
                                   <div class="input-group">
                                       <label class="label">주소</label>
                                       <input class="input--style-4" type="text" id="user_location" name="user_location" value="<%=member.getUser_location()%>"/>
                                   </div>
                               </div>
                           </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                <div class="input-group">
                                    <label class="label">연락처</label>
                                    <input class="input--style-4" type="number" id="user_phone" name="user_phone" onkeypress='return checkNumber(event)' minlength="1" maxlength="16" value="<%=member.getUser_phone()%>">
                                </div>
                            </div>
                            
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label"> 성별 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <div class="p-t-10">
                                        <label class="radio-container m-r-45">남자<input type="radio" name="user_gender" value="male" <%if(member.getUser_gender().equals("male"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">여자<input type="radio" name="user_gender" value="female" <%if(member.getUser_gender().equals("female"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                         </div>
                         
                        <div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">Email</label>
                                    <input class="input--style-4" type="text" id="user_email_id" name="user_email_id" required="required" value="<%=member.getUser_email_id()%>"> 
                                </div>
                            </div>
                            
                            <div class="col-6">
                               <div class="form-group">
                                  <div class="p-t-10" style="height:30px;">  </div>
                                     <select class="form-control" id="user_email_server" name="user_email_server" style="height:47px;">
                                       <option value="naver.com">naver.com</option>
                                          <option value="gmail.com">gmail.com</option>
                                        <option value="hanmail.net">hanmail.net</option>
                                    </select>
                                 <div class="select-dropdown"></div>
                             </div>
                            </div>
                       </div>

                        <div class="row row-space">
                            <div class="col-8">
                              <div style="text-align: center" height="300px">
                                     <img alt="profile_image" id="profile_image" src="/resources/data/member/<%=member.getMember_id() %>.<%=member.getUser_image()%>" width="250px">
                                  </div>
                            </div>
                        </div>
                        <div class="row row-space">
                           <div class="col-8">
                                 <label class="label">'<%=member.getUser_name()%>' 사진</label>
                                <div class="input-group">
                           <div class="custom-file">
                                <input type="file" name="u_image" class="custom-file-input" id="member_image" onchange="readURL(this)">
                                <label class="custom-file-label" for="member_image">Choose file</label>
                           </div>
                                </div>
                            </div>
                        </div>
                        
                        
                      <div class="row row-space">
                           <div class="col-3">
                                    <label class="label">회원 레벨</label>
                            </div>
                     </div>

                      <div class="row row-space">
                         <div class="col-6">
                            <div class="p-t-15"/>
                           <div class="input-group">
                                <label class="radio-container m-r-45">점포<input type="radio" name="user_position" value="store" <%if(member.getUser_position().equals("store"))%><%= "checked=\"checked\""%>>
                                     <span class="checkmark"></span>
                                      </label>
                                        <label class="radio-container">고객<input type="radio" name="user_position" value="user" <%if(member.getUser_position().equals("user"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                              </div>
                            </div>
                         </div>
                        </form>
                  <div class="alert alert-danger" id="passwordsNoMatchRegister" role="alert" style="display:none;" >빈칸을 채워주세요!!</div>
                  
                <div id="loader" style="margin:auto"></div>
                <div class="p-t-15">
                   <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="edit();">수정하기</button>
                   &nbsp;&nbsp;&nbsp;&nbsp;   
                     <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="location.href='/admin/member/memberlist';">고객 목록가기</button>
               </div>
                 
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