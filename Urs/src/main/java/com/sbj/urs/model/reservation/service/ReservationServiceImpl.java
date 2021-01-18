package com.sbj.urs.model.reservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.exceptoion.ReservationDeleteException;
import com.sbj.urs.model.domain.Reservation;
import com.sbj.urs.model.reservation.repository.ReservationDAO;

@Service
public class ReservationServiceImpl implements ReservationService{
   @Autowired
   private ReservationDAO reservationDAO;

   @Override
   public List selectAll() {
      return reservationDAO.selectAll();
   }

   @Override
   public void delete(int receipt_id) throws ReservationDeleteException{
      reservationDAO.delete(receipt_id);
   }

   @Override
   public List selectAllById(int receipt_id) {
      return reservationDAO.selectAllById(receipt_id);
   }
   
   @Override
   public int insert(Reservation reservation) { 
      return reservationDAO.insert(reservation);
   }
 
}