package com.sbj.urs.model.product.service;

import java.util.List;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Category;

public interface CategoryService {
	public List selectAll(); //��� ī�װ� ��������
	public Category select(int category_id); //ī�װ� �ϳ� ��������
	public void insert(FileManager fileManager,Category category); //ī�װ� ����
	public void update(Category cateogry); //ī�װ� ������Ʈ
	public void delete(Category category); //ī�װ� �����
}
