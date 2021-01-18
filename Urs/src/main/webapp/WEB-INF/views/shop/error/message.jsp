<%@page import="com.sbj.urs.model.domain.MessageData"%>
<%@ page contentType="text/html;charset=utf-8"%>
<% 
	MessageData messageData  = (MessageData)request.getAttribute("messageData");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<script type="text/javascript">
 
alert("<%=messageData.getMsg()%>");
<%if(messageData.getUrl() != null){%>
location.href="<%=messageData.getUrl()%>";
<%}else{%>
	history.back();
<%}%>
</script>
</head>

<body>
	


</body>

</html>