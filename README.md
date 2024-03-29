# Java Spring FrameWork(4.3) Project(2021.01.04 ~ 2021.01.18) URS

## 1.프로젝트 개요

>1. 해당 프로젝트는 Spring FrameWork의 기초 이해 및 EJS를 이용한 Front를 구현한 웹 프로젝트이다.<br>
>2. Spring FrameWork의 기본 모델인 MVC 패턴을 이해하고 Model Data는 EJS로 받아 표현 및 처리한다.<br>
>3. Spring FrameWork에서 제공되는 모듈 중 'AOP'를 통해 로그인한 사용자에 따라 기능 제한을 구현하였다.<br>
>4. 코로나로 인한 비대면 시스템 및 서비스가 많이 제공됨에 따라 수요층이 많을것으로 예상되는 **비대면 예약 시스템(Untact Reservation System)**을 아이디어로 채택하였다.

## 2. 프로젝트 자원

>+ 인력 : 3인
>+ 기간 : 약 2주(평일 09-18시 이후)
>+ SW : Oracle 11g XE, JDK 1.8, Lombok, SMTP, Spring FrameWork, Jackson Json, Tomcat 8.5
>+ 기타 정적 자원 : Free PNG Format Image & 직접 디자인, Free Font, Free Front Template

## 3. 프로젝트 수행흐름

>1. 아이디어 구상 및 컨셉 회의
>2. 필수 기능 정리 및 화면 설계
>3. 역할별 업무 분담
>4. 역할별 업무 수행
>><ol> 4.1 디자인 및 필요 자원 수집(Image, Font, Front Template) </ol>
>><ol> 4.2 DB 구축(TableSpace, User, Table, JDBC 설정 등) [본인] </ol>
>><ol> 4.3 기능 구현(화면[관리자, 일반사용자, 가게주인], CRUD, 페이지 전환, 카카오 페이 API 등) [본인 - 관리자 기능, 카카오 페이 API 등] </ol>

## 4. 프로젝트 시나리오

>+ 유명한 맛집 또는 웨이팅이 일상인 식당을 온라인으로 예약하기 위한 비대면 예약 웹 사이트 이다.
>+ 해당 시스템을 사용하는 사용자 유형은 **예약자, 가게주인, 관리자** 이다.
>+ **예약자**는 회원가입 후, 자신이 방문하고 싶은 식당을 선택하여 메뉴 및 좌석을 선택 후 최종 결제를 통해 예약한다.
>+ **가게주인**은 회원가입 후, '점포등록'을 하면 심사 후 점포로 등록되며, 이후 좌석 및 메뉴 관리를 통해 예약자에게 자신의 가게 정보를 노출한다.
>+ **관리자**는 결제, 사용자, 점포 및 메뉴 관리를 할 수 있으며, 점포를 등록한 리스트를 심사하여 '예약자'들이 예약을 할 수 있도록 설정한다.

## 5. 사용자 유형별 기능

>1. 예약자
>>+ 등록된 점포 리스트 및 메뉴 리스트 조회, 잔여 좌석 조회, 결제 후 결제 목록 조회

>2. 가게주인
>>+ 예약자 기능 + 점포 좌석 관리, 주문 관리, 메뉴 관리

>3. 관리자
>>+ 점포 관리, 사용자 관리, 결제관리
 
## 6. 프로젝트 결과
>### 메인 화면 (Github 용량제한으로 이미지 및 프레임이 다소 저품질)

![메인](./mdImages/main.gif)

>### 메인 화면 버튼 구성

![메인](./mdImages/main.png)

>### 로그인

![로그인](./mdImages/login.png)

>### 비밀번호 찾기(메일로 임시 비밀번호 전송)

![비밀번호 찾기](./mdImages/forgotpassword.png)

>### 회원가입

![회원가입](./mdImages/signup.png)

>### 사용자 유형별 화면
***
>> ### 1.예약자

>>> ### 예약자 메인화면
>>>> ![예약자 메인](./mdImages/m_main.png)

>>> ### 예약자 마이페이지
>>>> ![예약자 마이페이지](./mdImages/m_mypage.png)

>>> ### 예약자 카테고리 선택(중식)
>>>> ![예약자 카테고리 선택](./mdImages/m_chineseFood.png)

>>> ### 예약자 메뉴선택
>>>> ![예약자 메뉴선택](./mdImages/m_choiceMenu.png)

>>> ### 예약자 좌석선택
>>>> ![예약자 좌석선택](./mdImages/m_choiceTable.png)
>>>> ![예약자 좌석선택2](./mdImages/m_choiceTable2.png)

>>> ### 예약자 결제
>>>> ![예약자 결제](./mdImages/m_pay.png)

>>> ### 예약자 결제목록
>>>> ![예약자 결제목록](./mdImages/m_reservationList.png)

***
>> ### 2.가게주인

>>> ### 가게주인 점포등록
>>>> ![가게주인 점포등록](./mdImages/s_storeRegist.png)

>>> ### 가게주인 주문관리(점포등록 후)
>>>> ![가게주인 주문관리](./mdImages/s_order.png)

>>> ### 가게주인 메뉴관리
>>>> ![가게주인 메뉴관리](./mdImages/s_menuList.png)

>>> ### 가게주인 메뉴추가
>>>> ![가게주인 메뉴추가](./mdImages/s_menuAdd.png)

>>> ### 가게주인 테이블 관리
>>>> ![가게주인 테이블 관리](./mdImages/s_tablebatch.png)

>>> ### 가게주인 테이블 관리 초기 설정
>>>> ![가게주인 테이블 관리 초기 설정](./mdImages/s_tableBatchFirst.png)

***
>> ### 3.관리자

>>> ### 관리자 점포관리
>>>> ![관리자 점포관리](./mdImages/a_storeList.png)

>>> ### 관리자 점포 상세조회
>>>> ![관리자 점포 상세조회](./mdImages/a_storeDetail.png)

>>> ### 관리자 점포 승인 후 메인화면
>>>> ![관리자 점포 승인 후 메인화면](./mdImages/a_vipsAdd.png)

>>> ### 관리자 고객관리
>>>> ![관리자 고객관리](./mdImages/a_userList.png)

>>> ### 관리자 고객 상세조회
>>>> ![관리자 고객 상세조회](./mdImages/a_userDetail.png)

>>> ### 관리자 결제관리
>>>> ![관리자 결제관리](./mdImages/a_payList.png)

