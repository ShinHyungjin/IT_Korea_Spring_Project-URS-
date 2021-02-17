package com.sbj.urs.rest.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sbj.urs.model.domain.Category;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.domain.Paybill;
import com.sbj.urs.model.domain.Receipt;
import com.sbj.urs.model.domain.Reservation;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.member.service.MemberService;
import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.receipt.service.ReceiptService;
import com.sbj.urs.model.reservation.service.ReservationService;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.StoreService;
import com.sbj.urs.model.store.service.TableMapService;
import com.sbj.urs.rest.websocket.MyWebSocketHandler;
import com.sbj.urs.rest.websocket.SocketMessage;

@RestController
public class MemberController {

   @Autowired
   private TableMapService tableMapService;
   @Autowired
   private MemberService memberService;
   @Autowired
   private CategoryService categoryService;
   @Autowired
   private StoreService storeService;
   @Autowired
   private MenuService menuService;
   @Autowired
   private ReceiptService receiptService;
   @Autowired
   private ReservationService reservationService;
   
   @Autowired
   private MyWebSocketHandler myWebSocketHandler;
   
   
   Gson gson = new Gson();

   // 로그인 요청 처리
   @PostMapping("/member")
   public int login(@RequestBody Member member) {
      System.out.println(member.getUser_id());
      System.out.println(member.getUser_password());
      // db에 존재여부 확인
      Member obj = memberService.select(member);

      int member_id = (int) obj.getMember_id();
      
      
//  	//웹소켓을 이용한 브로드케스트!! 
//		SocketMessage socketMessage = new SocketMessage();
//		socketMessage.setRequestCode("create");
//		socketMessage.setResultCode(200);
//		socketMessage.setMsg("등록성공");
//		
//		String jsonString = gson.toJson(socketMessage);
//		myWebSocketHandler.broadCast(jsonString); //but 클라이언트와 서버와 약속된 프로토콜...

      return member_id;
   }

   @PostMapping("/member/{member_id}")
   public Member getDetail(@PathVariable int member_id) {
      Member member = memberService.selectOne(member_id);
      System.out.println(member_id);
      return member;
   }

   @PutMapping("/member")
   public int update(@RequestBody Member member) {
      System.out.println(member.getUser_birthday());
      System.out.println(member.getUser_email_id());
      System.out.println(member.getUser_gender());
      System.out.println(member.getUser_location());
      System.out.println(member.getUser_name());
      memberService.update(member);

      return 1;
   }

   @PostMapping("/member/regist")
   public int regist(@RequestBody Member member) {
      memberService.RESTregist(member);
      return 1;
   }

   @PostMapping("/member/checkId")
   public int checkId(@RequestBody String user_id) {
      String id = user_id.substring(1, user_id.length() - 1);
      System.out.println(id);
      Member obj = memberService.checkId(id);
      int result = 0;
      if (obj == null) {
         result = 1;
      } else {
         result = 0;
      }

      return result;
   }

   // 회원이 카테고리 1개 클릭 시 해당 카테고리 점포 목록 가져오기
   @PostMapping("/member/storeList/{category_id}")
   public List<Store> getList(@PathVariable int category_id) {
      List<Store> storeList = storeService.selectAllById(category_id);

      return storeList;
   }

   // 회원이 가게 리스트 중 한개 클릭시 해당 가게의 메뉴 목록 가져오기
   @PostMapping("/member/menuList/{store_id}")
   public List<Menu> getMenuList(@PathVariable int store_id) {
      List<Menu> menuList = menuService.selectById(store_id);

      return menuList;
   }

