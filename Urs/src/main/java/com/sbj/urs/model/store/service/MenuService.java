package com.sbj.urs.model.store.service;

import java.util.List;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Menu;

public interface MenuService {
   public List selectAll(); //모든 메뉴 불러오기 
   public List selectById(int store_id); // 점포아이디로 메뉴 불러오기 
   public String selectByImage(int menu_id); // 메뉴 id로 메뉴 이미지 불러오기
   public Menu select(int menu_id); // 메뉴ID로 메뉴 불러오기
   public void insert(FileManager fileManager,Menu menu); //메뉴 생성 
   public void update(Menu menu); // 메뉴수정 
   public void updates(FileManager fileManager,Menu menu); // 메뉴수정 
   public void delete(FileManager fileManager,int menu_id); //메뉴삭제 
   public void deleteById(int store_id); // 점포가 삭제되면 제약조건을 위해 같이 삭제되는 기능
   public int countMenu(); //메뉴 갯수 가져오기 
}