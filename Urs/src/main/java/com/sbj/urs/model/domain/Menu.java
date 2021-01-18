package com.sbj.urs.model.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Menu {
	private int menu_id;
	private int store_id;
	private String menu_name;
	private int menu_price;
	private String menu_image;
	private String menu_stock;
	private MultipartFile M_image;
}
