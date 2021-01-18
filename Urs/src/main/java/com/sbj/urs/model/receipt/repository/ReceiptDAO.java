package com.sbj.urs.model.receipt.repository;

import java.util.List;

import com.sbj.urs.model.domain.Receipt;

public interface ReceiptDAO {   
   public void insert(Receipt receipt);
   public List selectAll(); // 모든 결제 리스트 구하기
   public Receipt select(int receipt_id); // 해당 결제 1건 찾기
   public void delete(int receipt_id); // 영수증 삭제를 위해선 모든정보 필요
   public List selectByStoreId(int store_id); // 점포 주인이 자신 점포에 대한 결제정보만을 요청하기 위한 기능
   public List selectByMemberId(int member_id); // 고객이 자신의 결제정보만을 요청하기 위한 기능
}