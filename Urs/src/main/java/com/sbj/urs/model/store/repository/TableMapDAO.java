package com.sbj.urs.model.store.repository;

import java.util.List;

import com.sbj.urs.model.domain.TableMap;

public interface TableMapDAO {
   public List selectAll(); // 테이블 정보 전체 불러오기
   public TableMap selectById(int store_id); // 테이블 정보 1건 불러오기
   public void insert(int store_id); // 점포 등록 pass시 테이블 정보도 같이 생성
   public TableMap select(int user_id);
   public int update(TableMap tableMap);   
   public void deleteById(int store_id); // 점포 삭제시 테이블 정보도 삭제
   public void delete(TableMap tableMap); // 모든 테이블 정보 삭제
   public int updateReservation(TableMap tableMap);
}