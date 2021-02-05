package com.sbj.urs.model.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private int member_id;
	private String user_id;
	private String user_password;
	private String user_name;
	private Date user_birthday;
	private String user_gender;
	private String user_email_id;
	private String user_email_server;
	private String user_phone;
	private String user_location; 
	private String user_image;
	private String user_position;
	private String user_roulette;
	private String regdate;
	private String authkey;
	private String authstatus;
	
	private MultipartFile u_image;
	
}
