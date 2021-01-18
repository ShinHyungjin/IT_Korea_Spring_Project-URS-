<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Appetizer - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
 

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<%@ include file="../inc/header.jsp" %>
	
 
	
	
	    <!-- Icons font CSS-->
    <link href="/resources/regist/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/resources/regist/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">

    <!-- Vendor CSS-->
    <link href="/resources/regist/vendor/select2/select2.min.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="/resources/regist/css/main.css" rel="stylesheet" media="all">
                            
				<!-- jQuery와 Postcodify를 로딩한다 -->
			
				<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
				
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
	</style>
				<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
				<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
	
	<script type="text/javascript">
	
  
    
	$(document).ready(function(){
		$("#reg").attr("disabled","true");	
		  $('#customFile').on('change',function(){
		        //get the file name
		        var fileName = $('#customFile').val();
		        //replace the "Choose a file" label
		        $('#customFile').next('.custom-file-label').html($('#customFile').val().replace(/^.*\\/, ""));
		    })
		
		
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear();
		 if(dd<10){
		        dd='0'+dd
		    } 
		    if(mm<10){
		        mm='0'+mm
		    } 

		today = yyyy+'-'+mm+'-'+dd;
		document.getElementById("user_birthday").setAttribute("max", today);
		document.getElementById("user_birthday").setAttribute("value", today);
		
		$('input[name=user_id]').on('keyup', function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) { 
				var inputVal=$(this).val(); 
				$(this).val(inputVal.replace(/[^a-z0-9@_.-]/gi,'')); 
				} 
			});
		
		$('input[name=user_email_id]').on('keyup', function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) { 
				var inputVal=$(this).val(); 
				$(this).val(inputVal.replace(/[^a-z0-9@_.-]/gi,'')); 
				} 
			});
		
		
		$('input[name=user_name]').on('keyup', function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) { 
				var inputVal=$(this).val(); 
				$(this).val(inputVal.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g,'')); 
				} 
			});
		
		
 
		
		   $('#reg').click(function(){
			   
		        if ($('#user_id').val() == "" ||  $('#user_password').val() == ""  || $('#user_name').val() == ""  || $('#user_phone').val() == ""  || $('#user_birthday').val() == ""  || $('#user_email_id').val() == "" || $('#user_email_server').val() == "" || $('#user_location1').val() == "" || $('#user_location2').val() == "" || $('#user_location3').val() == "" || $('#user_location4').val() == "" ){
		        	  $('#passwordsNoMatchRegister').hide();
		   		   
		   		   setTimeout(function(){ $('#passwordsNoMatchRegister').show(); }, 100);
		        }else{
		        	$('#passwordsNoMatchRegister').hide();
		        	regist();
		        }
		        
		    });
		});
	
	
	//로그인 버튼 클릭시
	function regist(){
		$("#reg").attr("disabled","true");	
		$("#loader").addClass("loader"); //class 동적 적용
	    var formData = new FormData($("form")[0]);
        
	    $.ajax({
	        url: "/shop/member/regist",
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: "POST",
	        success: function (data) {
	        	$("#loader").removeClass("loader"); //class 동적 제거
				var json = JSON.parse(data);
				if(json.result == 1){
				alert(json.msg);
				location.href="/"; //추후 로그인 페이지로 보낼예정
				}else{
				alert(json.msg);	
				}
	        }
	    });

 
	 
	}
	
	
	function check_id(){
		var idCheck = 0 ;
		
		var inputed = $("#user_id").val();
	
		$.ajax({
			url:"/shop/member/checkId",
			method:"post",
			data:{
				user_id : inputed
			},
			 success: function (data) {
		         if(data == 0){
		        	 $("#user_id").css("background-color", "#FFCECE");
		        	 $(".user_id").css("margin-bottom", "16px");
		        	 $(".user_id").css("color", "rgb(255,120,203)");
		        	 $(".user_id").css("text-align", "center");
		        	 $(".user_id").text("이미 사용중인 아이디입니다");
					 $("#reg").attr("disabled","true");		        	 
		         }else if(data == 1){
		        	 $("#user_id").css("background-color", "#B0F6AC");
		        	 $(".user_id").css("margin-bottom", "16px");
		        	 $(".user_id").css("color", "#34aadc");
		        	 $(".user_id").css("text-align", "center");
		        	 $(".user_id").text("사용가능한 아이디입니다.");
					 $("#reg").removeAttr("disabled");
		         }else if(data == 2){
		        	 $("#user_id").css("background-color", "#FFCECE");
		        	 $(".user_id").css("margin-bottom", "16px");
		        	 $(".user_id").css("color", "rgb(255,120,203)");
		        	 $(".user_id").css("text-align", "center");
		        	 $(".user_id").text("아이디 형식이 올바르지 않습니다.");
					 $("#reg").attr("disabled","true");	
		         }
		     }
		})
		
		
	}
	
	function checkNumber(event) {
		  if(event.key === '.' 
		     || event.key === '-'
		     || event.key >= 0 && event.key <= 9) {
		    return true;
		  }
		  
		  return false;
		}
	
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                    .attr('src', e.target.result)
                    .width(150)
                    .height(150);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
 
	</script>
 
 
  </head>
   
  
  <body>
 	<%@ include file="../inc/top.jsp" %>


 
 
   <div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins">
        <div class="wrapper wrapper--w680">
            <div class="card card-4">
                <div class="card-body">
                    <h2 class="title">계정 생성</h2>
                    <form id="member_form">
                         <div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">아이디</label>
                                    <input class="input--style-4" type="text" name="user_id" id="user_id" >
                                    <div class="user_id"></div>
                                                    
                             
                                		<label class="label">&nbsp;<div style="width: 200px;"></div></label>
										<button type="button" class="btn btn-info" onclick="check_id()">중복체크</button>
                           
                        
                                </div>
                            </div>
                            <div class="col-6">
                            <div style="text-align: center" >
                               <img alt="profile_image" id="blah" src="/resources/data/member/deafultProfile.jpg"  width="150px">
                               </div>
                            </div>
                        </div>	
                        
                     <div class="row row-space">
                            <div class="col-7">
                                <div class="input-group">
                                    <label class="label">비밀번호</label>
                                    <input class="input--style-4" type="password" id="user_password" name="user_password" required="required">
                                </div>
                            </div>
                           
                           <div class="col-5">
                           			   <label class="label">프로필 사진 설정 </label>
                                <div class="input-group">
							
									<div class="custom-file">
									  <input type="file" name="u_image" class="custom-file-input" id="customFile" onchange="readURL(this)">
									  <label class="custom-file-label" for="customFile">Choose file</label>
									</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">이름:</label>
                                    <input class="input--style-4" type="text" id="user_name" maxlength="3" name="user_name" required="required">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">전화번호</label>
                                    <input class="input--style-4" type="text" id="user_phone" name="user_phone" onkeypress='return checkNumber(event)' minlength="11" maxlength="11" required="required">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">생년월일</label>

                                        <input class="input--style-4" type="date" id="user_birthday" min="1900-01-01"  name="user_birthday" required="required">
                        
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <label class="label">성별<div style="width: 100px;"></div></label>
                                    <div class="p-t-10">
                                        <label class="radio-container m-r-45">남자<input type="radio" checked="checked" name="user_gender" value="male">
                                            <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">여자<input type="radio" name="user_gender" value="female">
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
                                    <input class="input--style-4" type="text" id="user_email_id" name="user_email_id"  maxlength="20" required="required"> 
                                </div>
                            </div>
                            
                            <div class="col-6">
                                <div class="input-group">
                                     <label class="label">이메일 서버<div style="width: 150px;"></div></label>
		                            <div class="rs-select2 js-select-simple select--no-search">
		                                <select name="user_email_server" id="user_email_server" required>
		                                    <option value="naver.com">naver.com</option>
		                                    <option value="gmail.com">gmail.com</option>
		                                    <option value="hanmail.net">hanmail.net</option>
		                                </select>
		                                <div class="select-dropdown"></div>
		                            </div>
                                </div>
                            </div>
                        </div>
                        
              		<div class="row row-space">
                            <div class="col-6">
                                <div class="input-group">
					                <!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 class를 부여한다 -->
					                <label class="label">우편번호</label>
									<input type="text" name="user_location" id="user_location1" class="postcodify_postcode5 input--style-4" value="" required="required"/>
									
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
					         	<input type="text" name="user_location" id="user_location2" class="postcodify_address input--style-4" value="" required="required"/><br />
                                </div>
                            </div>
                        </div>
                        
                       <div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                   <label class="label">상세주소</label>
					         	<input type="text" name="user_location" id="user_location3" class="postcodify_details input--style-4" value="" required/><br />
                                </div>
                            </div>
                        </div>
                        
                   	<div class="row row-space">
                            <div class="col-12">
                                <div class="input-group">
                                   <label class="label">참고항목</label>
					         	<input type="text" name="user_location" id="user_location4" class="postcodify_extra_info input--style-4" value="" required="required"/><br />
                                </div>
                            </div>
                        </div>

                        
					<div class="alert alert-danger" id="passwordsNoMatchRegister" role="alert" style="display:none;" >빈칸을 채워주세요!!</div>
						
						<div id="loader" style="margin:auto"></div>
                        <div class="p-t-15">
                            <button class="btn btn--radius-2 btn--blue" id="reg" type="button">계정생성</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
 


    
	<%@ include file="../inc/footer.jsp" %>
    
 

 
  </body>
</html>