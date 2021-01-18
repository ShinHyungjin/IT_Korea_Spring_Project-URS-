package com.sbj.urs.model.reservation.repository;

import java.util.List;

import com.sbj.urs.model.domain.Reservation;


public interface ReservationDAO {
   public List selectAll(); // 모든 결제 조회
   public List selectAllById(int receipt_id); // 1:多 관계인 영수증 : 예약
   public void delete(int receipt_id); // 관리자가 영수증을 삭제하면 먼저 예약이 삭제되어야 한다
   public int insert(Reservation reservation);
}