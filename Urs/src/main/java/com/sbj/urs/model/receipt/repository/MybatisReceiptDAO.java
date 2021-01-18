package com.sbj.urs.model.receipt.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.exceptoion.ReceiptDeleteException;
import com.sbj.urs.exceptoion.ReceiptRegistException;
import com.sbj.urs.model.domain.Receipt;

@Repository
public class MybatisReceiptDAO implements ReceiptDAO {
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   @Override
   public void insert(Receipt receipt) throws ReceiptRegistException {
      int result = sqlSessionTemplate.insert("Receipt.insert", receipt);
      if(result==0) {
         throw new ReceiptRegistException("결제 등록 실패");
      }
      
   } 
   
   @Override
   public List selectAll() {
      return sqlSessionTemplate.selectList("Receipt.selectAll");
   }

   @Override
   public void delete(int receipt_id) throws ReceiptDeleteException{
      int result = sqlSessionTemplate.delete("Receipt.delete", receipt_id);
      if(result == 0) {
         throw new ReceiptDeleteException("영수증 삭제 실패!");
      }
   }

   @Override
   public Receipt select(int receipt_id) {
      return sqlSessionTemplate.selectOne("Receipt.select", receipt_id);
   }
   
   @Override
   public List selectByStoreId(int store_id) {
      return sqlSessionTemplate.selectList("Receipt.selectByStoreId",store_id);
   }

@Override
public List selectByMemberId(int member_id) {
	return sqlSessionTemplate.selectList("Receipt.selectByMemberId", member_id);
}

}