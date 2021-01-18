package com.sbj.urs.exceptoion;

public class ReceiptDeleteException extends RuntimeException{
	
	public ReceiptDeleteException(String msg) {
		super(msg);
	}
	
	public ReceiptDeleteException(String msg, Throwable e) {
		super(msg,e);
	}

}
