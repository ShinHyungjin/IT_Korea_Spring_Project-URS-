package com.sbj.urs.controller.table;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.SessionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbj.urs.exceptoion.LoginRequiredException;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.product.service.CategoryService;
import com.sbj.urs.model.store.service.StoreService;
import com.sbj.urs.model.store.service.TableMapService;


@Controller
public class AdminTableController {
   @Autowired
   private TableMapService tableMapService;   
   
   @Autowired
   private StoreService storeService;
   
   @Autowired
   private CategoryService categoryService;
   
   @RequestMapping(value = "/table", method = RequestMethod.POST)
   public ModelAndView getTableMap(HttpServletRequest request,String store_id, String resultArr) {     
     HttpSession session = request.getSession();
     Member sessionmember = (Member) session.getAttribute("member");
     if(sessionmember==null) {
       throw new LoginRequiredException("로그인을 해주세요."); 
     }
     
     int member_id = sessionmember.getMember_id();
     Store store = storeService.selectById(Integer.parseInt(store_id));//member_id아닌지 확인하기 나중에
     if(member_id==store.getMember_id()) {
        throw new LoginRequiredException("본인의 점포입니다. 관리자 모드를 이용해주세요."); 
     }
      //jsp에 뿌려질 map Array --- ex) "mmmmmmmm")
      TableMap tableMap = new TableMap();  //나중에 세션으로 회원정보 얻어오는걸로 대체할 것      
      tableMap.setStore_id(store.getStore_id());//세션의 회원ID으로 대체할 것      
      tableMap = tableMapService.selectById(tableMap.getStore_id());     
      //String mapValue = tableMap.getMapindex();// ex) "mmmmmmmmmm"
      //System.out.println(tableMap.getUnavailable());
      List categoryList = categoryService.selectAll();//top용도
      
      ModelAndView mav = new ModelAndView();
      System.out.print(store_id);
      System.out.print(tableMap);
      mav.addObject("tableMap",tableMap);
      mav.addObject("store_id",store_id);
      mav.addObject("resultArr",resultArr);
      mav.addObject("categoryList",categoryList);
      mav.setViewName("/table/tablemap");
      return mav;
   }
   
   @RequestMapping(value = "/store/table", method = RequestMethod.GET)
   public ModelAndView getAdminTable(HttpServletRequest request){     
     HttpSession session = request.getSession();
     Member sessionmember = (Member)session.getAttribute("member");
     int member_id = sessionmember.getMember_id();
     Store store = storeService.selectByMemberId(member_id);
     String store_id = Integer.toString(store.getStore_id());
     String resultArr="test";
      //jsp에 뿌려질 map Array --- ex) "mmmmmmmm")
      TableMap tableMap = new TableMap();      
      tableMap.setStore_id(store.getStore_id());//세션의 회원ID으로 대체할 것      
      tableMap = tableMapService.selectById(tableMap.getStore_id());     
      
      List categoryList = categoryService.selectAll();//top용도
      
      ModelAndView mav = new ModelAndView();      
      System.out.print(tableMap);
      System.out.print("점포관리store_id"+store_id);
      mav.addObject("tableMap",tableMap);
      mav.addObject("store_id",store_id);
      mav.addObject("resultArr",resultArr);
      mav.addObject("categoryList",categoryList);
      mav.setViewName("/table/tablemap");
      return mav;
   }
   
   @RequestMapping(value="/admin/table/batch", method=RequestMethod.POST)
   @ResponseBody
   public Object getTableUpdate(HttpServletRequest request,
         @RequestParam(value="arrmap[]") List<String> arrmap,         
         @RequestParam(value="unavailmap[]", defaultValue="0_0") List<String> unavailmap){
     HttpSession session = request.getSession();
     Member sessionmember = (Member) session.getAttribute("member");
     int member_id = sessionmember.getMember_id(); //member_id     
     Store store = storeService.selectByMemberId(member_id);
     
      String str = ""; //update위해 arrmap을 이어 담을 String
      String str2 = ""; //update위해 unavailmap을 이어 담을 String
      for(String a : arrmap) {
            str += a;
        }  
      
      //변경된 테이블 update
      TableMap tableMap = new TableMap();
      tableMap.setStore_id(store.getStore_id());//접속한 회원의 store_id로 select
      tableMap.setMap_index(str);
      
      if(!unavailmap.get(0).equals("0_0")) { //처음 테이블 배치때는 예약된 좌석이 없기 때문에 Error발생--> 조건문으로 처리
         for(int i=0; i<unavailmap.size(); i++) {        
               str2 += unavailmap.get(i);
               if(i!=unavailmap.size()-1) str2 +=",";
           }                  
         tableMap.setUnavailable(str2);
      }else {
         tableMap.setUnavailable(unavailmap.get(0));
      }
      System.out.println("tablemap:"+str2);
      System.out.println("가게아디는?:"+store.getStore_id());
      
      int result =tableMapService.update(tableMap); // update위해 ajax로 받은 Array로 update
                        
      Map<String, Object> retVal = new HashMap<String, Object>();
      retVal.put("code", "OK");
      retVal.put("tableMap", str);
      retVal.put("unavailMap", str2);
      
      
      return retVal;
   }
      
}