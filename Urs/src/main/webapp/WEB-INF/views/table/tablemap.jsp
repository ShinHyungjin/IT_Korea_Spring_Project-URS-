<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="com.sbj.urs.model.domain.TableMap"%>
<%@page import="java.io.Console"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%   
   Member member = (Member)session.getAttribute("member");   
   String store_id = (String)request.getAttribute("store_id");    //메뉴 고른 가게 번호
   String resultArr = (String)request.getAttribute("resultArr");   //선택한 메뉴들   
   TableMap tableMap = (TableMap)request.getAttribute("tableMap"); //현재 테이블 배치 상태
   String indexStr = tableMap.getMap_index();  
   String isfirst = tableMap.getIs_first(); //
   String unavailStr = tableMap.getUnavailable();
   List<String> indexMap = new ArrayList<String>();   
   String[] pushStr = new String[7];
   String[] unavailList;  
   int start = 0;
   int end = 5;
   String position = member.getUser_position(); //세션으로 포지션 얻기
   //if(unavailStr==null){ System.out.println("널");}
   
   for(int i=0; i<7; i++){
      indexMap.add(indexStr.substring(start,end+1));
      pushStr[i] = indexStr.substring(start,end+1); //mapArr에 string 넣어주기 위해 별도로 저장
      start= end+1; //6 
      end=start+5; //11
      System.out.println(indexMap.get(i));
   }
   if(!unavailStr.equals("0_0")){
      unavailList = unavailStr.split(","); //select한 unavailable을 sc.get에 뿌리기 위해 split
   }else{
      unavailList = new String[1];
   }

   for(int i=0; i<unavailList.length; i++){
      System.out.println(unavailList[i]);
   }
%>
<!doctype html>
<html>
<head> 
<%@ include file="../shop/inc/header2.jsp" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery Seat Charts Plugin Demo</title>
<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resources/tablecss/jquery.seat-charts.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/react@16/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<style>
body {
   font-family: 'Roboto', sans-serif;
  background-color :#fafafa;
}
a {
   color: #b71a4c;
}
.front-indicator {
   width: 650px;
   margin: 5px 32px 15px 32px;
   background-color: #f6f6f6;   
   color: #adadad;
   text-align: center;
   padding: 3px;
   border-radius: 5px;
}
.wrapper {
   width: 100%;
   text-align: center;
  margin-top:150px;
}
.container {
   margin: 0 auto;
   width: 1000px;
   text-align: left;
}
.booking-details {
   float: left;
   text-align: left;
   margin-left: 35px;
   font-size: 12px;
   position: relative;
   height: 601px;
}
.booking-details h2 {
   margin: 25px 0 20px 0;
   font-size: 17px;
}
.booking-details h3 {
   margin: 5px 5px 0 0;
   font-size: 14px;
}
div.seatCharts-cell {
   color: #182C4E;
   height: 80px;
   width: 90px;
   line-height: 25px;
   
}
div.seatCharts-seat {
   color: #FFFFFF;
   cursor: pointer;   
}
div.seatCharts-row {
   height: 35px;
}
div.seatCharts-seat.available {
   background-color: #B9DEA0;
}
div.seatCharts-seat.empty {
   background-color: #f6f6f6;
}
div.seatCharts-seat.available.first-class {
/*    background: url(vip.png); */
   background-color: #3a78c3;
}
div.seatCharts-seat.to {
   background-color: #B9DEA0;
}
div.seatCharts-seat.four {
   background-color: #3a78c3;
}
div.seatCharts-seat.focused {
   background-color: #76B474;
}
div.seatCharts-seat.selected {
   background-color: #E6CAC4;
}
div.seatCharts-seat.unavailable {
   background-color: #472B34;
}
div.seatCharts-container {
   border-right: 1px dotted #adadad;
   width: 730px;
   padding: 20px;
   float: left;
}
div.seatCharts-legend {
   padding-left: 0px;   
   position: absolute;
   bottom: 16px;
}
li.seatCharts-legendItem{
   padding-bottom: 45px;
}
ul.seatCharts-legendList {
   padding-left: 0px;
}
span.seatCharts-legendDescription {
   margin-left: 5px;
   padding-bottom: 40px;
   line-height: 30px;
}
.checkout-button {
   display: block;
   margin: 10px 0;
   font-size: 14px;
}
.SaveTable{   
   display: block;
   margin: 10px 0;
   font-size: 14px;
}
#selected-seats {
   max-height: 90px;
   overflow-y: scroll;
   overflow-x: none;
   width: 170px;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
