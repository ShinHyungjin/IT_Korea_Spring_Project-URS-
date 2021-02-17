<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Reservation"%>
<%@page import="com.sbj.urs.model.domain.Receipt"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   Store store = (Store)request.getAttribute("store");
   List<Receipt> receiptList = (List)request.getAttribute("receiptList");
   List<Member> memberList = (List)request.getAttribute("memberList");
   List<Store> storeList = (List)request.getAttribute("storeList");
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
   <!-- Bootstrap core CSS -->
  <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="/resources/css/shop-homepage.css" rel="stylesheet">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/react@16/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

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

<script type="text/babel">
var sock; //이 html을 배포한 서버와 연결된 소켓 얻기!!

//재사용 가능성이 높은 html 태그를 리엑트의 컴포넌트로 등록
class TableContent extends React.Component{

    deleteItem(receipt_id,bootpay_id){
        return function(){//무조건 호출방지를 위한 익명함수 및 리턴...
            remove(receipt_id,bootpay_id);
        }
    }

    render(){
        var row=[];//tr을 누적할 배열    
        for(var i=0;i<this.props.dataList[0].length;i++){
            var receipt = this.props.dataList[0][i];//게시물 하나 꺼낸다
            var member = this.props.dataList[1][i];//게시물 하나 꺼낸다
            var store = this.props.dataList[2][i];//게시물 하나 꺼낸다

            row.push(
                <tr>
                    <td>{i}</td>
                    <td>{member.user_name}</td>
                    <td>{store.store_name}</td>
                    <td>{receipt.receipt_regdate}</td>
                    <td>{receipt.receipt_totalamount}</td>
                    <button class="btn btn-primary" mdbWavesEffect type="button" onClick={this.deleteItem(receipt.receipt_id,receipt.bootpay_id)}>승인</button>
                </tr>                
            );
        }

        return (
                <table class="table table-hover" id="table">
                   <thead>
                     <tr class="table-primary">
                       <th scope="col">결제 ID</th>
                             <th scope="col">예약 고객 이름</th>
                             <th scope="col">예약 점포</th>
                             <th scope="col">예약 날짜</th>
                             <th scope="col">결제 금액</th>
                             <th scope="col">결제 취소 처리</th>
                     </tr>
                   </thead>
                   <tbody class="receipt_table" id="receipt_table">
         
                   {row}
              
                      </tbody>
                      </table>
                   
        )
    };
}


//문서가 로드되면, 웹소켓 서버에 접속을 시도하자!
$(function(){
   getList();
   connect();
});

 
function connect(){
    //connect to server!!
    sock = new SockJS("http://localhost:8888/rest/ws/client");

    //웹소켓 객체가 생성되었으므로, 이 시점 부터는 각종 이벤트를 처리하자!!
    //서버와 연결을 성공했을때의 이벤트 
    sock.onopen=function(e){
      }
    
    sock.onclose=function(e){
    
    }

    //서버로부터 메시지가 도착했을때..
    sock.onmessage=function(e){
        var msg = e.data;
        
        console.log("msg is =", msg);

        var json = JSON.parse(msg);        
        console.log("웹소켓을 통해 서버로부터 받은 메시지: ", json.requestCode);


        if(json.requestCode=="create"){//누군가 서버에 글 쓰면..
            getList();
        }else if(json.requestCode=="read"){

        }else if(json.requestCode=="update"){//누군가 서버에 글 수정하면..
            getList();
        }else if(json.requestCode=="delete"){//누군가 서버에 글 삭제하면..
            getList();
        }

   
    }
    
}   
 
function remove(obj,obj2){
    $.ajax({
       url:"/rest/store/manage/payment/paymentdelete",
       type:"POST",
       data:{
          receipt_id:obj,
        bootpay_id:obj2
       },
       success:function(result){
          $("#receipt_table").empty();
          $("#receipt_table").removeClass("receipt_table");
          $("#receipt_table").addClass("receipt_table");
          $("#table").removeClass("table table-hover");
          $("#table").addClass("table table-hover");
          console.log(result);
          for(var i=0; i<result[0].length; i++) {
             var receipt = result[0][i];
             var member = result[1][i];
             var store = result[2][i];
             $("#receipt_table").append("<tr>");   
             $("#receipt_table").append("<th scope=\"row\">"+receipt.receipt_id+"</th>");
             $("#receipt_table").append("<td><a href=\"/store/manage/payment/paymentdetail?receipt_id="+receipt.receipt_id+"\">"+member.user_name+"</a></td>");
             $("#receipt_table").append("<td>"+store.store_name+"</td>");
             $("#receipt_table").append("<td>"+receipt.receipt_regdate+"</td>");
             $("#receipt_table").append("<td>"+receipt.receipt_totalamount+"</td>");
             $("#receipt_table").append("<td><button class=\"btn btn-primary\" mdbWavesEffect type=\"button\" onClick=\"remove("+receipt.receipt_id+");\">승인</button></td>");
             $("#receipt_table").append("</tr>");
              
          }
       }
    });
 }
 
 
//비동기로 데이터 가져오기 
function getList(){
    $.ajax({
        url:"/rest/receipt",
        type:"GET",
        success:function(responseData){
            //화면 갱신..react로...
            console.log(responseData[0][0]);
            console.log(responseData[1][0]);
            console.log(responseData[2][0].store_name);
            ReactDOM.render(<TableContent dataList={responseData}/>, document.getElementById("receipt-list"));
         
        }
    });
}

</script>

</head>
 
<body>
 <%@include file="./inc/top.jsp" %>
  <!-- Page Content -->
  <div class="container">
    <div class="row">
      <div class="col-lg-3">
        <h1 class="my-4"><%=store.getStore_name() %></h1>
        <div class="list-group">
        </div>
      </div>
       <div class="col-lg-9">

        <div style="text-align: center;"   id="board-title" ><h1>주문 요청</h1></div>

        <div class="row" id="receipt-list">

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

  <!-- Bootstrap core JavaScript -->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>