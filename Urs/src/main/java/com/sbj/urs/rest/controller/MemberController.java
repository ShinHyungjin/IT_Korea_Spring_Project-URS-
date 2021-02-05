package com.sbj.urs.rest.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.sbj.urs.model.domain.Category;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.member.service.MemberService;
import com.sbj.urs.model.product.service.CategoryService;

@RestController
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private CategoryService categoryService;
	
	// 로그인 요청 처리
	@PostMapping("/member")
	public int login(@RequestBody Member member) {
		System.out.println(member.getUser_id());
		System.out.println(member.getUser_password());
		// db에 존재여부 확인
		Member obj = memberService.select(member);
			
		int member_id = (int)obj.getMember_id();
		return member_id;
	}
	
	@GetMapping("/category")
	public List<Category> getList(){
		List<Category> categoryList = categoryService.selectAll();
		
		return categoryList;
	}

}