<script src="/resources/tablejs/jquery.seat-charts.js"></script>
<script>   
$(document).ready(function(){
   connect();
   var getFirstData = true;
   var mapArr = new Array(); //관리자가 테이블 배치 후 담을 Array
   var unavailArr = new Array(); //예약된 좌석 unavailArray
   var reservationTableInx = new Array(); //유저가 선택한 좌석(receipt 테이블에 넣고 나중에 예약취소시 삭제 위함)
   var firstSeatLabel = 1;         
   var settingsId=""; 
   //var position = 'customer';//회원인지 관리자인지
   var position = '<%=position%>'; 
   var countSum =0;
   
   //특정 문자열 index 찾아 요소 치환해주는 메서드 정의
   String.prototype.replaceAt=function(index, character) {
       return this.substr(0, index) + character + this.substr(index+character.length);
   }
   
   function castMap(getId,fe){ //가게주인이 테이블 배치할때, 변경된 테이블값을 변경해주는 함수(fe는 f냐 e냐 결정)                                 
      var indexID= getId;
      var idArr= indexID.split("_");
      var str =mapArr[idArr[0]-1];      
      str = str.replaceAt(idArr[1]-1, fe);                              
      mapArr[idArr[0]-1] = str;
      mapArr.splice(idArr[0]-1,1,str);
      console.log(mapArr[idArr[0]-1]);
   }
   //클릭시
    $("#mapSet").click(function() {
       console.log(unavailArr);
        //배열 선언        
        var objParams = {                
                "arrmap" : mapArr, // 테이블 배치 map 저장
                "unavailmap" : unavailArr
            };
        //ajax 호출
        $.ajax({
            url         :   "/admin/table/batch",
            dataType    :   "json",
            contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
            type        :   "post",
            data        :   objParams,
            success     :   function(retVal){
                if(retVal.code == "OK") {
                   getFirstData=false;
                    mapArr=retVal.arrMap;
                    alert("테이블 배치가 완료되었습니다.");
                    location.href="/";
                    //console.log(retVal.indexMap);
                } else {
                    alert("실패");
                }
            }
            /*error       :   function(request, status, error){
                console.log("AJAX_ERROR");
            }*/
        });
        
    })    
   
    //클릭시
    $(".checkout-button").click(function(){
       if(reservationTableInx.length==0){
            alert("테이블을 선택해주세요");
            return false;
         }
       var str = "";
       var str2= "";
       
       for(var i=0; i<unavailArr.length; i++){
          str += unavailArr[i]
          if(i!=unavailArr.length-1) {str += ","; }
       }
       for(var i=0; i<reservationTableInx.length; i++){
          str2 += reservationTableInx[i]
          if(i!=reservationTableInx.length-1) {str2 += ","; }
       }
       
       $("input[name='unavailable']").val(str); //예약된 총좌석
       $("input[name='reservationTableInx']").val(str2);//손님이 선택한 좌석만
       $("input[name='resultArr']").val("<%=resultArr%>");
       $("input[name='store_id']").val("<%=store_id%>");
       $("#checkout").attr({
         action:"/customer/table/regist",
         method:"post"         
      });
      $("#checkout").submit();       
    });
   
         //var mapArr = new Array(); //관리자가 테이블 배치 후 담을 Array         
         <%if(isfirst.equals("true")){%> //테이블 배치를 한번도 안한 상태면
            mapArr.push("______","______","______","______","______","______","______");//Default(빈 좌석) 배치
         <%}else{%> //테이블 배치를 한번이라도 했으면 select한 테이블map 으로 mapArr 채움
               mapArr.push("<%=pushStr[0]%>","<%=pushStr[1]%>","<%=pushStr[2]%>","<%=pushStr[3]%>","<%=pushStr[4]%>","<%=pushStr[5]%>","<%=pushStr[6]%>");
               unavailArr.push(
               <%for(int i=0; i<unavailList.length; i++){%>
               "<%=unavailList[i]%>"
               <%if(i!=unavailList.length-1){%>,<%}%>
               <%}%>
               );
         <%}%>
         
         
         //console.log(mapArr);         
         function cancleCell(turnType){
            $counter.text(sc.find('four').length-1);                                 
            $('#cart-item-'+this.settings.id).remove();         
            return 'available';
         }            
               
         $(document).ready(function() {   
            onLoadTable();
         });
            
            function onLoadTable(){
            var $cart = $('#selected-seats'),
             $counter = $('#counter'),
             sc = $('#seat-map').seatCharts({
             map: [
                /*'ffffff',
                'mmmmmm',
                'mmmmmm',
                'mmmmmm',
                'mmmmmm',
                'mmmmmm',
                'mmmmmm',   
                'mmmmmm',*/      
               <%for(int i=0; i<indexMap.size(); i++){%>
                  "<%=indexMap.get(i)%>",
                <%}%> 

             ],
             seats: {
                f: {
                   classes : 'first-class', //your custom CSS class
                   category: '4인석'
                },
                e: {
                   classes : 'economy-class', //your custom CSS class
                   category: '2인석'
                },
                m: {
                   classes : 'empty', //your custom CSS class
                   category: '배치'
                },               
             
             },
             naming : {
                top : false,
                getLabel : function (character, row, column) {
                   return firstSeatLabel++;
                },
             },
             legend : {
                node : $('#legend'),                  
                items : [
                   [ 'm', 'empty',   '배치' ],
                   [ 'f', 'available',   '4인석' ],
                   [ 'e', 'available',   '2인석'],
                   [ 'f', 'unavailable', '예약된 좌석']
                 ]               
             },
             click: function () {
                var un_flag=true; //현재 unavailable인 상태
                var select_val = document.getElementById("select_box").value;                     
                if (this.status() == 'available') {//************************Can click***************
                   //let's create a new <li> which we'll add to the cart items
                   if(position=='user'){   // 유저가 고객일때            
                      $('<li>'+this.data().category+' Seat # '+this.settings.label+': <b>'+'</b> <a href="#" class="cancel-cart-item">[cancel]</a></li>')
                         .attr('id', 'cart-item-'+this.settings.id)
                         .data('seatId', this.settings.id)
                         .appendTo($cart);                           
                         $counter.text(sc.find('selected').length+1);
                         settingsId = this.settings.id;
                         unavailArr.push(this.settings.id);//고객이 선택한 좌석 update 위해서 저장
                         reservationTableInx.push(this.settings.id);//고객 선택 좌석 receipt에 따로 넣어주기 위함
                         
                         console.log("선택:"+unavailArr);
                                                    
                         return 'selected';
                      }else if(position=='store'){ //유저가 관리자일때
                         if(select_val=='4인석') {
                            sc.find('four').length+1; // length를 늘리기 위함(count와는 별개)
                            countSum += 1;
                            $counter.text(countSum);
                            if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"f"); }
                            return 'four'; //4인석 반환
                         }
                         else if(select_val=='2인석') {
                            sc.find('to').length+1; // length를 늘리기 위함(count와는 별개)
                            countSum += 1;
                            $counter.text(countSum);
                            if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"e"); }
                            return 'to'; //2인석 반환
                         }
                         else if(select_val=='예약된좌석') {
                            //$counter.text(sc.find('unavailable').length+1);
                            unavailArr.push(this.settings.id);//예약된 좌석 update 위해서 저장
                            if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"f"); }
                            console.log(unavailArr);
                            return 'unavailable'; //2인석 반환
                         }
                      }                     

                } else if(this.status()=='selected' || this.status()=='to' || this.status()=='four') {//************************Cancle click***************
                   if(position=='user'){//유저가 고객일때
                      //update the counter
                      $counter.text(sc.find('selected').length-1);                     
                      //remove the item from our cart
                      settingsId = this.settings.id;
                      $('#cart-item-'+this.settings.id).remove();      
                      
                      let pos = unavailArr.indexOf(""+this.settings.id+""); //삭제할 index                        
                      let pos2 = reservationTableInx.indexOf(""+this.settings.id+""); //삭제할 index                        
                      unavailArr.splice(pos,1);//unavailArray 요소 삭제(고객이 선택한 좌석 취소시 요소 삭제)
                      reservationTableInx.splice(pos,1);
                      console.log("해제:"+unavailArr);
                      return 'available';

                   }else if(position=='store'){
                      if(select_val=='4인석') {                                 
                         sc.find('four').length-1;
                         countSum -= 1;
                         $counter.text(countSum);
                         if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"_"); }//예약된 좌석에 포함되 있으면 mapArr안바꿈,그대로 진행
                         $('#cart-item-'+this.settings.id).remove();
                         let pos = unavailArr.indexOf(""+this.settings.id+""); //삭제할 index
                         unavailArr.splice(pos,1);//unavailArray 요소 삭제(고객이 선택한 좌석 취소시 요소 삭제)
                         console.log(unavailArr);
                         return 'available';
                      }
                      else if(select_val=='2인석') {
                         sc.find('to').length-1;
                         countSum -= 1;
                         $counter.text(countSum);
                         if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"_");}
                         $('#cart-item-'+this.settings.id).remove();
                         let pos = unavailArr.indexOf(""+this.settings.id+""); //삭제할 index
                         unavailArr.splice(pos,1);//unavailArray 요소 삭제(고객이 선택한 좌석 취소시 요소 삭제)
                         console.log(unavailArr);
                         return 'available';
                      }            
                   }
                } else if (this.status() == 'unavailable') {
                   //seat has been already booked
                   if(un_flag==true && position=='store') { //unavailable 상태고 관리자면
                      un_flag=!un_flag;                     
                      let pos = unavailArr.indexOf(""+this.settings.id+""); //삭제할 index
                      if(!unavailArr.includes(""+this.settings.id+"")){ castMap(this.settings.id,"_"); }
                      unavailArr.splice(pos,1);//unavailArray 요소 삭제
                      
                      console.log(unavailArr);
                      return 'available';
                   } 
                   else {return 'unavailable';}
                } else {
                   return this.style();
                }
                
             }
            });
         
 

            //this will handle "[cancel]" link clicks
            $('#selected-seats').on('click', '.cancel-cart-item', function () {
               //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
               var ss = sc.get($(this).parents('li:first').data('seatId')).click();               
            });

            //let's pretend some seats have already been booked
            <%if(!unavailStr.equals("0_0")){ %>
            sc.get([<%for(int i=0; i<unavailList.length; i++){%>
            "<%=unavailList[i]%>"<%if(i!=unavailList.length-1){%>,<%}%><%}%>]).status('unavailable');            
            <%}%>
                        
            
            }
         
   
      //fn.node().on('click', function(){})
            

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
    
  /*function sendMap(mapArr){
        var form = {
              mapArr : JSON.stringify(mapArr)
        }
        $.ajax({
            type: "post", 
            url: "/admin/table", 
            dataType: "json", 
            contentType : "application/x-www-form-urlencoded; charset=UTF-8",
            data: form
        });
      if(confirm("테이블 배치 상태를 저장하시겠습니까?")){
         $("#SaveTable").attr({
            action:"/admin/table?mapArr="+mapArr,
            method:"get",            
         });
         $("#SaveTable").submit();
      }   
     }*/
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
           window.location.reload();
        }else if(json.requestCode=="read"){
            
        }else if(json.requestCode=="update"){//누군가 서버에 글 수정하면..
            getList();
        }else if(json.requestCode=="delete"){//누군가 서버에 글 삭제하면..
           window.location.reload();
        }

   
    }
    
}   

