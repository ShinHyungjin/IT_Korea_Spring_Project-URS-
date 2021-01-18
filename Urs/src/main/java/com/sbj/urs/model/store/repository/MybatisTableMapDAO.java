package com.sbj.urs.model.store.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.model.domain.TableMap;

@Repository
public class MybatisTableMapDAO implements TableMapDAO {
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;

   @Override
   public List selectAll() {
      return sqlSessionTemplate.selectList("TableMap.selectAll");
   }

   @Override
   public TableMap selectById(int store_id) {
      return sqlSessionTemplate.selectOne("TableMap.selectById", store_id);
   }

   @Override
   public void insert(int store_id) {
      sqlSessionTemplate.insert("TableMap.insert", store_id);
   }


   @Override
   public TableMap select(int user_id) {
      return sqlSessionTemplate.selectOne("TableMap.select", user_id);
   }

   @Override
   public int update(TableMap tableMap) {      
      return sqlSessionTemplate.update("TableMap.update", tableMap);
   }


   @Override
   public void deleteById(int store_id) {
      sqlSessionTemplate.delete("TableMap.deleteById", store_id);
   }

   @Override
   public void delete(TableMap tableMap) {
      sqlSessionTemplate.delete("TableMap.delete", tableMap);
   }
   
   @Override
   public int updateReservation(TableMap tableMap) {
      return sqlSessionTemplate.update("TableMap.updateReservation", tableMap);
   }

}