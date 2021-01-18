package com.sbj.urs.controller.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.domain.MessageData;
import com.sbj.urs.model.domain.Receipt;
import com.sbj.urs.model.domain.Reservation;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.member.service.MemberService;
import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.receipt.service.ReceiptService;
import com.sbj.urs.model.reservation.service.ReservationService;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.StoreService;
import com.sbj.urs.model.store.service.TableMapService;

@Controller
public class MemberController implements ServletContextAware {
	@Autowired
	private FileManager fileManager;

	// servletContext 불러오기 절대 경로를 받기위해
	private ServletContext servletContext;
	@Autowired
	private MenuService menuService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private TableMapService tableMapService;
	@Autowired
	private ReceiptService receiptService;
	@Autowired
	private ReservationService reservationService;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		// 이 타이밍에 실제 물리적 경로를 가져온다
		fileManager.setSaveMemberDir(servletContext.getRealPath(fileManager.getSaveMemberDir()));
		fileManager.setSaveStoreDir(servletContext.getRealPath(fileManager.getSaveStoreDir()));
		fileManager.setSaveMenuDir(servletContext.getRealPath(fileManager.getSaveMenuDir()));
		// System.out.println(fileManager.getSaveMemberDir());
	}

	// 멤버 등록 페이지 요청
	@GetMapping("/shop/member/registForm")
	public ModelAndView regist(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("shop/member/signup");

		return mav;
	}

	// 멤버 로그인 페이지 요청
	@GetMapping("/shop/member/loginform")
	public ModelAndView loginform(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("shop/member/signin");
		return mav;
	}

	// 멤버 점포 등록 페이지 요청
	@GetMapping("/shop/member/storeregist")
	public ModelAndView storeregist(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member sessionmember = (Member) session.getAttribute("member");

		ModelAndView mav = new ModelAndView();

		Store store = storeService.selectByMemberId(sessionmember.getMember_id());

		if (store == null) {
			mav.setViewName("shop/member/storeregist");
		} else if (store.getStore_pass().equals("TRUE")) {
			mav.addObject("storeDetail", store);
			mav.setViewName("redirect:/store/manage");
		} else {
			mav.addObject("storeDetail", store);
			mav.setViewName("shop/member/storeregist");
		}

		return mav;
	}

	// 예약 리스트 요청
	@RequestMapping(value = "/shop/member/reservation", method = RequestMethod.GET)
	public ModelAndView reservationList(HttpServletRequest request) {
		 HttpSession session = request.getSession();
	     Member member = (Member) session.getAttribute("member");

		List<Receipt> receiptList = receiptService.selectByMemberId(member.getMember_id());
		List<List> reservationList = new ArrayList<List>();
		List<Menu> menuList = new ArrayList();
		ArrayList<Store> storereservationList = new ArrayList<Store>();
		for (int i = 0; i < receiptList.size(); i++) {
			Store store = storeService.selectById(receiptList.get(i).getStore_id());
			List<Reservation> reservation = reservationService.selectAllById(receiptList.get(i).getReceipt_id());
			for(int j=0; j < reservation.size(); j++) {
				Menu menu = menuService.select(reservation.get(j).getMenu_id());
				menuList.add(menu);
				System.out.println("reservation_id : " + reservation.get(j).getReservation_id()+"\tmenu_id : " + menuList.get(j).getMenu_id() + "\tmenu_name : " + menuList.get(j).getMenu_name() + "\tmenuList Size : " + menuList.size());
			}
			storereservationList.add(store);
			reservationList.add(reservation);
			System.out.println("store_id : " + storereservationList.get(i).getStore_id() + "\tstoreList Size : " + storereservationList.size());
		}
		
		System.out.println("ReceiptList size : " + receiptList.size());
		System.out.println("ReservationList size : " +reservationList.size());
		ModelAndView mav = new ModelAndView("shop/member/reservation_list");
		mav.addObject("receiptList", receiptList);
		mav.addObject("storereservationList", storereservationList);
		mav.addObject("reservationList", reservationList);
		mav.addObject("menuList", menuList);
		
		return mav;
	}

	// 로그아웃 요청 처리
	@RequestMapping(value = "/shop/member/loginout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().invalidate(); // 세션 무효화 이시점부터 담겨진 데이터가 다 무효가 된다
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("로그아웃 되었습니다");
		messageData.setUrl("/");
		ModelAndView mav = new ModelAndView("shop/error/message");
		mav.addObject("messageData", messageData);
		return mav;
	}

	// 멤버 마이페이지 요청
	@GetMapping("/shop/member/mypage")
	public ModelAndView mypage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member sessionmember = (Member) session.getAttribute("member");

		ModelAndView mav = new ModelAndView("shop/member/mypage");
		Member obj = memberService.selectOne(sessionmember.getMember_id());

		mav.addObject("memberDetail", obj);

		return mav;
	}

	// 로그인 요청 처리
	@RequestMapping(value = "/shop/member/login", method = RequestMethod.POST)
	public String login(Member member, HttpServletRequest request) {
		// db에 존재여부 확인
		Member obj = memberService.select(member);
		String url = "";
		// 존재 O : 세션에 회원정보 담아두기
		HttpSession session = request.getSession();
		session.setAttribute("member", obj); // 현재 클라이언트 요청과 연계된 세션에 보관해 놓는다

		if (obj.getUser_position().equals("admin")) {
			url = "redirect:/admin";
		} else {
			url = "redirect:/";
		}

		return url;
	}

	// 비밀번호찾기 요청처리
	@RequestMapping(value = "/shop/member/forgotpassword", method = RequestMethod.GET)
	public ModelAndView forgotpw(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("shop/member/forgotpassword");
		return mav;
	}

	// 계정 생성
	@RequestMapping(value = "/shop/member/regist", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String registMember(Member member, HttpServletRequest request) {
//		System.out.println("아이디" + member.getUser_id());
//		System.out.println("비밀번호" + member.getUser_password());
//		System.out.println("이름" + member.getUser_name());
//		System.out.println("핸드폰" + member.getUser_phone());
//		System.out.println("생일" + member.getUser_birthday());
//		System.out.println("성별" + member.getUser_gender());
//		System.out.println("이메일아이디" + member.getUser_email_id());
//		System.out.println("서버" + member.getUser_email_server());
//		
//		
//		System.out.println("주소" + member.getUser_location());
//	 
//	 
//		
//		System.out.println("이미지 이름 : " + member.getU_image().getOriginalFilename());

		memberService.insert(fileManager, member);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"가입을 축하드립니다.\"");
		sb.append("}");
		System.out.println(fileManager.getSaveMemberDir());

		return sb.toString();
	}

	@RequestMapping(value = "/shop/member/update", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String update(Member member, HttpServletRequest request) {

		memberService.update(fileManager, member);
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"정보가 수정 되었습니다.\"");
		sb.append("}");

		return sb.toString();
	}

	// 비밀번호찾기
	@PostMapping("/shop/member/sendpassword")
	public String sendpassword(String user_id, HttpServletRequest request) {
		System.out.println(user_id);
		memberService.resetpw(user_id);
		return "redirect:/";
	}

	@RequestMapping(value = "/shop/member/applystore", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	public ModelAndView applystore(Store store, HttpServletRequest request) {
		System.out.println(store.getStore_openhour());
		System.out.println(store.getStore_closehour());

		System.out.println(fileManager.getSaveStoreDir());
		storeService.insert(fileManager, store);

		ModelAndView mav = new ModelAndView("redirect:/");

		return mav;
	}

	@RequestMapping(value = "/shop/member/editstore", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	@ResponseBody
	public String editstore(Store store, HttpServletRequest request) {

		storeService.updatePic(fileManager, store);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1,");
		sb.append(" \"msg\": \"정보가 수정 되었습니다.\"");
		sb.append("}");

		return sb.toString();
	}

	// 멤버 중복 체크
	@PostMapping("/shop/member/checkId")
	@ResponseBody
	public int checkId(HttpServletRequest request) {

		String id = request.getParameter("user_id");
		int result = 0;
		if (id == "") {
			result = 2;
		} else {
			result = 1;
		}
		Member obj = memberService.checkId(id);

		return result;
	}

}