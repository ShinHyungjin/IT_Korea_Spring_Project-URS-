package com.sbj.urs.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.store.service.StoreService;


/*
 * 쇼핑몰 이용시 전반적으로  
 * */
public class GlobalDataAspect {
	@Autowired
	private CategoryService categoryService;
	   @Autowired
	   private StoreService storeService;
	   
 
	
	public Object getGlobalData(ProceedingJoinPoint joinPoint) throws Throwable {
		Object result = null;
		HttpServletRequest request=null;

		//매개변수로부터 요청객체 추출!!
		for(Object arg : joinPoint.getArgs()) {
			if(arg instanceof HttpServletRequest) {
				request = (HttpServletRequest)arg;
			}
		}
		
		String uri = request.getRequestURI(); //클라이언트의 요청 URI 스트링 정보
		System.out.println(uri);
		//topList를 저장해야 하는 경우와 그렇지 않은 경우를 나누어서 처리
		if(	
			uri.equals("/shop/member/loginout")||
			uri.equals("/shop/member/login")||
			uri.equals("/shop/member/regist")||
			uri.equals("/shop/member/update")||
			uri.equals("/shop/member/checkId")||
			uri.equals("/shop/member/editstore")||
			uri.equals("/shop/member/sendpassword")
		) {
			result=joinPoint.proceed(); //원래 호출하려 했던 메서드 호출!! go ahead
		}else {//필요한 경우
			//카테고리 가져오기
			List categoryList = categoryService.selectAll();
			List storeList = storeService.selectAll();
			Object returnObj = joinPoint.proceed();//원래 호출하려 했던 메서드호출
			ModelAndView mav = null;
			if( returnObj instanceof ModelAndView) {
				mav =(ModelAndView)returnObj;
				mav.addObject("categoryList",categoryList);
				mav.addObject("storeList",storeList);
				result=mav;
			}
		}
		return result;
	}
}
