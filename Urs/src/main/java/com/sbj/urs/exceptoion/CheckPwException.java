package com.sbj.urs.exceptoion;

public class CheckPwException extends RuntimeException{
	
	public CheckPwException(String msg) {
		super(msg);
	}
	
	public CheckPwException(String msg, Throwable e) {
		super(msg,e);
	}

}
