package com.sbj.urs.model.reservation.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.exceptoion.ReservationDeleteException;
import com.sbj.urs.model.domain.Reservation;

@Repository
public class MybatisReservationDAO implements ReservationDAO{
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   @Override
   public List selectAll() {
      return sqlSessionTemplate.selectList("Reservation.selectAll");
   }

   @Override
   public void delete(int receipt_id) throws ReservationDeleteException{
      int result = sqlSessionTemplate.delete("Reservation.delete", receipt_id);
      if(result == 0 ) { 
         throw new ReservationDeleteException("예약 정보 삭제 실패!");
      }
   }

   @Override
   public List selectAllById(int receipt_id) {
      return sqlSessionTemplate.selectList("Reservation.selectAllById", receipt_id);
   }
   
   @Override
   public int insert(Reservation reservation) {
      return sqlSessionTemplate.insert("Reservation.insert", reservation);
      
   }

}