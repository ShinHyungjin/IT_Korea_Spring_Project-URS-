package com.sbj.urs.exceptoion;

public class ReceiptRegistException extends RuntimeException{
   
   public ReceiptRegistException(String msg) {
      super(msg);
   }
   
   public ReceiptRegistException(String msg, Throwable e) {
      super(msg,e);
   }

}