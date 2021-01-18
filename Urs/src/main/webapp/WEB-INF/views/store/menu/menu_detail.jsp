<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
   Menu menu = (Menu)request.getAttribute("menu");
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
	   $("#loader").addClass("loader"); //class 동적 적용
	    var formData = new FormData($("form")[0]);
      
	    $.ajax({
	        url: "/store/menu/edit",
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: "POST",
	        success: function (data) {
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
   
   function readURL(input) {
       if (input.files && input.files[0]) {
           var reader = new FileReader();
              
           reader.onload = function (e) {
                  $('#menu_image')
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
                    <h2 class="title">메뉴 정보 수정</h2>
                    <form id="menuForm">
                        <div class="row row-space">
                        
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">ID</label>
                                    <input class="input--style-4" type="text" name="menu_id" id="menu_id" value="<%=menu.getMenu_id()%>">
                                  <div class="store_id"></div>
                                </div>
                            </div>
                            
                               <div class="col-6">
                                   <div class="input-group">
                                       <label class="label">이름</label>
                                       <input class="input--style-4" type="text" id="menu_name" name="menu_name" value="<%=menu.getMenu_name()%>">             
                                   </div>
                               </div>
                           </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                <div class="input-group">
                                    <label class="label">가격</label>
                                    <input class="input--style-4" type="number" id="menu_price" name="menu_price" onkeypress='return checkNumber(event)' minlength="1" maxlength="8" value="<%=menu.getMenu_price()%>">
                                </div>
                            </div>
                             
                             <div class="col-6">
                                <div class="input-group">
                                    <label class="label">재고 상태 &nbsp;&nbsp;&nbsp;</label>
                                    <div class="p-t-10">
                                        <label class="radio-container m-r-45">가능<input type="radio" name="menu_stock" value="TRUE" <%if(menu.getMenu_stock().equals("TRUE"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">불가능<input type="radio" name="menu_stock" value="FALSE" <%if(menu.getMenu_stock().equals("FALSE"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label> 
                                    </div>
                                </div>
                            </div>
                            
                     </div>
                        <div class="row row-space">
                            <div class="col-8">
                              <div style="text-align: center" height="300px">
                                     <img alt="menu_image" id="menu_image" src="/resources/data/menu/<%=menu.getMenu_id() %>.<%=menu.getMenu_image()%>"  width="250px">
                                  </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                           <div class="col-8">
                                 <label class="label">'<%=menu.getMenu_name()%>' 사진</label>
                                <div class="input-group">
                           <div class="custom-file">
                                <input type="file" name="M_image" class="custom-file-input" id="menu_image" onchange="readURL(this,0)">
                                <label class="custom-file-label" for="menu_image">Choose file</label>
                           </div>
                                </div>
                            </div>
                        </div>
                    
                  <div class="alert alert-danger" id="passwordsNoMatchRegister" role="alert" style="display:none;" >빈칸을 채워주세요!!</div>
                  
                <div id="loader" style="margin:auto"></div>
                <div class="p-t-15">
                   <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="edit();">수정하기</button>
                   &nbsp;&nbsp;&nbsp;&nbsp;   
                     <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="location.href='/admin/store/menulist?store_id=<%=menu.getStore_id()%>'">메뉴 리스트 목록</button>
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