   // 회원아이디에 맞게 영수증 출력
   @PostMapping("/member/receipt/{member_id}")
   public List<List> getReceiptList(@PathVariable int member_id) {
      List<Receipt> receiptList = receiptService.selectByMemberId(member_id);
      List<List> reservationList = new ArrayList<List>();
      List<Menu> menuList = new ArrayList();
      ArrayList<Store> storereservationList = new ArrayList<Store>();
      for (int i = 0; i < receiptList.size(); i++) {
         Store store = storeService.selectById(receiptList.get(i).getStore_id());
         List<Reservation> reservation = reservationService.selectAllById(receiptList.get(i).getReceipt_id());
         for (int j = 0; j < reservation.size(); j++) {
            Menu menu = menuService.select(reservation.get(j).getMenu_id());
            menuList.add(menu);
            System.out.println("reservation_id : " + reservation.get(j).getReservation_id() + "\tmenu_id : "
                  + menuList.get(j).getMenu_id() + "\tmenu_name : " + menuList.get(j).getMenu_name()
                  + "\tmenuList Size : " + menuList.size());
         }
         storereservationList.add(store);
         reservationList.add(reservation);
         System.out.println("store_id : " + storereservationList.get(i).getStore_id() + "\tstoreList Size : "
               + storereservationList.size());
      }
      List<List> totalList = new ArrayList<List>();

      totalList.add(receiptList);
      totalList.add(storereservationList);
      totalList.add(reservationList);
      totalList.add(menuList);

      return totalList;
   }
   
   @PostMapping("/member/tableMap/{store_id}")
   public TableMap getTableMap(@PathVariable int store_id) {
      TableMap tableMap = tableMapService.selectById(store_id);
      
      return tableMap;
   }
   
   @PostMapping("/member/paybill")
   public ResponseEntity<Integer> payList(@RequestBody Paybill paybill) {
	   System.out.println(paybill);
	   TableMap tableMap = new TableMap();//tablemap update
	      Receipt receipt = new Receipt(); //receipt vo send
	      Reservation reservation = new Reservation();
	      TableMap map = tableMapService.selectById(Integer.parseInt(paybill.getStore_id()));
	      
	      System.out.println("스토어아디"+paybill.getStore_id());
	      receipt.setMember_id(paybill.getMember_id());
	      receipt.setStore_id(Integer.parseInt(paybill.getStore_id()));
	      receipt.setReceipt_totalamount(paybill.getReceipt_totalamount());
	      receipt.setMenu_quantity(paybill.getMenu_quantity());
	      receipt.setReservation_table(paybill.getReservation_table());
	      receipt.setBootpay_id(paybill.getBootpay_id());
	      
	      tableMap.setStore_id(Integer.parseInt(paybill.getStore_id()));
	      tableMap.setUnavailable(map.getUnavailable()+","+paybill.getUnavailable());
	            
	      System.out.println("menu"+paybill.getMenu_ids());
	      receiptService.insert(receipt); //결제 정보 insert
	      
	      String[] menu_idArr = paybill.getMenu_ids().split(","); //menu 테이블에 넣을 갯수 만큼 insert 하기 위해서      
	      for(int i=0; i<menu_idArr.length; i++) {         
	         reservation.setReceipt_id(receipt.getReceipt_id()); //selectkey로 얻어온 receipt_id
	         reservation.setMenu_id(Integer.parseInt(menu_idArr[i]));
	         reservationService.insert(reservation);      
	      }
	      tableMapService.updateReservation(tableMap);//예약된 좌석 update 
	      
			//웹소켓을 이용한 브로드케스트!! 
			SocketMessage socketMessage = new SocketMessage();
			socketMessage.setRequestCode("create");
			socketMessage.setResultCode(200);
			socketMessage.setMsg("등록성공");
			
			String jsonString = gson.toJson(socketMessage);
			myWebSocketHandler.broadCast(jsonString); //but 클라이언트와 서버와 약속된 프로토콜...
	      
	      return ResponseEntity.ok().body(receipt.getReceipt_id());
   }
   
   //테이블 리스트 가져오기 
   @GetMapping("/receipt")
   public List<List> getList(HttpServletRequest request) {
	   
	   HttpSession session = request.getSession();
	   Member sessionmember = (Member) session.getAttribute("member");
	   Store store = storeService.selectByMemberId(sessionmember.getMember_id());
	   
	      List<Receipt> receiptList = receiptService.selectByStoreId(store.getStore_id());
	      List<Member> memberList = new ArrayList<Member>();
	      List<Store> storeList = new ArrayList<Store>();
	      for (int i = 0; i < receiptList.size(); i++) {
	         Member member = memberService.selectOne(receiptList.get(i).getMember_id());
	         memberList.add(member);
	         storeList.add(store);
	      }
	     List combineList = new ArrayList();
	     
	     combineList.add(receiptList);
	     combineList.add(memberList);
	     combineList.add(storeList);
 
	   return combineList;
   }

}