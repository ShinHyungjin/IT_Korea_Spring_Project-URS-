package com.sbj.urs.controller.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
public class AdminController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private TableMapService tableMapService;
	@Autowired
	private ReceiptService receiptService;
	@Autowired
	private ReservationService reservationService;

	@Autowired
	private FileManager fileManager;

	// home 화면에서 가게 이름 클릭시 이동하는 Store Detail 페이지
	@RequestMapping(value = "/admin/store/storedetail", method = RequestMethod.GET)
	public ModelAndView getStoreDetail(HttpServletRequest request, int store_id) {
		Store store = storeService.selectById(store_id);

		ModelAndView mav = new ModelAndView("admin/store/store_detail");
		mav.addObject("store", store);

		return mav;
	}

	// 메뉴리스트 화면에서 메뉴이름 클릭시 이동하는 Menu Detail 페이지
	@RequestMapping(value = "/admin/store/menudetail", method = RequestMethod.GET)
	public ModelAndView getMenuDetail(HttpServletRequest request, int menu_id) {
		Menu menu = menuService.select(menu_id);
		ModelAndView mav = new ModelAndView("admin/store/menu_detail");
		mav.addObject("menu", menu);

		return mav;
	}

	// 고객리스트 화면에서 고객이름 클릭시 이동하는 Member Detail 페이지
	@RequestMapping(value = "/admin/memberdetail", method = RequestMethod.GET)
	public ModelAndView getMemberDetail(HttpServletRequest request, int member_id) {
		Member member = memberService.selectOne(member_id);
		ModelAndView mav = new ModelAndView("admin/member/member_detail");
		mav.addObject("member", member);

		return mav;
	}

	// 결제리스트 화면에서 결제번호 클릭시 이동하는 Payment Detail 페이지
	@RequestMapping(value = "/admin/payment/paymentdetail", method = RequestMethod.GET)
	public ModelAndView getPaymentDetail(HttpServletRequest request, int receipt_id) {
		Receipt receipt = receiptService.select(receipt_id);
		Member member = memberService.selectOne(receipt.getMember_id());
		Store store = storeService.selectById(receipt.getStore_id());
		List<Reservation> reservationList = reservationService.selectAllById(receipt_id);
		List<Menu> menuList = new ArrayList<Menu>();
		for (int i = 0; i < reservationList.size(); i++) {
			Menu menu = menuService.select(reservationList.get(i).getMenu_id());
			menuList.add(menu);
		}
		ModelAndView mav = new ModelAndView("admin/payment/payment_detail");
		mav.addObject("receipt", receipt);
		mav.addObject("member", member);
		mav.addObject("store", store);
		mav.addObject("menuList", menuList);

		return mav;
	}

	// 관리자가 왼쪽의 카테고리 클릭 시 비동기로 해당 Category의 Store를 얻어와서 화면에 보여줌
	@RequestMapping(value = "/admin/store", method = RequestMethod.GET)
	@ResponseBody
	public List getStore(HttpServletRequest request, int category_id) {
		List<Store> storeList = storeService.selectAllById(category_id);
		return storeList;
	}

	// admin의 home 화면 (매장관리)
	@GetMapping("/admin")
	public ModelAndView admin(HttpServletRequest request) {
		List categoryList = categoryService.selectAll();
		List storeList = storeService.selectAll();
		ModelAndView mav = new ModelAndView("admin/index");
		mav.addObject("categoryList", categoryList);
		mav.addObject("storeList", storeList);

		return mav;
	}

	// 매장관리에서 메뉴 관리 클릭시 이동하는 Menu Detail 페이지
	@RequestMapping(value = "/admin/store/menulist", method = RequestMethod.GET)
	public ModelAndView getMenuList(HttpServletRequest request, int store_id) {
		List<Menu> menuList = menuService.selectById(store_id);

		ModelAndView mav = new ModelAndView("admin/store/menu_list");
		mav.addObject("menuList", menuList);

		return mav;
	}

	// navi의 고객관리 클릭시 이동하는 Member 페이지
	@RequestMapping("/admin/member/memberlist")
	public ModelAndView getMemberList(HttpServletRequest request) {
		List<Member> memberList = memberService.selectAll();

		ModelAndView mav = new ModelAndView("admin/member/member_list");
		mav.addObject("memberList", memberList);

		return mav;
	}

	// navi의 결제관리 클릭시 이동하는 paymentList 페이지
	@RequestMapping("/admin/payment/paymentlist")
	public ModelAndView getPaymentList(HttpServletRequest request) {
		List<Receipt> receiptList = receiptService.selectAll();
		List<Reservation> reservationList = reservationService.selectAll();
		List<Member> memberList = new ArrayList<Member>();
		List<Store> storeList = new ArrayList<Store>();
		for (int i = 0; i < receiptList.size(); i++) {
			Member member = memberService.selectOne(receiptList.get(i).getMember_id());
			memberList.add(member);
			Store store = storeService.selectById(receiptList.get(i).getStore_id());
			storeList.add(store);
		}
		ModelAndView mav = new ModelAndView("admin/payment/payment_list");
		mav.addObject("receiptList", receiptList);
		mav.addObject("reservationList", reservationList);
		mav.addObject("memberList", memberList);
		mav.addObject("storeList", storeList);

		return mav;
	}

