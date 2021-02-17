package com.sbj.urs.model.store.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Menu;
import com.sbj.urs.model.store.repository.MenuDAO;

@Service
public class MenuServiceImpl implements MenuService{
   @Autowired
   private MenuDAO menuDAO;

   @Override
   public List selectAll() {
      return menuDAO.selectAll();
   }

   @Override
   public List selectById(int store_id) {
      return menuDAO.selectById(store_id);
   }

   @Override
   public void insert(FileManager fileManager, Menu menu) {
	   String ext = fileManager.getExtend(menu.getM_image().getOriginalFilename());
	   menu.setMenu_image(ext); //확장자 결정

		
	   menuDAO.insert(menu);
		
 
	 
		
		String profile = menu.getMenu_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveMenuDir()+File.separator+profile, menu.getM_image());
   }

   @Override
   public void updates(FileManager fileManager,Menu menu) {
	    
	   Menu obj = menuDAO.select(menu.getMenu_id());
	   
	   if(menu.getM_image().getOriginalFilename() == "") {
		   menu.setMenu_image(obj.getMenu_image());
	   }else {
		   fileManager.deleteFile(fileManager.getSaveMenuDir()+File.separator+obj.getMenu_id()+"."+obj.getMenu_image());
		   String ext = fileManager.getExtend(menu.getM_image().getOriginalFilename());
		   String profile = menu.getMenu_id()+"."+ext;
		 
		   menu.setMenu_image(ext);
		   fileManager.saveFile(fileManager.getSaveMenuDir()+File.separator+profile,menu.getM_image());
	   }
	   
      menuDAO.update(menu);
      
     
   }
   
   @Override
	public void update(Menu menu) {
		// TODO Auto-generated method stub
		
	}

   @Override
   public void delete(FileManager fileManager,int menu_id) {
	Menu menu = menuDAO.select(menu_id);
	  fileManager.deleteFile(fileManager.getSaveMemberDir()+File.separator+menu.getMenu_id()+"."+menu.getMenu_image());
	      
      menuDAO.delete(menu_id);
   }

   @Override
   public void deleteById(int store_id) {
      menuDAO.deleteById(store_id);
   }

   @Override
   public Menu select(int menu_id) {
   return menuDAO.select(menu_id);
   }

@Override
public String selectByImage(int menu_id) {
   return menuDAO.selectByImage(menu_id);
}

@Override
	public int countMenu() {
		// TODO Auto-generated method stub
		return menuDAO.countMenu();
	}

}