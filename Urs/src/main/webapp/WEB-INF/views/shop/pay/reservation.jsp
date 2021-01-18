<%@page import="java.util.Map"%>
<%@page import="com.sbj.urs.model.Common.Formatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   String unavailable = (String)request.getAttribute("unavailable");//손님이 선택한 좌석
   List<String> resultList = (List)request.getAttribute("resultList");//선택한 메뉴Id,이름,갯수,가격
   String store_id = (String)request.getAttribute("store_id"); //선택한 store_id
   int int_store_id = Integer.parseInt(store_id);
   Map<String, String> menuMap = (Map)request.getAttribute("menuMap"); //(선택한 메뉴ID : Img 확장자)Map
   String reservationTableInx = (String)request.getAttribute("reservationTableInx");//선택한 좌석
   List<String> saveID = new ArrayList<String>();//같은 품목 있는지 비교 위해 ID(값) 저장   
   List<String> saveCnt = new ArrayList<String>();//같은 품목 있는지 비교 위해 ID(값) 저장   
   List<String> saveTotal = new ArrayList<String>();//같은 품목 있는지 비교 위해 ID(값) 저장    
   int FinalTotal = 0; //최종 합산 금액 합
   int FinalQuantity =0;//최종 메뉴 갯수 합
   String menu_ids ="";
   String ImgExtend=""; //메뉴 확장자 이름
   //중복 메뉴 합산 로직
   for(int i=0; i<resultList.size(); i++){
      String copyResult = resultList.get(i);
      String[] arr = copyResult.split(",");
      saveID.add(arr[0]);
      saveCnt.add(arr[2]);
      saveTotal.add(arr[3]);
      
      String text="";
      
      //중복 체크  
      for(int j=0; j<i; j++){
         if(saveID.get(j).equals(arr[0])){ // i값이 j에 들어있다면
            int totalCnt = (Integer.parseInt(saveCnt.get(j))+Integer.parseInt(saveCnt.get(i)));
            int totalPrice = (Integer.parseInt(saveTotal.get(j))+Integer.parseInt(saveTotal.get(i)));            
            saveCnt.set(j, Integer.toString(totalCnt));
            saveTotal.set(j, Integer.toString(totalPrice));
            String arr2 = resultList.get(j);
            String[] splitArr2 = arr2.split(",");
                  
            for(int k=0; k<4; k++){               
               if(k==3){ 
                  text += saveTotal.get(j);   
               }else if(k==2){
                  text += saveCnt.get(j)+",";
               }
               else{
                  text += splitArr2[k]+",";
               }
            }
            resultList.set(j, text);
            resultList.remove(i);
            saveID.remove(i);
            saveCnt.remove(i);
            saveTotal.remove(i);                  
            i--;   
         }
      }      
      
   }   
%>
<!DOCTYPE html>
<html lang="en">
<head>   
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>Urs | Home</title>
   <%@ include file="../inc/header2.jsp" %> <!-- 결제 template용 header2 -->
   <%@ include file="../inc/top.jsp"%>
   
   <script>
   function before(){
      if(confirm("메뉴 선택 화면으로 돌아가시겠습니까?")){
         location.href="/shop/store/category/menu?store_id=<%=store_id%>"; //store_id로 돌아가기
      }   
   }

   
   function checkoutForm(){
      alert("결제가 완료되었습니다.");
       var str = "";
       var str2= "";
               
       $("input[name='store_id']").val(<%=store_id%>);       
       $("input[name='unavailable']").val("<%=unavailable%>"); //예약된 총좌석
       $("input[name='reservation_table']").val("<%=reservationTableInx%>");//손님이 선택한 좌석만(결제 취소시 삭제용도)       
       $("#payment").attr({
         action:"/customer/reservation",
         method:"post"         
      });
      $("#payment").submit();        
   }
   </script>
</head>

