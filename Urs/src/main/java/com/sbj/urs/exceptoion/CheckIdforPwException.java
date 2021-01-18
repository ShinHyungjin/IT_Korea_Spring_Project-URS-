package com.sbj.urs.exceptoion;

public class CheckIdforPwException extends RuntimeException{
	
	public CheckIdforPwException(String msg) {
		super(msg);
	}
	
	public CheckIdforPwException(String msg, Throwable e) {
		super(msg,e);
	}

}
