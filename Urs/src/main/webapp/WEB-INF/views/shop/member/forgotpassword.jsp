<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>URS-로그인</title>
<%@ include file="../inc/header.jsp" %>
<style type="text/css">


body {
  background: #000000;
}
form {
  width: 60%;
  margin: 60px auto;
  background: #000000;
  padding: 60px 120px 80px 120px;
  text-align: center;
  -webkit-box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
  box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
}
label {
  display: block;
  position: relative;
  margin: 40px 0px;
}
.label-txt {
  position: absolute;
  top: -1.6em;
  padding: 10px;
  font-family: sans-serif;
  font-size: .8em;
  letter-spacing: 1px;
  color: rgb(120,120,120);
  transition: ease .3s;
}
.input {
  width: 100%;
  padding: 10px;
  background: transparent;
  border: none;
  outline: none;
}

.line-box {
  position: relative;
  width: 100%;
  height: 2px;
  background: #BCBCBC;
}

.line {
  position: absolute;
  width: 0%;
  height: 2px;
  top: 0px;
  left: 50%;
  transform: translateX(-50%);
  background: #8BC34A;
  transition: ease .6s;
}

.input:focus + .line-box .line {
  width: 100%;
}

.label-active {
  top: -3em;
}

button {
  display: inline-block;
  padding: 12px 24px;
  background: white;
  font-weight: bold;
  color: rgb(120,120,120);
  border: none;
  outline: none;
  border-radius: 3px;
  cursor: pointer;
  transition: ease .3s;
}

button:hover {
  background: #8BC34A;
  color: #ffffff;
}

h1{
	color:white;
}

</style>
<script type="text/javascript">
$(document).ready(function(){

	  $('.input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });
	  

	});
	
	function sendEmail(){
		$("#forgotpassword_form").attr({
			action:"/shop/member/sendpassword",
			method:"post"
		})
		
		$("#forgotpassword_form").submit();
		 $("#reg").attr("disabled","true");	
	}
	
 

</script>

</head>
<body>
<%@ include file="../inc/top.jsp" %>

 
<form id="forgotpassword_form">
	<h1>비밀번호 찾기</h1>
  <label>
    <p class="label-txt">ENTER USER_ID</p>
    <input type="text" class="input" style="color: white" name="user_id">
    <div class="line-box">
      <div class="line"></div> 
    </div>
  </label>
  <div style="height: 5rem">
  <div style="color: white; float:left; "><a href="/shop/member/registForm">회원가입</a></a></div>
  </div> 
  <button type="button" id="reg" onclick="sendEmail()">확인</button>
</form>
 


<%@ include file="../inc/footer.jsp" %>
</body>
</html>