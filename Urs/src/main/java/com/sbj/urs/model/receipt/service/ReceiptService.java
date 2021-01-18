package com.sbj.urs.model.receipt.service;

import java.util.List;

import com.sbj.urs.model.domain.Receipt;

public interface ReceiptService {   
   public void insert(Receipt receipt);
   public List selectAll(); // 모든 영수증 리스트 구하기
   public Receipt select(int receipt_id); // 해당 결제 1건 찾기
   public void delete(int receipt_id); // 영수증 정보를 지우려면 Reservation 정보도 지워야한다.. 
   public List selectByStoreId(int store_id); // 점포 주인이 자신 점포에 대한 결제정보만을 요청하기 위한 기능
   public List selectByMemberId(int member_id); // 고객이 자신의 결제정보만을 요청하기 위한 기능
} 