<body>       
        <!-- ****** Top Discount Area End ****** -->
      
        <!-- ****** Cart Area Start ****** -->
        <div class="cart_area section_padding_100 clearfix">
            <div class="container">
               <form id="cart-form">
                <div class="row">
                    <div class="col-12">
                        <div class="cart-table clearfix">
                            <table class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Menu_ID</th>
                                        <th>Name</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   <%for(int i=0; i<resultList.size(); i++){%>
                                   <%String result = resultList.get(i); %>                              
                                   <%String[] arr = result.split(","); %> 
                                   <%FinalTotal += Integer.parseInt(arr[3]); %>
                                   <%FinalQuantity += Integer.parseInt(arr[2]); %>
                                   <%menu_ids +=arr[0];
                                   if(i!=resultList.size()-1){
                                      menu_ids+=",";
                                   } %>
                                   <%System.out.println("메뉴id는:"+menu_ids); %>
                                   <%if(menuMap.containsKey(arr[0])) {
                                      ImgExtend = menuMap.get(arr[0]);                              
                                   }%>                                  
                                    <tr>
                                        <td class="cart_product_img d-flex align-items-center">
                                            <img src="/resources/data/menu/<%=arr[0]%>.<%=ImgExtend%>" style="width: 250px; height:150px" alt="Product">
                                            <h6 style="margin-left: 140px; font-size:40px; height:50px; color: orange;" > > </h6>
                                        </td>
                                       <td><span style="font-size:15px;"><%=arr[0]%></span></td>
                                       <td><span style="font-size:15px;"><%=arr[1]%></span></td>                                                                                
                                        <td class="qty">
                                            <div class="quantity" style="font-size:15px;"><%=arr[2] %></div>
                                        </td>
                                      
                                        <td class="total_price"><span style="font-size:15px;"><%=Formatter.getCurrentcy(Integer.parseInt(arr[3]))%></span></td>
                                    </tr>
                                   <%} %>
                                </tbody>
                            </table>
                        </div>

                        <div class="cart-footer d-flex mt-30">
                            <div class="back-to-shop w-50">
                                <a href="javascript:before()" style="background: orange; color:white;">메뉴 선택 돌아가기</a>
                            </div>
                            <!-- <div class="update-checkout w-50 text-right">
                                <a href="javascript:before()" style="background: orange; color:white;">메뉴 선택 돌아가기</a>                                
                            </div> -->
                        </div>

                    </div>
                </div>
            </form>
               
                <div class="row">
                   <div class="col-12 col-lg-4"><br/><br/><br/><br/><br/><h4>결제 후, 30분 동안<br/>도착하지 않을시<br/>자동 결제 취소 됩니다.</h4><br/><img src="/resources/images/clock.png" width="200px" height="200px"></div>        
                   <div class="col-12 col-lg-4"></div>        
                    <div class="col-12 col-lg-4">
                        <div class="cart-total-area mt-70">
                            <div class="cart-page-heading">
                                <h5>Shopping total</h5>
                                <p>Final info</p>
                            </div>

                            <ul class="cart-total-chart">
                                <li><span>Subtotal</span><span><%=Formatter.getCurrentcy(FinalTotal) %></span></li>
                                <li><span>Tax Free</span> <span>Free</span></li>
                                <li><span>Discount</span> <span>0</span></li>
                                <li><span><strong>Total</strong></span><span><strong><%=Formatter.getCurrentcy(FinalTotal) %></strong></span></li>
                            </ul>
                            <form id="payment">                            
                            <input type="hidden" name="store_id">
                            <input type="hidden" name="receipt_totalamount" value="<%=FinalTotal%>">
                            <input type="hidden" name="menu_quantity" value="<%=FinalQuantity%>">
                            <input type="hidden" name="unavailable">
                            <input type="hidden" name="reservation_table">
                            <input type="hidden" name="menu_ids" value="<%=menu_ids%>">
                            <a href="javascript:checkoutForm()" class="btn karl-checkout-btn" style="background: orange; color:white;">결제 하기</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ****** Cart Area End ****** -->      
        <!-- ****** Footer Area Start ****** -->
        
        <!-- ****** Footer Area End ****** -->
    </div>
    <!-- /.wrapper end -->
</body>

</html>