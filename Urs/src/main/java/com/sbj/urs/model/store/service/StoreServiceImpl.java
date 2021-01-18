package com.sbj.urs.model.store.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Store;
import com.sbj.urs.model.store.repository.StoreDAO;

@Service
public class StoreServiceImpl implements StoreService {
   @Autowired
   private StoreDAO storeDAO;

   @Override
   public List selectAll() {
      return storeDAO.selectAll();
   }

   @Override
   public Store selectById(int store_id) {
      return storeDAO.selectById(store_id);
   }
   
   @Override
	public Store selectByMemberId(int member_id) {
		// TODO Auto-generated method stub
		return storeDAO.selectByMemberId(member_id); 
	}

   @Override
   public void insert(FileManager fileManager,Store store) {
		String ext1 = fileManager.getExtend(store.getS_images().getOriginalFilename());
		String ext2 = fileManager.getExtend(store.getM_images().getOriginalFilename());
		 
		store.setStore_repimg(ext1);
		store.setStore_image(ext2);
	 
		
	     storeDAO.insert(store);
		
	
		
		String repImg = store.getMember_id()+"."+ext1;
		String img = store.getMember_id()+"M."+ext2;
		fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+repImg, store.getS_images());
		fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+img, store.getM_images());
		


   }
   
   @Override
	public void updatePic(FileManager fileManager, Store store) {
	   
	   Store obj = storeDAO.selectByMemberId(store.getMember_id());
	   System.out.println("사진1"+obj.getStore_repimg());
	   System.out.println("사진2"+obj.getStore_image());
	   System.out.println(store.getStore_id());
	 
	 
	    
		   if(store.getS_images().getOriginalFilename() != "") {
			    String ext1 = fileManager.getExtend(store.getS_images().getOriginalFilename());
			   store.setStore_repimg(ext1);
			   String repImg = store.getMember_id()+"."+ext1;
			   fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+repImg, store.getS_images());
			   
			   if(store.getM_images().getOriginalFilename()!= "") {
				    String ext2 = fileManager.getExtend(store.getM_images().getOriginalFilename());
				   store.setStore_image(ext2);
				   String img = store.getMember_id()+"M."+ext2;
				   fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+img, store.getM_images());
				   store.setStore_repimg(obj.getStore_repimg());
		   	   
			   }else{
			   store.setStore_image(obj.getStore_image());
			   } 
		   }
		   
		   if(store.getM_images().getOriginalFilename()!= "") {
			    String ext2 = fileManager.getExtend(store.getM_images().getOriginalFilename());
			   store.setStore_image(ext2);
			   String img = store.getMember_id()+"M."+ext2;
			   fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+img, store.getM_images());
			   
			   
			   if(store.getS_images().getOriginalFilename() != "") {
				   String ext1 = fileManager.getExtend(store.getS_images().getOriginalFilename());
				   store.setStore_repimg(ext1);
				   String repImg = store.getMember_id()+"."+ext1;
				   fileManager.saveFile(fileManager.getSaveStoreDir()+File.separator+repImg, store.getS_images());
				   
				    
			   }else {
				   store.setStore_repimg(obj.getStore_repimg());
			   }
			   
	   	   
		   }
		   
		    
		   if(store.getS_images().getOriginalFilename() == "" && store.getM_images().getOriginalFilename()== "") {
			   store.setStore_image(obj.getStore_image());
			   store.setStore_repimg(obj.getStore_repimg());
		   }
		   

	     storeDAO.updatePic(store);

	
		   
	}

   @Override
   public void update(Store store) {
      storeDAO.update(store);
   }

   @Override
   public List selectAllById(int category_id) {
      return storeDAO.selectAllById(category_id);
   }

   @Override
   public String selectByRepImage(int store_id) {
      return storeDAO.selectByRepImage(store_id);
   }

   @Override
   public void delete(int store_id) {
      storeDAO.delete(store_id);
   }

   @Override
   public String selectByImage(int store_id) {
      return storeDAO.selectByImage(store_id);
   }
   
   @Override
	public int countStore() {
		// TODO Auto-generated method stub
		return storeDAO.countStore();
	}

}