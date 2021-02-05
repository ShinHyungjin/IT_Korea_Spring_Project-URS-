<%@ page contentType="text/html;charset=UTF-8"%>
<% 
   List<Store> storeList2 = (List)request.getAttribute("storeList2");
   Category categoryDetail = (Category)request.getAttribute("categoryDetail");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Appetizer - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <%@ include file="../inc/header.jsp" %>    

 
  </head>
  <body>
     <%@ include file="../inc/top.jsp" %>    
   
    <section class="ftco-section" style="background-color: black">
       <div class="container-fluid px-4" style="background-color: white">
          <div class="row justify-content-center mb-5 pb-2">
          <div class="col-md-7 text-center heading-section ftco-animate">
             <span class="subheading">Specialties</span>
            <h2 class="mb-4"><%=categoryDetail.getCategory_name()%></h2>
          </div>
        </div>
        <% int numstore = 0; int storetotal = 0;
        if(storeList2.size()%3!=0) { numstore = (storeList2.size()/3) +1;
      } else { numstore = (storeList2.size()/3);} %>
        <%for(int k=0; k<numstore; k++) {%>
        <div class="row">
           <%for(int i = 0 ; i < 3 ; i++){ %>
            
                 <%if(storetotal == storeList2.size()){break;} %>
                 <%Store storeDetail = storeList2.get(storetotal); %>
                 <%storetotal++; %>
           <div class="col-md-6 col-lg-4 menu-wrap">
                
              <div class="menus d-flex ftco-animate">
              <div class="menu-img img" style="background-image: url(/resources/data/store/<%=storeDetail.getMember_id()%>M.<%=storeDetail.getStore_image()%>);"></div>
              <div class="text">
                 <div class="d-flex">
                   <div class="one-half">
                   <%if(storeDetail.getStore_reservation().equals("FALSE")){ %>
                       <h3 style="color: gray"><%=storeDetail.getStore_name() %></h3>
                   <%}else{ %>
                     <a href="/shop/store/category/menu?store_id=<%=storeDetail.getStore_id()%>"><h3><%=storeDetail.getStore_name() %></h3></a>
                   <%} %>
                   </div>
                   <div class="one-forth">
                     <span class="price"><%if(storeDetail.getStore_reservation().equals("TRUE")) { %>예약가능<%} else {%>예약불가<%}%></span>
                   </div>
                 </div>
                 <p><span><span style="font-weight:bold;">영업 시간  :  </span><%=storeDetail.getStore_openhour()%> ~ <%=storeDetail.getStore_closehour()%></span></p>
              </div>
            </div> 
      
    
            
           </div>
           <%} %>
         
        </div>
        <%} %>
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

   <%@ include file="../inc/footer.jsp" %>  
  </body>
</html>