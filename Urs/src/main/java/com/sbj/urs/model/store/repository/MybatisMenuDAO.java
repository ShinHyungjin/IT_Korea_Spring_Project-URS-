package com.sbj.urs.model.store.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Menu;

@Repository
public class MybatisMenuDAO implements MenuDAO {
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;

   @Override
   public List selectAll() {
      return sqlSessionTemplate.selectList("Menu.selectAll");
   }

   @Override
   public List selectById(int store_id) {
      return sqlSessionTemplate.selectList("Menu.selectById", store_id);
   }

   @Override
   public void insert(Menu menu) {
	   sqlSessionTemplate.insert("Menu.insert",menu);
   }
 
   @Override
   public void update(Menu menu) {
      sqlSessionTemplate.update("Menu.update", menu);
   }
   
   @Override
	public void updates(Menu menu) {
		// TODO Auto-generated method stub
		
	}

   @Override
   public void delete(int menu_id) {
      sqlSessionTemplate.delete("Menu.delete", menu_id);
   }

   @Override
   public void deleteById(int store_id) {
      sqlSessionTemplate.delete("Menu.deleteById", store_id);
   }

   @Override
   public Menu select(int menu_id) {
      return sqlSessionTemplate.selectOne("Menu.select", menu_id);
   }

   @Override
   public String selectByImage(int menu_id) {
      return sqlSessionTemplate.selectOne("Menu.selectByImage", menu_id);
   }
   
   @Override
	public int countMenu() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Menu.countmenu");
	}

}