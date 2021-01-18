package com.sbj.urs.controller.menu;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.store.service.MenuService;



@Controller
public class MenuController {
   @Autowired
   private static final Logger logger = LoggerFactory.getLogger(MenuController.class);    
   @Autowired
   private MenuService menuService;
      
   @RequestMapping(value="/shop/store/category/menu", method=RequestMethod.GET)
   public ModelAndView main(HttpServletRequest request, int store_id) {
      logger.debug("store_id:"+store_id);
      List<Menu> menuList = menuService.selectById(store_id); //지정된 store의 메뉴리스트 가져오기
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("menuList",menuList);
      mav.setViewName("shop/shopmenu/menu"); //메인 페이지
      return mav;
   }
}