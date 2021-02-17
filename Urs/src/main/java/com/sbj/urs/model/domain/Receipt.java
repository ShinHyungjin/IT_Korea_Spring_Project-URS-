package com.sbj.urs.model.domain;

import lombok.Data;

@Data
public class Receipt {
   private int receipt_id;
   private int member_id;
   private int store_id;
   private String receipt_regdate;
   private int receipt_totalamount;
   private int menu_quantity;
   private String reservation_table;
   private String bootpay_id;
}