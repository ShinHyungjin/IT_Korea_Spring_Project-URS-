package com.sbj.urs.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.store.service.MenuService;
import com.sbj.urs.model.store.service.StoreService;
import com.sbj.urs.model.store.service.TableMapService;

@RestController
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private TableMapService tableMapService;
	
	@GetMapping("/store/{category_id}")
	public List<Store> getList(@PathVariable int category_id){
		List<Store> storeList = storeService.selectAllById(category_id);
		
		return storeList;
	}
	
	@GetMapping("/store/menu/{store_id}")
	public List<Menu> getMenuList(@PathVariable int store_id){
		List<Menu> menuList = menuService.selectById(store_id);
		
		return menuList;
	}
	
	@GetMapping("/store/table/{store_id}")
	public TableMap getTableMap(@PathVariable int store_id) {
		TableMap tableMap = tableMapService.selectById(store_id);
		
		return tableMap;
	}
	
	
	
	
	

}
