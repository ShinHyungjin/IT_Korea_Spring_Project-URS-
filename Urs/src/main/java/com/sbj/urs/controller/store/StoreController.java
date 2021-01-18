package com.sbj.urs.controller.store;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Menu;
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

@Controller
public class StoreController {
	   @Autowired
	   private FileManager fileManager;
	   @Autowired
	   private CategoryService categoryService;
	   @Autowired
	   private MenuService menuService;
	   @Autowired
	   private StoreService storeService;
	   @Autowired
	   private ReceiptService receiptService;
	   @Autowired
	   private ReservationService reservationService;
	   @Autowired
	   private MemberService memberService;
	   @Autowired
	   private TableMapService tableMapService;
	
	   @RequestMapping(value = "/store/manage", method = RequestMethod.GET)
	   public ModelAndView storemanagement(HttpServletRequest request) {
	      HttpSession session = request.getSession();
	      Member sessionmember = (Member) session.getAttribute("member");
	      Store store = storeService.selectByMemberId(sessionmember.getMember_id());
	 
	      System.out.println(sessionmember);

	      List categoryList = categoryService.selectAll();
	      List<Receipt> receiptList = receiptService.selectByStoreId(store.getStore_id());
	      List<Member> memberList = new ArrayList<Member>();
	      List<Store> storeList = new ArrayList<Store>();
	      for (int i = 0; i < receiptList.size(); i++) {
	         Member member = memberService.selectOne(receiptList.get(i).getMember_id());
	         memberList.add(member);
	         storeList.add(store);
	      }
	      ModelAndView mav = new ModelAndView("store/index");
	      mav.addObject("receiptList", receiptList);
	      mav.addObject("memberList", memberList);
	      mav.addObject("storeList", storeList);
	      mav.addObject("store", store);
	      mav.addObject("categoryList", categoryList);

	      return mav;
	   }

	   // 결제리스트 화면에서 결제번호 클릭시 이동하는 Payment Detail 페이지
	   @RequestMapping(value = "/store/manage/payment/paymentdetail", method = RequestMethod.GET)
	   public ModelAndView getPaymentDetail(HttpServletRequest request,int receipt_id) {
	      Receipt receipt = receiptService.select(receipt_id);
	      Member member = memberService.selectOne(receipt.getMember_id());
	      Store store = storeService.selectById(receipt.getStore_id());
	      List<Reservation> reservationList = reservationService.selectAllById(receipt_id);
	      List<Menu> menuList = new ArrayList<Menu>();
	      for (int i = 0; i < reservationList.size(); i++) {
	         Menu menu = menuService.select(reservationList.get(i).getMenu_id());
	         menuList.add(menu);
	      }
	      ModelAndView mav = new ModelAndView("store/payment/payment_detail");
	      mav.addObject("receipt", receipt);
	      mav.addObject("member", member);
	      mav.addObject("store", store);
	      mav.addObject("menuList", menuList);

	      return mav;
	   }

	   // 점포가 store/manage 페이지에서 비동기로 삭제시 결제를 삭제하면 해당 영수증을 삭제하기 전에 예약을 먼저 삭제해야함, 그리고 다시 영수증 목록을 불러옴
	   @RequestMapping(value = "/store/manage/payment/paymentdelete", method = RequestMethod.GET)
	   @ResponseBody
	   public List deletePayment(HttpServletRequest request, int receipt_id) {
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
		      return totalList;
		   }

	   // 점포가 PaymentDetail에서 삭제하기 버튼 클릭시 동기적으로 삭제
	   @RequestMapping(value = "/store/manage/payment/paymentdetaildelete", method = RequestMethod.POST)
	   public ModelAndView detaildeletePayment(HttpServletRequest request, int receipt_id) {
	      HttpSession session = request.getSession();
	      Member sessionmember = (Member) session.getAttribute("member");
	      Store store = storeService.selectByMemberId(sessionmember.getMember_id());
	      
	      ModelAndView mav = new ModelAndView("store/index");
	      reservationService.delete(receipt_id);
	      receiptService.delete(receipt_id);
	      List<Receipt> receiptList = receiptService.selectByStoreId(store.getStore_id());
	      List<Member> memberList = new ArrayList<Member>();
	      List<Store> storeList = new ArrayList<Store>();
	      for (int i = 0; i < receiptList.size(); i++) {
	         Member member = memberService.selectOne(receiptList.get(i).getMember_id());
	         memberList.add(member);
	         storeList.add(store);
	      }
	      mav.addObject("receiptList", receiptList);
	      mav.addObject("memberList", memberList);
	      mav.addObject("storeList", storeList);
	      mav.addObject("store", store);

	      return mav;
	   }
	
	
	@RequestMapping(value="/store/menu", method = RequestMethod.GET)
	public ModelAndView storemenu(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member sessionmember = (Member) session.getAttribute("member");
		Store store = storeService.selectByMemberId(sessionmember.getMember_id());
	
		List menuList = menuService.selectById(store.getStore_id());
		
		ModelAndView mav = new ModelAndView("store/menu/menu_list");
		mav.addObject("menuList",menuList);
		return mav;
	}
	
	@RequestMapping(value="/store/menu/add", method = RequestMethod.GET)
	public ModelAndView addMenu(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member sessionmember = (Member) session.getAttribute("member");
		Store store = storeService.selectByMemberId(sessionmember.getMember_id());
	
	
		ModelAndView mav = new ModelAndView("store/menu/menu_regist");
		mav.addObject("store",store);
		return mav;
	}
	
	@RequestMapping(value="/store/menu/regist",method = RequestMethod.POST,produces = "text/html;charset=utf-8")
	@ResponseBody
	public String registMenu(HttpServletRequest request, Menu menu) {
		menuService.insert(fileManager, menu);
		
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"메뉴가 추가되었습니다.\"");
		sb.append("}");
		System.out.println(fileManager.getSaveMemberDir());
		
	 
 
		return sb.toString();
	}
	@GetMapping("/store/menu/menudetail")
	public ModelAndView manuDetail(HttpServletRequest request, int menu_id) {
		Menu menu = menuService.select(menu_id);
		ModelAndView mav = new ModelAndView("store/menu/menu_detail");
		mav.addObject("menu",menu);
		return mav;
	}
	
	@RequestMapping(value="/store/menu/edit",method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String menuedit(HttpServletRequest request, Menu menu) {
		menuService.updates(fileManager,menu);
		 
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"메뉴가 수정되었습니다.\"");
		sb.append("}");
		System.out.println(fileManager.getSaveMemberDir());
		
	 
 
		return sb.toString();
		
	}
	
	@RequestMapping(value="/store/menu/del",method = RequestMethod.GET, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String menudel(HttpServletRequest request, int menu_id) {
		menuService.delete(fileManager,menu_id);
		 
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"메뉴가 삭제되었습니다.\"");
		sb.append("}");
		System.out.println(fileManager.getSaveMemberDir());
		
	 
 
		return sb.toString();
		
	}
	
	
}
