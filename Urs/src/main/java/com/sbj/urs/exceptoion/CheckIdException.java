package com.sbj.urs.exceptoion;

public class CheckIdException extends RuntimeException{
	
	public CheckIdException(String msg) {
		super(msg);
	}
	
	public CheckIdException(String msg, Throwable e) {
		super(msg,e);
	}

}
