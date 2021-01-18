package com.sbj.urs.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Category;
import com.sbj.urs.model.product.repository.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService{
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Override
	public List selectAll() {
		return categoryDAO.selectAll();
	}

	@Override
	public Category select(int category_id) {
		// TODO Auto-generated method stub
		return categoryDAO.select(category_id);
	}

	@Override
	public void insert(FileManager fileManager, Category category) {
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
