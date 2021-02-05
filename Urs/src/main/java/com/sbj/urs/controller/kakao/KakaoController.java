package com.sbj.urs.controller.kakao;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.kakao.service.KakaoPay;

import lombok.Setter;
import lombok.extern.java.Log;
 
@Log
@Controller
public class KakaoController {
	HttpServletRequest request;
	String store_id;
	int receipt_totalamount; 
	int menu_quantity;
	String unavailable; 
	String reservation_table;
	String menu_ids;
	
    @Autowired
    private KakaoPay kakaopay;
    
    
    @GetMapping("/kakaoPay")
    public void kakaoPayGet() {
        
    }
    
    @PostMapping("/kakaoPay")
    public String kakaoPay(HttpServletRequest request, String store_id, int receipt_totalamount, int menu_quantity, String unavailable, String reservation_table, String menu_ids) {
        log.info("kakaoPay post............................................");
        this.request = request;
        this.store_id = store_id;
        this.receipt_totalamount = receipt_totalamount;
        this.menu_quantity = menu_quantity;
        this.unavailable = unavailable;
        this.reservation_table = reservation_table;
        this.menu_ids = menu_ids;
        
        return "redirect:" + kakaopay.kakaoPayReady();
    }
    
    @GetMapping("/kakaoPaySuccess")
    public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
    	ModelAndView mav = new ModelAndView("redirect:/customer/reservation");
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);
        
        model.addAttribute("info", kakaopay.kakaoPayInfo(pg_token));
        
        mav.addObject("request",request);
        mav.addObject("store_id",store_id);
        mav.addObject("receipt_totalamount",receipt_totalamount);
        mav.addObject("menu_quantity",menu_quantity);
        mav.addObject("unavailable",unavailable);
        mav.addObject("reservation_table",reservation_table);
        mav.addObject("menu_ids",menu_ids);
        
        return mav;
    }
    
}
 