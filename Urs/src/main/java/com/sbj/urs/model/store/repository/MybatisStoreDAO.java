package com.sbj.urs.model.store.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Store;

@Repository
public class MybatisStoreDAO implements StoreDAO {
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;

   @Override
   public List selectAll() {
      return sqlSessionTemplate.selectList("Store.selectAll");
   }

   @Override
   public Store selectById(int store_id) {
      return sqlSessionTemplate.selectOne("Store.selectById", store_id);
   }

   @Override
   public void insert(Store store) {
     sqlSessionTemplate.insert("Store.insert",store);

   }
   
   @Override
	public void updatePic(Store store) {
		sqlSessionTemplate.update("Store.updatepic",store);
		
	}

   @Override
   public void update(Store store) {
      sqlSessionTemplate.update("Store.update", store);
   }
   
   @Override
	public Store selectByMemberId(int member_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Store.selectBymemberId", member_id); 
	}

   @Override
   public List selectAllById(int category_id) {
      return sqlSessionTemplate.selectList("Store.selectAllById", category_id);
   }

   @Override
   public String selectByRepImage(int store_id) {
      String repimg = sqlSessionTemplate.selectOne("Store.selectByRepImage", store_id);
      return repimg;
   }

   @Override
   public void delete(int store_id) {
      sqlSessionTemplate.delete("Store.delete", store_id);
   }

   @Override
   public String selectByImage(int store_id) {
      String image = sqlSessionTemplate.selectOne("Store.selectByImage", store_id);
      return image;
   }
   
   @Override
	public int countStore() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Store.countstore");
	}

}