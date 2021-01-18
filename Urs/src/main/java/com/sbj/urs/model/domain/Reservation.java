package com.sbj.urs.model.domain;

import lombok.Data;

@Data
public class Reservation {
   private int reservation_id;
   private int menu_id;   
   private int receipt_id;
}