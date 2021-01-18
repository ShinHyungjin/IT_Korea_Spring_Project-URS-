package com.sbj.urs.controller.main;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.domain.Category;
import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.member.service.MemberService;
import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.StoreService;


@Controller
public class MainController {
   @Autowired
   private MenuService menuService;
   @Autowired
   private StoreService storeService;
   @Autowired
   private CategoryService categoryService;
   @Autowired
   private MemberService memberService;

   

   @RequestMapping(value = "/", method = RequestMethod.GET)
   public ModelAndView home(HttpServletRequest request) {
      List<Menu> menuList = menuService.selectAll();
      int countMem = memberService.countMember();
      int countMenu = menuService.countMenu();
      int countStore = storeService.countStore();
      ModelAndView mav = new ModelAndView("index");
      mav.addObject("menuList", menuList);
      mav.addObject("countMem",countMem);
      mav.addObject("countMenu",countMenu);
      mav.addObject("countStore",countStore);
      return mav;
   }
   
	@GetMapping("/shop/store/category")
	public ModelAndView viewstore(int category_id,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("shop/store/store_list");
		List<Store> storeList2 = storeService.selectAllById(category_id);
		Category categoryname = categoryService.select(category_id);
		mav.addObject("storeList2", storeList2);
		mav.addObject("categoryDetail",categoryname);
		
		return mav;
	}
}