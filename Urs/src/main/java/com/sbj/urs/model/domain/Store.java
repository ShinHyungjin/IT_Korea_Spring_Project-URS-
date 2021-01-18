package com.sbj.urs.model.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Store {
	private int store_id;
	private String store_name;
	private String store_location;
	private String store_phone;
	private String store_repimg;
	private String store_reservation;
	private String store_openhour;
	private String store_closehour;
	private String store_pass; 
	private Category category; 
	private String store_account;
	private String store_image;
	private String store_info; 
	private String regdate;
	private String store_tablecount;
	private int member_id;
	private String store_bank;
	
	private MultipartFile s_images;
	private MultipartFile m_images;
	
}