// 관리자가 매장관리에서 수정하기 버튼을 클릭하면 DB로 데이터가 넘어가고, RepImgae 에 아무것도 안넣으면 이전 이미지를, 넣으면
	// 이전이미지를 삭제하고 새로운 이미지 등록
	@RequestMapping(value = "/admin/store/storeupdate", method = RequestMethod.POST)
	public String updateStore(HttpServletRequest request, Store store) {
		System.out.println("store_pass : " + store.getStore_pass());
		// 수정시 대표이미지가 변경사항이 없다 = Null = 기존 이미지를 쓰겟다
		if (store.getStore_repimg().length() == 0) {
			String repimg = storeService.selectByRepImage(store.getStore_id());
			store.setStore_repimg(repimg);
		}
		// 수정시 로고이미지가 변경사항이 없다 = Null = 기존 이미지를 쓰겠다
		if (store.getStore_image().length() == 0) {
			String image = storeService.selectByImage(store.getStore_id());
			store.setStore_image(image);
		}
		// 수정시 승인처리가 완료됬다 = Pass=TRUE = 포지션은 Store로 승격
		// 단, TableMap은 이미 있다면 생성하지 않음
		if (store.getStore_pass().equals("TRUE")) {
			Member member = memberService.selectOne(store.getMember_id());
			member.setUser_position("store");
			memberService.updateByPosition(member);
			if (tableMapService.selectById(store.getStore_id()) == null) {
				tableMapService.insert(store.getStore_id());
			}
		} else if (store.getStore_pass().equals("FALSE")) {
			Member member = memberService.selectOne(store.getMember_id());
			member.setUser_position("user");
			memberService.updateByPosition(member);
		}
		storeService.update(store);
		return "redirect:/admin";
	}

	// 관리자가 메뉴관리에서 수정하기 버튼을 클릭하면 DB로 데이터가 넘어가고, Image 에 아무것도 안넣으면 이전 이미지를, 넣으면
	// 이전이미지를 삭제하고 새로운 이미지 등록
	@RequestMapping(value = "/admin/store/menuupdate", method = RequestMethod.POST)
	public String updateMenu(HttpServletRequest request, Menu menu) {
		if (menu.getMenu_image().length() == 0) {
			String image = menuService.selectByImage(menu.getMenu_id());
			menu.setMenu_image(image);
		}
		Menu menu2 = menuService.select(menu.getMenu_id());

		menuService.update(menu);
		return "redirect:/admin/store/menulist?store_id=" + menu2.getStore_id();
	}

	// 관리자가 메뉴관리에서 수정하기 버튼을 클릭하면 DB로 데이터가 넘어가고, Image 에 아무것도 안넣으면 이전 이미지를, 넣으면
	// 이전이미지를 삭제하고 새로운 이미지 등록
	@RequestMapping(value = "/admin/store/memberupdate", method = RequestMethod.POST)
	public String updateMember(HttpServletRequest request, Member member) {
		if (member.getUser_image().length() == 0) {
			String image = memberService.selectByImage(member.getMember_id());
			member.setUser_image(image);
		}
		return "redirect:/admin/member/memberlist";
	}

	//관리자의 member 수정 기능
	@RequestMapping(value = "/admin/member/memberupdate", method = RequestMethod.POST)
	public ModelAndView updateMemberDetail(HttpServletRequest request, Member member) {
		System.out.println("member_id : " + member.getMember_id());
		System.out.println("member_name : " + member.getUser_name());
		
		memberService.updateToAdmin(member);
		List <Member> memberList = memberService.selectAll();
		ModelAndView mav = new ModelAndView("admin/member/member_list");
		mav.addObject("memberList", memberList);
		
		return mav;
	}

	// 관리자가 삭제하기 버튼 클릭하면 해당 점포의 정보가 DB에서 삭제되고 비동기로 이루어짐
	@RequestMapping(value = "/admin/store/storedelete", method = RequestMethod.GET)
	@ResponseBody
	public List deleteStore(HttpServletRequest request, int store_id) {
		List<Receipt> receiptsList = receiptService.selectByStoreId(store_id);
		for (int i = 0; i < receiptsList.size(); i++) {
			reservationService.delete(receiptsList.get(i).getReceipt_id());
			receiptService.delete(receiptsList.get(i).getReceipt_id());
		}

		menuService.deleteById(store_id);
		tableMapService.deleteById(store_id);
		
		
		Member member = memberService.selectOne(storeService.selectById(store_id).getMember_id());
		member.setUser_position("user");
		memberService.updateByPosition(member);

		storeService.delete(store_id);
		List<Store> storeList = storeService.selectAll();
		return storeList;
	}

	// 메뉴를 삭제하면 해당 메뉴만 삭제되고 다시 menuList를 얻어옴
	@RequestMapping(value = "/admin/store/menudelete", method = RequestMethod.GET)
	@ResponseBody
	public List deleteMenu(HttpServletRequest request, int menu_id) {
		Menu menu = menuService.select(menu_id);
		menuService.delete(fileManager, menu_id);
		List<Menu> menuList = menuService.selectById(menu.getStore_id());
		return menuList;
	}

	// 메뉴를 삭제하면 해당 메뉴만 삭제되고 다시 menuList를 얻어옴
	@RequestMapping(value = "/admin/store/memberdelete", method = RequestMethod.GET)
	@ResponseBody
	public List deleteMember(HttpServletRequest request, int member_id) {
		Member member = memberService.selectOne(member_id);

		List<Receipt> receiptList = receiptService.selectAll();
		for (int i = 0; i < receiptList.size(); i++) {
			if (receiptList.get(i).getMember_id() == member.getMember_id()) {
				List<Reservation> reservationsList = reservationService
						.selectAllById(receiptList.get(i).getReceipt_id());
				for (int j = 0; j < reservationsList.size(); j++) {
					reservationService.delete(receiptList.get(i).getReceipt_id());
				}
				receiptService.delete(receiptList.get(i).getReceipt_id());
			}
		}

		// 삭제하려는 멤버의 포지션이 Store면 제약조건에 의거하여 1.해당 store의 메뉴를 삭제 -> 2. store 삭제 -> 3.
		// member 삭제
		System.out.println("member_id : " + member.getMember_id());
		if (member.getUser_position().equals("store")) {
			Store store = storeService.selectByMemberId(member_id);

			menuService.deleteById(store.getStore_id());
			storeService.delete(store.getStore_id());
		}
		memberService.delete(member_id);
		List<Member> memberList = memberService.selectAll();
		return memberList;
	}

	 @RequestMapping(value = "/admin/payment/paymentdelete", method = RequestMethod.GET)
	   @ResponseBody
	   public List deletePayment(HttpServletRequest request,int receipt_id) {
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

	// 관리자가 PaymentDetail에서 삭제하기 버튼을 클릭시 비동기가 아닌 동기삭제 및 페이지 전환이 이루어지는 기능
	@RequestMapping(value = "/admin/payment/paymentdetaildelete", method = RequestMethod.POST)
	public ModelAndView detaildeletePayment(HttpServletRequest request, int receipt_id) {
		ModelAndView mav = new ModelAndView("admin/payment/payment_list");
		reservationService.delete(receipt_id);
		receiptService.delete(receipt_id);
		List<Receipt> receiptList = receiptService.selectAll();
		List<Reservation> reservationList = reservationService.selectAll();
		List<Member> memberList = new ArrayList<Member>();
		List<Store> storeList = new ArrayList<Store>();
		for (int i = 0; i < receiptList.size(); i++) {
			Member member = memberService.selectOne(receiptList.get(i).getMember_id());
			memberList.add(member);
			Store store = storeService.selectById(receiptList.get(i).getStore_id());
			storeList.add(store);
			System.out.println("receiptList size : " + receiptList.size() + "\t receipt_id : "
					+ receiptList.get(i).getReceipt_id());
			System.out.println(
					"memberList size : " + memberList.size() + "\t user_name : " + memberList.get(i).getUser_name());
			System.out.println(
					"storeList size : " + storeList.size() + "\t store_name : " + storeList.get(i).getStore_name());
		}
		mav.addObject("receiptList", receiptList);
		mav.addObject("reservationList", reservationList);
		mav.addObject("memberList", memberList);
		mav.addObject("storeList", storeList);

		return mav;
	}

	// 메뉴리스트에서 메뉴등록 버튼을 클릭하면 나타날 페이지
	@RequestMapping(value = "/admin/store/menuregistForm", method = RequestMethod.GET)
	public String menuRegistForm(HttpServletRequest request, int store_id) {
		return "redirect:/admin/store/menu_registform";
	}

}