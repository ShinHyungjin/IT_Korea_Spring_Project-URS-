package com.sbj.urs.aop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.exceptoion.CheckIdException;
import com.sbj.urs.exceptoion.CheckIdforPwException;
import com.sbj.urs.exceptoion.CheckPwException;
import com.sbj.urs.exceptoion.LoginAsyncRequiredException;
import com.sbj.urs.exceptoion.LoginRequiredException;
import com.sbj.urs.exceptoion.MemberNotFoundException;
import com.sbj.urs.model.domain.MessageData;
import com.sbj.urs.model.product.service.CategoryService;



/*
 * 모든 컨트롤러마다 일일이 예외처리 핸들러를 작성하면 코드 중복이 발생하므로,
 * 컨트롤러에서 발생하는 모든 예외를 감지하는 객체를 정의하여, 공통 예외처ㅣ를 작성하자!
 * */
@ControllerAdvice
public class GlobalExceptionHandler {
	
	@Autowired
	CategoryService categoryService;
	
	@ExceptionHandler(LoginRequiredException.class)
	public ModelAndView handlException(LoginRequiredException e) {
		ModelAndView mav = new ModelAndView();
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData",messageData);
		mav.setViewName("shop/error/message");
		
		return mav;
	}
	
	@ExceptionHandler(LoginAsyncRequiredException.class)
	@ResponseBody
	public MessageData handlException(LoginAsyncRequiredException e) {
	 
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
 
		return messageData;
	}
	
	@ExceptionHandler(CheckPwException.class)
	@ResponseBody
	public String handleException(CheckPwException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":0, ");
		sb.append(" \"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		
		return sb.toString();
	}
	
	@ExceptionHandler(MemberNotFoundException.class)
	public ModelAndView handleException(MemberNotFoundException e) {
		ModelAndView mav = new ModelAndView();
		List topList = categoryService.selectAll();
		mav.addObject("categoryList",topList);
		mav.addObject("msg", e.getMessage()); //사용자가 보게될 메시지 
		mav.setViewName("shop/error/result");
		 
		return mav;
	}
	
	//멤버 중복 예외처리
	@ExceptionHandler(CheckIdException.class)
	@ResponseBody
	public int handlerException(CheckIdException e) {
		
		return 0;
	}
	
	@ExceptionHandler(CheckIdforPwException.class)
	public ModelAndView handlException(CheckIdforPwException e) {
		ModelAndView mav = new ModelAndView();
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData",messageData);
		mav.setViewName("shop/error/message");
		
		return mav;
	}
}
