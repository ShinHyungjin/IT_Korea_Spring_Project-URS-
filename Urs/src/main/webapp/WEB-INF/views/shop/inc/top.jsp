<%@page import="com.sbj.urs.model.domain.Menu"%>
<%@page import="com.sbj.urs.model.domain.Store"%>
<%@page import="com.sbj.urs.model.domain.Member"%>
<%@page import="com.sbj.urs.model.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
   List<Category> categoryList = (List)request.getAttribute("categoryList");
   String path = (String)request.getAttribute("javax.servlet.forward.request_uri");
%>
   <style>
      li {
       display: block;
       transition-duration: 0.5s;
      }
      
      li:hover {
        cursor: pointer;
      }
      
      ul li ul {
        visibility: hidden;
        opacity: 0;
        position: absolute;
        transition: all 0.5s ease;
        margin-top: 1rem;
        left: 0;
        display: none;
      }
      
      ul li:hover > ul,
      ul li ul:hover {
        visibility: visible;
        opacity: 1;
        display: block;
      }
      
      ul li ul li {
        clear: both;
        width: 100%;
      }
   </style>
   
   <div class="py-1 bg-black top">
       <div class="container">
          <div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
             <div class="col-lg-12 d-block">
                <div class="row d-flex">
                   <div class="col-md pr-4 d-flex topper align-items-center">
                      <div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
                      <span class="text">urs.untact.reservation@gmail.com</span>
                   </div>
                </div>
             </div>
          </div>
        </div>
    </div>
     <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
       <div class="container">
         <a class="navbar-brand" href="/">URS</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
           <span class="oi oi-menu"></span> Menu
         </button>

         <div class="collapse navbar-collapse" id="ftco-nav">
           <ul class="navbar-nav ml-auto"> 
              <li class="nav-item <%if(path.equals("/")){ %>active <%}%>"><a href="/" class="nav-link">Home</a></li>
              <li class="nav-item dropdown" id="navdropdown">
               <a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown">  More items  </a>
                <ul class="dropdown-menu">
                 
                        <%for(Category category : categoryList){ %>
                    <li><a class="dropdown-item"    onMouseOver="this.style.color='#0F0'"
   onMouseOut="this.style.color='#00F'" href="/shop/store/category?category_id=<%=category.getCategory_id()%>"><%=category.getCategory_name()%></a></li>
                   <%} %>
                    
                </ul> 
            </li>
             
             <%if(session.getAttribute("member")==null){ %>
             <li class="nav-item cta"><a href="/shop/member/loginform" class="nav-link">로그인</a></li>
             <%}else{ %>
             <%Member mem = (Member)session.getAttribute("member"); %>
             <li class="nav-item" ><a href="/shop/member/storeregist" class="nav-link">점포등록 및 관리</a></li>
             <li class="nav-item"><a href="/shop/member/reservation" class="nav-link">결제목록</a></li>
             <li class="nav-item"><a href="/shop/member/mypage" class="nav-link">마이페이지</a></li>
             <li class="nav-item cta"><a href="/shop/member/loginout" class="nav-link">로그아웃</a></li>
             <%} %>
           </ul>
         </div>
       </div> 
     </nav>
    <!-- END nav -->