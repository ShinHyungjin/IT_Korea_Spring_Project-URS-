package com.sbj.urs.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.model.domain.Category;

@Repository
public class MybatisCategoryDAO implements CategoryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("Category.selectAll");
	
	}

	@Override
	public Category select(int category_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Category.selectOne",category_id);
	}

	@Override
	public void insert(Category category) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Category cateogry) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Category category) {
		// TODO Auto-generated method stub
		
	}
	
}
