package com.sbj.urs.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbj.urs.exceptoion.CheckIdException;
import com.sbj.urs.exceptoion.CheckIdforPwException;
import com.sbj.urs.exceptoion.CheckPwException;
import com.sbj.urs.exceptoion.MemberNotFoundException;
import com.sbj.urs.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("Member.selectAll");
	}

	@Override
	public Member select(Member member) throws MemberNotFoundException{
		Member obj =  (Member)sqlSessionTemplate.selectOne("Member.selectAcc",member);
		if(obj == null) {
			throw new MemberNotFoundException("로그인 정보가 올바르지 않습니다.");
		}else if(obj.getAuthstatus().equals("0")) {
			throw new CheckIdforPwException("이메일 인증이 완료되지않았습니다 이메일을 확인해주세요");
		}
		return obj;
	}
	
	@Override
	public Member checkId(String user_id) throws CheckIdException{
		Member obj = sqlSessionTemplate.selectOne("Member.checkuser",user_id);
		if(obj != null) {
			throw new CheckIdException("아이디가 중복됩니다");
		}
		return obj;
	}

	@Override
	public void insert(Member member) {
		 sqlSessionTemplate.insert("Member.insert",member);
		
	}

	@Override
	public void update(Member member) {	
		sqlSessionTemplate.update("Member.update",member);
	}

	@Override
	   public void delete(int member_id) {
	      sqlSessionTemplate.delete("Member.delete", member_id);
	   }
	
	@Override
	public Member checkIdforpw(String user_id) throws CheckIdforPwException {
		Member obj = sqlSessionTemplate.selectOne("Member.selectUserPW",user_id);
		 
		if(obj == null) {
			throw new CheckIdforPwException("아이디가 존재하지않습니다");
		}
		return obj;
	}
	
	@Override
	public void resetpw(Member member) throws CheckIdException{
		int result = sqlSessionTemplate.update("Member.resetpw",member);
	 
	}
	
	@Override
	public Member selectOne(int member_id) {
		return sqlSessionTemplate.selectOne("Member.selectUser",member_id);
	}
	
	@Override
	public Member checkpw(Member member) throws CheckPwException {
		Member obj = sqlSessionTemplate.selectOne("Member.checkpw",member);
		if(obj == null) {
			throw new CheckPwException("현재 비밀번호가 올바르지 않습니다");
		}
 
		return obj;
	}
	
	@Override
	   public void updateByPosition(Member member) {
	      sqlSessionTemplate.update("Member.updateByPosition", member);
	   }
	
	@Override
	   public String selectByImage(int member_id) {
	      return sqlSessionTemplate.selectOne("Member.selectByImage", member_id);
	   }
	
	@Override
	public int countMember() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Member.countuser");
	}

	@Override
	public void updateToAdmin(Member member) {
		sqlSessionTemplate.update("Member.updateToAdmin", member);
	}
	
	@Override
	public void verifyEmail(Member member) throws MemberNotFoundException {
		// TODO Auto-generated method stub
	 int result = sqlSessionTemplate.update("Member.verifyEmail",member);
	
	 if(result == 0) {
		throw new MemberNotFoundException("잘못된 접근입니다.");
	 }
	 
	}
	
	@Override
	public void changePass(Member member) throws MemberNotFoundException{
		int result = sqlSessionTemplate.update("Member.changePass",member);
		if(result == 0 ) {
			throw new MemberNotFoundException("잘못 된 접근 입니다");
		}
		
	}

//	@Override
//	public Member selectBySotreId(int store_id) {
//		return sqlSessionTemplate.selectOne("Member.selectByStoreId", store_id);
//	}

}
