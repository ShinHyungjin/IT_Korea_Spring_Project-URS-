<%@ page contentType="text/html;charset=UTF-8"%>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="/admin">관리자모드</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/admin">매장관리
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/member/memberlist">고객관리</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/admin/payment/paymentlist">결제관리</a>
          </li>
                    <li class="nav-item">
            <a class="nav-link" href="/shop/member/loginout">로그아웃</a>
          </li>
        </ul>
      </div>
    </div>
</nav>