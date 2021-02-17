package com.sbj.urs.rest.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sbj.urs.model.Common.BootpayApi;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.domain.Receipt;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.member.service.MemberService;
import com.sbj.urs.model.receipt.service.ReceiptService;
import com.sbj.urs.model.reservation.service.ReservationService;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.StoreService;
import com.sbj.urs.model.store.service.TableMapService;
import com.sbj.urs.rest.websocket.MyWebSocketHandler;
import com.sbj.urs.rest.websocket.SocketMessage;

import kr.co.bootpay.javaApache.model.request.Cancel;

@RestController
public class StoreController {
   
   @Autowired
   private StoreService storeService;
   
   @Autowired
   private MenuService menuService;
   
   @Autowired
   private TableMapService tableMapService;
   
      @Autowired
      private ReceiptService receiptService;
      
      @Autowired
      private ReservationService reservationService;
      @Autowired
      private MemberService memberService;
      
      @Autowired
      private MyWebSocketHandler myWebSocketHandler;
      
      
      Gson gson = new Gson();
   
   @GetMapping("/store/{category_id}")
   public List<Store> getList(@PathVariable int category_id){
      List<Store> storeList = storeService.selectAllById(category_id);
      
      return storeList;
   }
   
   @GetMapping("/store/menu")
   public List<Menu> getMenu(){
      List<Menu> menuList = menuService.selectAll();
      
      return menuList;
   }
   
   @GetMapping("/store/menu/{store_id}")
   public List<Menu> getMenuList(@PathVariable int store_id){
      List<Menu> menuList = menuService.selectById(store_id);
      
      return menuList;
   }
   
   @GetMapping("/store/table/{store_id}")
   public TableMap getTableMap(@PathVariable int store_id) {
      TableMap tableMap = tableMapService.selectById(store_id);
      
      return tableMap;
   }
   
   
   // 점포가 store/manage 페이지에서 비동기로 삭제시 결제를 삭제하면 해당 영수증을 삭제하기 전에 예약을 먼저 삭제해야함, 그리고 다시 영수증 목록을 불러옴
    @PostMapping(value = "/store/manage/payment/paymentdelete")
    public ResponseEntity<List<List>> deletePayment(HttpServletRequest request, int receipt_id,String bootpay_id) {
       Receipt receipt =  receiptService.select(receipt_id); //receipt에서 선택한 테이블 얻기 위함
         String cancleTable = receipt.getReservation_table();
         TableMap tablemap =  tableMapService.selectById(receipt.getStore_id());
         String unavailstr=""; //선택한 좌석 취소 후, 업데이트한 unavailable;
         String unavailable = tablemap.getUnavailable();
         String[] unavailArr = unavailable.split(",");//
         String[] cancleTableArr = cancleTable.split(","); //취소용 split
         List<String> unavailList = new ArrayList<String>();
         for(int i=0; i<unavailArr.length; i++) {
            unavailList.add(unavailArr[i]);
         }
         //System.out.println("unavailable:"+ unavailable);
         for(int i=0; i<cancleTableArr.length; i++) {
            int pos =unavailList.indexOf(cancleTableArr[i]);
            unavailList.remove(pos);
         }
         
         for(int j=0; j<unavailList.size(); j++) {
            unavailstr += unavailList.get(j);
            if(j!=unavailList.size()-1) {unavailstr+=",";}
         }
         tablemap.setUnavailable(unavailstr);
         
         if(tablemap.getUnavailable() == "") {
            tablemap.setUnavailable("0_0");
         }
         
         tableMapService.updateReservation(tablemap); //손님이 선택한 좌석 취소          
          reservationService.delete(receipt_id);//손님이 결제한 내역 삭제
          receiptService.delete(receipt_id);//손님이 결제한 영수증 삭제
          
          List<Receipt> receiptList = receiptService.selectAll();
          List<Member> memberList = new ArrayList<Member>();
          List<Store> storeList = new ArrayList<Store>();
          for(int i=0; i<receiptList.size(); i++) {
             Member member = memberService.selectOne(receiptList.get(i).getMember_id());
             memberList.add(member);
             Store store = storeService.selectById(receiptList.get(i).getStore_id());
             storeList.add(store);
             System.out.println("receiptList size : "+receiptList.size()+"\t receipt_id : " + receiptList.get(i).getReceipt_id());
             System.out.println("memberList size : "+memberList.size()+"\t user_name : " + memberList.get(i).getUser_name());
             System.out.println("storeList size : "+storeList.size()+"\t store_name : " + storeList.get(i).getStore_name());
          }
          List<List> totalList = new ArrayList<List>();
          totalList.add(receiptList);
          totalList.add(memberList);
          totalList.add(storeList);
          
          BootpayApi api = new BootpayApi(
                  "602379255b2948002151ff47",
                  "RKpfX82izfRy8J2+L1tuc2rWFXIFnEEh487GlLjvNbo="
          );
          
          try {
            api.getAccessToken();
         } catch (Exception e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
         }
          
          


          Cancel cancel = new Cancel();
          cancel.receipt_id = bootpay_id;
          cancel.name = "urs";
          cancel.reason = "택배 지연에 의한 구매자 취소요청";

          try {
              HttpResponse res = api.cancel(cancel);
              String str = IOUtils.toString(res.getEntity().getContent(), "UTF-8");
              System.out.println(str);
          } catch (Exception e) {
              e.printStackTrace();
          }
          
         //웹소켓을 이용한 브로드케스트!! 
         SocketMessage socketMessage = new SocketMessage();
         socketMessage.setRequestCode("create");
         socketMessage.setResultCode(200);
         socketMessage.setMsg("등록성공");
         
         String jsonString = gson.toJson(socketMessage);
         myWebSocketHandler.broadCast(jsonString); //but 클라이언트와 서버와 약속된 프로토콜...
    
          return ResponseEntity.ok().body(totalList);
       }
    
   
   
   
   

}