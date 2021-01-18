<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../inc/header.jsp" %>
</head>
<body style="background: #000000">
    	<%@include file="../inc/top.jsp" %>
        <!-- ****** Top Discount Area End ****** -->
        <div style="height: 10rem"></div>
		<div class="container" >
			<h1 style="color: white">이용에 불편을 드려 죄송합니다.</h1>
			<%=request.getAttribute("msg")%>		
		</div>			
        <!-- ****** Footer Area Start ****** -->
        <%@ include file="../inc/footer.jsp" %>
        <!-- ****** Footer Area End ****** -->
</body>
</html>