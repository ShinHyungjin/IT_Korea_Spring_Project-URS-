<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="com.sbj.urs.model.domain.Store"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List<Store> storeList = (List)request.getAttribute("storeList");
   List<Menu> menuList = (List)request.getAttribute("menuList");
   int countMem =   ((Integer)request.getAttribute("countMem")).intValue();
   int countMenu =   ((Integer)request.getAttribute("countMenu")).intValue();
   int countStore =  ((Integer)request.getAttribute("countStore")).intValue();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>URS-Untact Reservation System</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <%@ include file="./shop/inc/header.jsp" %>    

  </head>
  <body>
     <%@ include file="./shop/inc/top.jsp" %>    
    
    <section class="home-slider owl-carousel js-fullheight">
      <div class="slider-item js-fullheight" style="background-image: url(./resources/images/bg_1.jpg);">
         <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text js-fullheight justify-content-center align-items-center" data-scrollax-parent="true">

            <div class="col-md-12 col-sm-12 text-center ftco-animate">
              <h2 class="mb-4 mt-5" style="color:white ;font-weight:bold">화려하고 복잡한 걸작을 요리할 필요는 없다. 다만, 신선한 재료로 좋은 음식을 요리하다.</h2>
              
            </div>

          </div>
        </div>
      </div>

      <div class="slider-item js-fullheight" style="background-image: url(./resources/images/bg_2.jpg);">
         <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text js-fullheight justify-content-center align-items-center" data-scrollax-parent="true">

            <div class="col-md-12 col-sm-12 text-center ftco-animate">
              <h2 class="mb-4 mt-5" style="color:white ;font-weight:bold">진정한 식사의 즐거움은 그 식사시간 자체의 흥을 돋아야한다.</h2>
              
            </div>

          </div>
        </div>
      </div>

      <div class="slider-item js-fullheight" style="background-image: url(./resources/images/bg_3.jpg);">
         <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

            <div class="col-md-12 col-sm-12 text-center ftco-animate">
              <h2 class="mb-4 mt-5" style="color:white ;font-weight:bold"> 기분이 저기압일 땐 반드시 고기앞으로</h2>
              
            </div>

          </div>
        </div>
      </div>
    </section>
   

      <section class="ftco-section ftco-wrap-about ftco-no-pb">
         <div class="container">
            <div class="row justify-content-center">
               <div class="col-sm-10 wrap-about ftco-animate text-center">
    
                
                  <div class="video justify-content-center">
                     <a href="https://vimeo.com/104974819" class="icon-video popup-vimeo d-flex justify-content-center align-items-center">
                       <span class="ion-ios-play"></span>
                    </a>
                  </div>
               </div>
            </div>
         </div>
      </section>

      
      <section class="ftco-section ftco-counter img" id="section-counter" style="background-image: url(./resources/images/bg_4.jpg);" data-stellar-background-ratio="0.5">
      <!-- <section class="ftco-section ftco-counter img ftco-no-pt" id="section-counter"> -->
       <div class="container">
          <div class="row d-md-flex align-items-center justify-content-center">
             <div class="col-lg-10">
                <div class="row d-md-flex align-items-center">
                <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
                  <div class="block-18">
                    <div class="text">
                      <strong class="number" data-number="1">0</strong>
                      <span>창립주년</span>
                    </div>
                  </div>
                </div>
                <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
                  <div class="block-18">
                    <div class="text">
                      <strong class="number" data-number="<%=countMem%>">0</strong>
                      <span>회원 수</span>
                    </div>
                  </div>
                </div>
                <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
                  <div class="block-18">
                    <div class="text">
                      <strong class="number" data-number="<%=countMenu%>">0</strong>
                      <span>메뉴 수 </span>
                    </div>
                  </div>
                </div>
                <div class="col-md d-flex justify-content-center counter-wrap ftco-animate">
                  <div class="block-18">
                    <div class="text">
                      <strong class="number" data-number="<%=countStore%>">0</strong>
                      <span>등록된 점포 수 </span>
                    </div>
                  </div>
                </div>
             </div>
          </div>
        </div>
       </div>
    </section>

    <section class="ftco-section">
       <div class="container-fluid px-4">
          <div class="row justify-content-center mb-5 pb-2">
          <div class="col-md-7 text-center heading-section ftco-animate">
             <span class="subheading">Specialties</span>
            <h2 class="mb-4">Our Stores</h2>
          </div>
        </div>
        
        <div class="row">
        
        <%for(Category category : categoryList) { %>
               
        <div class="col-md-6 col-lg-4 menu-wrap">
              <div class="heading-menu text-center ftco-animate">
                 <h3><%=category.getCategory_name() %></h3>
              </div>
              <%int cnt = 0 ; %>
              <%for(int i=0; i<storeList.size(); i++) { %>
                
               
              <%if(storeList.get(i).getCategory().getCategory_id() == category.getCategory_id() && storeList.get(i).getStore_pass().equals("TRUE") && storeList.get(i).getStore_reservation().equals("TRUE")){ cnt++;%>
                <%if(cnt==4)break; %>
              <div class="menus d-flex ftco-animate">
              <div class="menu-img img" style="background-image: url(/resources/data/store/<%=storeList.get(i).getMember_id()%>M.<%=storeList.get(i).getStore_image()%>);"></div>
              <div class="text">
                 <div class="d-flex">
                   <div class="one-half">
                     <a href="/shop/store/category/menu?store_id=<%=storeList.get(i).getStore_id()%>"><h3 style="font-weight:bold;"><%=storeList.get(i).getStore_name() %></h3></a> 
                   </div>
                   <div class="one-forth">
                     <span class="price"><%if(storeList.get(i).getStore_reservation().equals("TRUE")) { %>예약가능<%} else {%>예약불가<%}%></span>
                   </div>
                 </div>
                 <p><span><span style="font-weight:bold;">영업 시간  :  </span><%=storeList.get(i).getStore_openhour()%> ~ <%=storeList.get(i).getStore_closehour()%> </span>
                 </p>
              </div>
            </div>
                  <%} %>
               <%} %>
           </div>
           
              <%} %>
           
        </div>
       </div>
    </section>

      
      <section class="ftco-section ftco-no-pt ftco-no-pb">
         <div class="container-fluid px-0">
            <div class="row no-gutters">
               <div class="col-md">
                  <a href="#" class="instagram img d-flex align-items-center justify-content-center" style="background-image: url(./resources/images/insta-1.jpg);">
                     <span class="ion-logo-instagram"></span>
                  </a>
               </div>
               <div class="col-md">
                  <a href="#" class="instagram img d-flex align-items-center justify-content-center" style="background-image: url(./resources/images/insta-2.jpg);">
                     <span class="ion-logo-instagram"></span>
                  </a>
               </div>
               <div class="col-md">
                  <a href="#" class="instagram img d-flex align-items-center justify-content-center" style="background-image: url(./resources/images/insta-3.jpg);">
                     <span class="ion-logo-instagram"></span>
                  </a>
               </div>
               <div class="col-md">
                  <a href="#" class="instagram img d-flex align-items-center justify-content-center" style="background-image: url(./resources/images/insta-4.jpg);">
                     <span class="ion-logo-instagram"></span>
                  </a>
               </div>
               <div class="col-md">
                  <a href="#" class="instagram img d-flex align-items-center justify-content-center" style="background-image: url(./resources/images/insta-5.jpg);">
                     <span class="ion-logo-instagram"></span>
                  </a>
               </div>
            </div>
         </div>
      </section>

   <%@ include file="./shop/inc/footer.jsp" %>  
  </body>
</html>