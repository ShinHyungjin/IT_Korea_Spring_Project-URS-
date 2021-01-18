package com.sbj.urs.model.product.repository;

import java.util.List;

import com.sbj.urs.model.domain.Category;

public interface CategoryDAO {
	public List selectAll(); //��� ī�װ� ��������
	public Category select(int category_id); //ī�װ� �ϳ� ��������
	public void insert(Category category); //ī�װ� ����
	public void update(Category cateogry); //ī�װ� ������Ʈ
	public void delete(Category category); //ī�װ� �����
}
