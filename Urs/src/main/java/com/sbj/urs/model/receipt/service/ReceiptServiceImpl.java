package com.sbj.urs.model.receipt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.exceptoion.ReceiptDeleteException;
import com.sbj.urs.model.domain.Receipt;
import com.sbj.urs.model.receipt.repository.ReceiptDAO;

@Service
public class ReceiptServiceImpl implements ReceiptService {
	@Autowired
	private ReceiptDAO receiptDAO;

	@Autowired
	private ReceiptDAO receipDAO;

	@Override
	public void insert(Receipt receipt) {
		receiptDAO.insert(receipt);
	}

	@Override
	public List selectAll() {
		return receipDAO.selectAll();
	}

	@Override
	public void delete(int receipt_id) throws ReceiptDeleteException {
		receipDAO.delete(receipt_id);
	}

	@Override
	public Receipt select(int receipt_id) {
		return receipDAO.select(receipt_id);
	}

	@Override
	public List selectByStoreId(int store_id) {
		return receipDAO.selectByStoreId(store_id);
	}

@Override
public List selectByMemberId(int member_id) {
	return receipDAO.selectByMemberId(member_id);
}

}