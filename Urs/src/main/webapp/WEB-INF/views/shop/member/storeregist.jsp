<%@page import="com.sbj.urs.model.domain.Store"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%! String[] address; %>
<%
	Member member = (Member)session.getAttribute("member");
	Store store = (Store)request.getAttribute("storeDetail");
	 
 	if(store != null){
	address = store.getStore_location().split(",");
 	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <%@ include file="../inc/storeheader.jsp" %>
   			<!-- jQuery와 Postcodify를 로딩한다 -->
			
				<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
   <style type="text/css">
   
   </style>
   <script type="text/javascript">
   
   
	$(document).ready(function(){
   $('#updat').click(function(){
	   if ($('#store_name').val() == "" ||  $('#store_location1').val() == ""  || $('#store_location2').val() == ""  || $('#store_location3').val() == ""  || $('#store_location4').val() == ""  || $('#store_phone').val() == "" || $('#category_id').val() == "" || $($(".custom-file-input")[1]).val() == "" || $($(".custom-file-input")[0]).val() == "" || $('#store_bank').val() == "" || $('#store_account').val() == "" || $('#openhour').val() == "" || $('#closehour').val() == ""){
		   $('#passwordsNoMatchRegister').hide();
		   
		   setTimeout(function(){ $('#passwordsNoMatchRegister').show(); }, 100);
       }else{
       	$('#passwordsNoMatchRegister').hide();
       	regist();
       }
   
   });
	})
   
   function regist() {
      $("#storeForm").attr({
         action:"/shop/member/applystore",
         method:"post"
      });      
      $("#storeForm").submit();
      	
   }
   
   
   function edit() {
	   
	   $("#loader").addClass("loader"); //class 동적 적용
	    var formData = new FormData($("form")[0]);
       
	    $.ajax({
	        url: "/shop/member/editstore",
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: "POST",
	        success: function (data) {
				//서버로 부터완료응답을 받으면 로딩바 효과를 중단
				var json = JSON.parse(data);
				if(json.result == 1){
				alert(json.msg);
				location.href="/"; //추후 로그인 페이지로 보낼예정
				}else{
				alert(json.msg);	
				}
				
				$("#loader").removeClass("loader");//class동적제거
	        }
	    });
	      	
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
  				<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
				<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
</head>
<body>
<%@ include file="../inc/top.jsp" %>
 
   <div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins">
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">점포 등록</h2>
                            <form id="storeForm" enctype="multipart/form-data">
                        <div class="row row-space">
                        	<input name="member_id" value="<%=member.getMember_id()%>" hidden>
                        	<%if(store!=null){ %>
                        	<input name="store_id" value="<%=store.getStore_id()%>" hidden>
                       		<%} %>
                            
                               <div class="col-12">
                                   <div class="input-group">
                                       <label class="label">이름</label>
                                       <input class="input--style-4" type="text" id="store_name" name="store_name" value="<%if(store != null){%><%=store.getStore_name()%><%}%>">             
                                   </div>
                               </div> 
                           </div>
                        
    					<div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
					                <!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
					                <label class="label">우편번호</label>
									<input type="text" name="store_location" id="store_location1" class="postcodify_postcode5 input--style-4" value="<%if(store != null){%><%=store.getStore_location().split(",")[0] %><%}%>" required="required"/>
									
                                </div>
                            </div>
                           <div class="col-6">
                                <div class="input-group">
                                	<label class="label">&nbsp;<div style="width: 200px;"></div></label>
									<button type="button"  id="postcodify_search_button" class="btn btn-dark" >주소 검색</button>
                                </div>
                            </div>
                        </div>
                         
            			<div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                   <label class="label">도로명주소</label>
					         	<input type="text" name="store_location" id="store_location2" class="postcodify_address input--style-4" value="<%if(store != null){%><%=store.getStore_location().split(",")[1] %><%}%>" required="required"/><br />
                                </div>
                            </div>
                        </div>
                        
                       <div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                   <label class="label">상세주소</label>
					         	<input type="text" name="store_location" id="store_location3" class="postcodify_details input--style-4" value="<%if(store != null){%><%=store.getStore_location().split(",")[2] %><%}%>" required/><br />
                                </div>
                            </div>
                        </div>
                        
                   	<div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                   <label class="label">참고항목</label>
					         	<input type="text" name="store_location" id="store_location4" class="postcodify_extra_info input--style-4" value="<%if(store != null){%><%=store.getStore_location().split(",")[3] %><%}%>" required="required"/><br />
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="row row-space">
                           <div class="col-6">
                                <div class="input-group">
                                    <label class="label">연락처</label>
                                    <input class="input--style-4" type="text" id="store_phone" name="store_phone" onkeypress='return checkNumber(event)' minlength="11" maxlength="11" value="<%if(store != null){%><%=store.getStore_phone()%><%}%>">
                                </div>
                            </div>
                                                 <div class="col-6">
                          <div class="form-group">
                            <label class="label">점포 카테고리 종류<div style="width: 150px;"></div></label>
                            <select class="form-control" id="category_id" name="Category.category_id">
                                 	 <option value="1" <%if(store!=null){ if(store.getCategory().getCategory_id()==1){ %> selected <%}} %> >한식</option>
                                     <option value="2" <%if(store!=null){ if(store.getCategory().getCategory_id()==2){ %> selected <%}} %>>중식</option>
                                     <option value="3" <%if(store!=null){ if(store.getCategory().getCategory_id()==3){ %> selected <%}} %>>일식</option>
                                     <option value="4" <%if(store!=null){ if(store.getCategory().getCategory_id()==4){ %> selected <%}} %>>남미식</option>
                                     <option value="5" <%if(store!=null){ if(store.getCategory().getCategory_id()==5){ %> selected <%}} %>>양식</option>
                                     <option value="6" <%if(store!=null){ if(store.getCategory().getCategory_id()==6){ %> selected <%}} %>>패스트푸드</option>
                            </select>
                          </div>
                      </div>
                  </div>
                        <div class="row row-space">
                           <div class="col-6">
                              <div style="text-align: center" >
                                     <img alt="store_repimg" id="store_repimg" src="<%if(store!=null){ %>/resources/data/store/<%=store.getMember_id()%>.<%=store.getStore_repimg()%> <%} %>"  width="250px">
                                  </div>
                            </div>
                            
                            <div class="col-6">
                              <div style="text-align: center" height="300px">
                                     <img alt="store_image" id="store_image" src="<%if(store!=null){ %>/resources/data/store/<%=store.getMember_id()%>M.<%=store.getStore_repimg()%> <%} %>"  width="250px">
                                  </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                           <div class="col-6">
                                 <label class="label">사업자등록증</label>
                                <div class="input-group">
                           <div class="custom-file">
                                <input type="file" name="s_images" class="custom-file-input" id="store_repimg" onchange="readURL(this,0)">
                                <label class="custom-file-label" for="store_repimg">Choose file</label>
                           </div>
                                </div>
                            </div>
                            
                            <div class="col-6">
                                 <label class="label">가게 대표 이미지</label>
                                <div class="input-group">
                           <div class="custom-file">
                                 <input type="file" name="m_images" class="custom-file-input" id="store_image" onchange="readURL(this,1)">
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
                                 <option value="국민" <%if(store!=null){ if(store.getStore_bank().equals("국민")){ %> selected <%}} %>>국민</option>
                                     <option value="농협" <%if(store!=null){ if(store.getStore_bank().equals("농협")){ %> selected <%}} %>>농협</option>
                                     <option value="신한" <%if(store!=null){ if(store.getStore_bank().equals("신한")){ %> selected <%}} %>>신한</option>
                                     <option value="우리" <%if(store!=null){ if(store.getStore_bank().equals("우리")){ %> selected <%}} %>>우리</option>
                                     <option value="하나" <%if(store!=null){ if(store.getStore_bank().equals("하나")){ %> selected <%}} %>>하나</option>
                            </select>
                          </div>
                       </div>
                       
                       <div class="col-9">
                                <div class="input-group">
                                    <label class="label">계좌번호</label>
                                    <input class="input--style-4" type="text" id="store_account" name="store_account" value="<%if(store!=null){%><%=store.getStore_account() %><%} %>">
                                </div>
                            </div>
                    </div>
                    
                    <div class="row row-space">
                    

                      
                       <div class="col-6">
                          <div class="form-group">
                        	           <label class="label">오픈 시간</label>        
                          <input type="time" id="openhour" name="store_openhour" min="09:00" max="24:00" value="<%if(store != null){%><%=store.getStore_openhour() %><%}%>">
                         
                          </div>
                      </div>
                      
                      
						<div class="col-6">
                          <div class="form-group">
                        	                   <label class="label">닫는 시간</label>
                          <input type="time" id="closehour" name="store_closehour" min="00:00" max="23:59" value="<%if(store != null){%><%=store.getStore_closehour()%><%}%>" required>
                         
                          </div>
                      </div>
                      
   
            
                            
                    </div>
                    
					<div class="row row-space">
                    
						<div class="col-12">
                          <div class="form-group">
                         			<%if(store!=null){ %>
                        	                   <label class="label">심사 : 심사중</label>
                          			<%} %>
                          </div>
                      </div>
                            
                    </div>
                    
                    
                        
                  <div class="alert alert-danger" id="passwordsNoMatchRegister" role="alert" style="display:none;" >빈칸을 채워주세요!!</div>
                  
                <div id="loader" style="margin:auto"></div>
                <div class="p-t-15">
                <%if(store != null){ %>
                 <button class="btn btn-primary" id="reg" mdbWavesEffect type="button" style="width:16rem" onclick="edit()">수정하기</button>
                <%}else { %>
                   <button class="btn btn-primary" id="updat" mdbWavesEffect type="button" style="width:16rem">등록하기</button>
                  <%} %>
                   &nbsp;&nbsp;&nbsp;&nbsp;   
                     <button class="btn btn-primary" mdbWavesEffect type="button" style="width:16rem" onClick="location.href='/';">목록가기</button>
               </div>
                 </form>
                </div>
            </div>
        </div>
    </div>
 
<%@ include file="../inc/footer.jsp" %>
</body>
</html>