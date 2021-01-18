package com.sbj.urs.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;

import com.sbj.urs.exceptoion.LoginRequiredException;
import com.sbj.urs.model.domain.Member;





/*
 * 앞으로 로그인 필요한 서비스 여부를 처리하기 위한 코드는 컨트롤러에 두지않고
 * 지금 이 객체로 공통화 시켜 AOP 를 적용하겠다..
 * 
 * */
public class AdminSessionCheckAspect {

	
	public Object sessionCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		Object target = joinPoint.getTarget(); //원래 호출하려고 했던 객체
		System.out.println(target);
		String methodName = joinPoint.getSignature().getName();
		System.out.println("원래 호출할려했던 메서드는" + methodName);
		Object[] args = joinPoint.getArgs(); //원래 호출하려 했던 메서드의 매개변수
		//request 객체 생성
		//세션을 얻기위해서는 HttpServletRequest 가 필요하다
		HttpServletRequest request = null;
		for (Object arg: args) {
			System.out.println("매개 변수명은 : " + arg);
			if(arg instanceof HttpServletRequest) { //request객체라면...
				request = (HttpServletRequest)arg;
			}
		}
		//현재의 요청이 세션을 가지고 있는지를 판단하여 적절한 제어..
		
		//1.세션이 없다면? 예외를 발생시킬것임 -> ExceptionHandler 를 거쳐서 클라이언트에게 적절한 응답처리..
		//2.세션이 있다면?  그대로 원래 호출하려 했던 메서드를 진행시켜주자
		//세션 생성
		HttpSession session = null;
		session = request.getSession();
		Object result = null;
		if(session.getAttribute("member") != null) {
			if(((Member)session.getAttribute("member")).getUser_position().equals("admin")) {
			//원래 요청의 흐름을 그대로 진행..
			result = joinPoint.proceed(); //여기서 예외가 발생하므로 예외처리하지말고 그냥 throw 를 실행!
			}else {
				throw new LoginRequiredException("관리자 권한이 없습니다."); 
			}
		}else { 
			throw new LoginRequiredException("로그인이 필요한 서비스입니다"); 
		}
		

		return result;
	}
}
