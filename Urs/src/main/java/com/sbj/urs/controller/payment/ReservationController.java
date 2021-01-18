package com.sbj.urs.controller.payment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Receipt;
import com.sbj.urs.model.domain.Reservation;
import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.receipt.service.ReceiptService;
import com.sbj.urs.model.reservation.service.ReservationService;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.TableMapService;


@Controller
public class ReservationController {
   @Autowired
   private CategoryService categoryService;
   
   @Autowired
   private TableMapService tableMapService;
   
   @Autowired
   private ReservationService reservationService;
   
   @Autowired
   private ReceiptService receiptService;
   
   @Autowired
   private MenuService menuService; //선택한 메뉴 이미지 확장자 얻기 위함
   
   //******************고객이 선택한 좌석 정보 가져온 결제 메인화면*****************   
   @RequestMapping(value = "/customer/table/regist", method = RequestMethod.POST)      
   public ModelAndView reservationTable(String unavailable, String resultArr, String store_id, String reservationTableInx) {
     List categoryList = categoryService.selectAll();
      Map<String, String> menuMap = new HashMap<String, String>();
     //System.out.println(resultArr);
      List<String> resultList = new ArrayList<String>();
      String replaceResult = resultArr.replaceAll(" ",""); //resultArr 공백제거
      String[] splitStr = replaceResult.split("/");      
      for(int i=0; i<splitStr.length; i++) {
        System.out.println("스플릿:"+splitStr[i]);
         resultList.add(splitStr[i]);         
         String menu_id = splitStr[i].split(",")[0]+"";//메뉴ID
         String menuImg = menuService.selectByImage(Integer.parseInt(menu_id)); //메뉴ID의 이미지 확장자 가져오기
         menuMap.put(menu_id, menuImg);         
      }
      
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("unavailable",unavailable);
      mav.addObject("resultList",resultList);
      mav.addObject("store_id",store_id);
      mav.addObject("menuMap",menuMap);
      mav.addObject("categoryList",categoryList);
      mav.addObject("reservationTableInx",reservationTableInx); //=손님이 선택한 좌석(취소시 삭제위함)
      mav.setViewName("shop/pay/reservation");
      return mav;
   }
   
   @RequestMapping(value="/customer/reservation", method=RequestMethod.POST)
   public ModelAndView payment(HttpServletRequest request, String store_id, int receipt_totalamount, int menu_quantity, String unavailable, String reservation_table, String menu_ids) {
      HttpSession session = request.getSession();
      Member sessionmember = (Member)session.getAttribute("member"); //get member session
      TableMap tableMap = new TableMap();//tablemap update
      Receipt receipt = new Receipt(); //receipt vo send
      Reservation reservation = new Reservation();
      System.out.println("스토어아디"+store_id);
      receipt.setMember_id(sessionmember.getMember_id());
      receipt.setStore_id(Integer.parseInt(store_id));
      receipt.setReceipt_totalamount(receipt_totalamount);
      receipt.setMenu_quantity(menu_quantity);
      receipt.setReservation_table(reservation_table);
      
      tableMap.setStore_id(Integer.parseInt(store_id));
      tableMap.setUnavailable(unavailable);
            
      System.out.println("menu"+menu_ids);
      receiptService.insert(receipt); //결제 정보 insert
      
      String[] menu_idArr = menu_ids.split(","); //menu 테이블에 넣을 갯수 만큼 insert 하기 위해서      
      for(int i=0; i<menu_idArr.length; i++) {         
         reservation.setReceipt_id(receipt.getReceipt_id()); //selectkey로 얻어온 receipt_id
         reservation.setMenu_id(Integer.parseInt(menu_idArr[i]));
         reservationService.insert(reservation);      
      }
      tableMapService.updateReservation(tableMap);//예약된 좌석 update      
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:/");
      return mav;
   }
}