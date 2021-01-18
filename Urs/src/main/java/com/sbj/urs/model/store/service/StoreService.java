package com.sbj.urs.model.store.service;

import java.util.List;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Store;

public interface StoreService {
   public List selectAll(); //모든 스토어 불러오기 
   public List selectAllById(int category_id); //카테고리별로 점포 불러오기 
   public Store selectById(int store_id); // 스토어아이디로 스토어 불러오기 
   public Store selectByMemberId(int member_id); //멤버 아이디로 점포 가져오기  
   public String selectByRepImage(int store_id); // 점포아이디로 대표이미지 불러오기
   public String selectByImage(int store_id); // 점포아이디로 이미지 불러오기
   public void insert(FileManager fileManager, Store store); // 점포 추가
   public void update(Store store); // 점포 수정
   public void updatePic(FileManager fileManager,Store store); //점포 수정 및 사진 
   public void delete(int store_id); // 점포 삭제 
   public int countStore(); //점포 갯수 가져오기
}