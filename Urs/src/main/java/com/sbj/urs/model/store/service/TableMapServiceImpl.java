package com.sbj.urs.model.store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.model.domain.TableMap;
import com.sbj.urs.model.store.repository.TableMapDAO;

@Service
public class TableMapServiceImpl implements TableMapService{
   @Autowired
   private TableMapDAO tableMapDAO;

   @Override
   public List selectAll() {
      return tableMapDAO.selectAll();
   }

   @Override
   public TableMap selectById(int store_id) {
      return tableMapDAO.selectById(store_id);
   }

   @Override
   public void insert(int store_id) {
      tableMapDAO.insert(store_id);
   }

   


   @Override
   public void deleteById(int store_id) {
      tableMapDAO.deleteById(store_id);
   }

   @Override
   public void delete(TableMap tableMap) {
      tableMapDAO.delete(tableMap);
   }

   @Override
   public TableMap select(int user_id) {
      TableMap tableMap = new TableMap();
      tableMap = tableMapDAO.select(user_id);
      return tableMap;
   }
   
   @Override
   public int update(TableMap tableMap) {
      int result = tableMapDAO.update(tableMap);      
      return result;
   } 
   
   @Override
   public int updateReservation(TableMap tableMap) {
      int result = tableMapDAO.updateReservation(tableMap);
         return result;
   } 

   
}