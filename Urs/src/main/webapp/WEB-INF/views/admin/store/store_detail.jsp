<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
   List<Category> categoryList = (List)request.getAttribute("categoryList");
   Store store = (Store)request.getAttribute("store");
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
      $("#storeForm").attr({
         action:"/admin/store/storeupdate",
         method:"post"
      });      
      $("#storeForm").submit();
   }
   
   function readURL(input,test) {
       if (input.files && input.files[0]) {
           var reader = new FileReader();
              
           reader.onload = function (e) {
              if(test==0) {
                     $('#store_repimg')
                         .attr('src', e.target.result)
                         .width(250)
                         .height(125);
              } else if(test==1){
                    $('#store_image')
                       .attr('src', e.target.result)
                       .width(250)
                       .height(125);
              }
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
                    <h2 class="title">점포 정보 수정</h2>
                    <form id="storeForm">
                        <div class="row row-space">
                        
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">ID</label>
                                    <input class="input--style-4" type="text" name="store_id" id="store_id" value="<%=store.getStore_id()%>" readonly>
                                  <div class="store_id"></div>
                                </div>
                            </div>
                            
                               <div class="col-6">
                                   <div class="input-group">
                                       <label class="label">이름</label>
                                       <input class="input--style-4" type="text" id="store_name" name="store_name" value="<%=store.getStore_name()%>">             
                                   </div>
                               </div>
                           </div>
                        
                        <div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                    <label class="label">위치</label>
                                    <input class="input--style-4" type="text" id="store_location" name="store_location" value="<%=store.getStore_location()%>"/>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                <div class="input-group">
                                    <label class="label">연락처</label>
                                    <input class="input--style-4" type="text" id="store_phone" name="store_phone" onkeypress='return checkNumber(event)' minlength="11" maxlength="11" value="<%=store.getStore_phone()%>">
                                </div>
                            </div>
                            
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">예약 상태 &nbsp;&nbsp;&nbsp;</label>
                                    <div class="p-t-10">
                                        <label class="radio-container m-r-45">가능<input type="radio" name="store_reservation" value="TRUE" <%if(store.getStore_reservation().equals("TRUE"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">불가능<input type="radio" name="store_reservation" value="FALSE" <%if(store.getStore_reservation().equals("FALSE"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            
                  </div>
                        <div class="row row-space">
                           <div class="col-6">
                              <div style="text-align: center" >
                                     <img alt="store_repimg" id="store_repimg" src="/resources/data/store/<%=store.getMember_id()%>.<%=store.getStore_repimg()%>"  width="250px">
                                  </div>
                            </div>
                            
                            <div class="col-6">
                              <div style="text-align: center" height="300px">
                                     <img alt="store_image" id="store_image" src="/resources/data/store/<%=store.getMember_id()%>M.<%=store.getStore_image()%>"  width="250px">
                                  </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                 <label class="label">'<%=store.getStore_name()%>'의 사업자등록증</label>
                                <div class="input-group">
                           <div class="custom-file">
                                <input type="file" name="store_repimg" class="custom-file-input" id="store_repimg" onchange="readURL(this,0)">
                                <label class="custom-file-label" for="store_repimg">Choose file</label>
                           </div>
                                </div>
                            </div>
                            
                            <div class="col-6">
                                 <label class="label">가게 대표 이미지</label>
                                <div class="input-group">
                           <div class="custom-file">
                                 <input type="file" name="store_image" class="custom-file-input" id="store_image" onchange="readURL(this,1)">
                                <label class="custom-file-label" for="store_image">Choose file</label>
                           </div>
                           
                                </div>
                            </div>
                            
                        </div>
                        
                        
                        <div class="row row-space">
                     <div class="col-3">
                          <div class="form-group">
                            <label class="label">은행<div style="width: 150px;"></div></label>
                            <select class="form-control" id="store_bank" name="store_bank">
                                 <option value="국민" <%if(store.getStore_bank().equals("국민"))%><%= "selected=\"selected\""%>>국민</option>
                                     <option value="농협" <%if(store.getStore_bank().equals("농협"))%><%= "selected=\"selected\""%>>농협</option>
                                     <option value="신한" <%if(store.getStore_bank().equals("신한"))%><%= "selected=\"selected\""%>>신한</option>
                                     <option value="우리" <%if(store.getStore_bank().equals("우리"))%><%= "selected=\"selected\""%>>우리</option>
                                     <option value="하나" <%if(store.getStore_bank().equals("하나"))%><%= "selected=\"selected\""%>>하나</option>
                            </select>
                          </div>
                       </div>
                       
                       <div class="col-9">
                                <div class="input-group">
                                    <label class="label">계좌번호</label>
                                    <input class="input--style-4" type="text" id="store_account" name="store_account" value="<%=store.getStore_account()%>">
                                </div>
                            </div>
                    </div>
                    
                    <div class="row row-space">
                    
                     <div class="col-6">
                          <div class="form-group">
                            <label class="label">점포 카테고리 종류<div style="width: 150px;"></div></label>
                            <select class="form-control" id="category_id" name="Category.category_id">
                                 <option value="1"<%if(store.getCategory().getCategory_id() == 1)%><%= "selected=\"selected\""%>>한식</option>
                                     <option value="2"<%if(store.getCategory().getCategory_id() == 2)%><%= "selected=\"selected\""%>>중식</option>
                                     <option value="3"<%if(store.getCategory().getCategory_id() == 3)%><%= "selected=\"selected\""%>>일식</option>
                                     <option value="4"<%if(store.getCategory().getCategory_id() == 4)%><%= "selected=\"selected\""%>>남미식</option>
                                     <option value="5"<%if(store.getCategory().getCategory_id() == 5)%><%= "selected=\"selected\""%>>양식</option>
                                     <option value="6"<%if(store.getCategory().getCategory_id() == 6)%><%= "selected=\"selected\""%>>패스트푸드</option>
                            </select>
                          </div>
                      </div>
                          
                      <div class="col-6">
                             <div class="form-group">
                                <label class="label">승인<div style="width: 150px;"></div></label>
                                <div class="p-t-10">
                                   <label class="radio-container m-r-45">합격<input type="radio" name="store_pass" value="TRUE" <%if(store.getStore_pass().equals("TRUE"))%><%= "checked=\"checked\""%>>
                                    <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">불합격<input type="radio" name="store_pass" value="FALSE" <%if(store.getStore_pass().equals("FALSE"))%><%= "checked=\"checked\""%>>
                                            <span class="checkmark"></span>
                                        </label>
                                </div>
                             </div>
                         </div>
                            
                    </div>
                    
                    
                        
                  <div class="alert alert-danger" id="passwordsNoMatchRegister" role="alert" style="display:none;" >빈칸을 채워주세요!!</div>
                  
                <div id="loader" style="margin:auto"></div>
                <div class="p-t-15">
                   <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="edit();">수정하기</button>
                   &nbsp;&nbsp;&nbsp;&nbsp;   
                     <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="location.href='/admin';">목록가기</button>
               </div>
               <div class="p-t-15">
                     <button class="btn btn-primary" mdbWavesEffect type="button" style="width:535px" onClick="location.href='/admin/store/menulist?store_id=<%=store.getStore_id()%>'">'<%=store.getStore_name()%>'의 메뉴 관리</button>
               </div>
               <input type="hidden" id="member_id" name="member_id" value="<%=store.getMember_id()%>">
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