</script>
</head>
<body>
<%@ include file="../shop/inc/top.jsp" %>
<div class="wrapper">
  <div class="container">
  <h1 style="text-align: center;" id="board-title">좌석 배치도</h1>
    <div id="seat-map">
      <div class="front-indicator">Front</div>
    </div>
    <div class="booking-details">
      <h2>Booking Details</h2>
      <h3> Selected Seats (<span id="counter">0</span>):</h3>
      <ul id="selected-seats">
      </ul>   
            <%if(position.equals("user")){ %>
            <form id="checkout">                           
            <input type="hidden" name="unavailable">
            <input type="hidden" name="resultArr">
            <input type="hidden" name="store_id">
            <input type="hidden" name="reservationTableInx">
                                 
            <button class="checkout-button">Checkout &raquo;</button>
         </form>
         <%} %>
         
         <div id="legend">
                     
            <div <%if(position.equals("user")){ %> style="display : none"<%} %>>배치할 테이블 선택</div>
            <select name="" id="select_box" <%if(position.equals("user")){ %> style="display : none"<%} %>>
               <option value="4인석">4인석</option>
               <option value="2인석">2인석</option>
               <option value="예약된좌석">예약된 좌석</option>
            </select>   
         </div>
         
         <%if(position.equals("store")){ %>
         <form id="SaveTable" >
            <input id="mapSet" name="mapSet" type="button" value="테이블 저장">            
         </form>
         <%} %>   
    </div>
  </div>
</div>

</body>
</html>