package com.sbj.urs.model.Common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

/*
 * 일단 암호화 된이후엔 복호화 시킬수 없는 SHA 알고리즘으로 회원의 비밀번호를 암호화 시켜주는 객체
 * */
@Component
public class SecureManager {
	StringBuffer sb;
	public String getSecureData(String password) {
	
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte [] data = password.getBytes("UTF-8");
			byte [] hash = digest.digest(data);
			
			//쪼개진 데이터를 대상으로 16진수값으로 변환하여 문자열로 변환
			sb = new StringBuffer();  //문자열을 누적시킬 객체
			
			for(int i = 0 ; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff&hash[i]);
		
				if(hex.length()==1) {
					sb.append("0");
				}
				sb.append(hex);
			}
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	 
}
