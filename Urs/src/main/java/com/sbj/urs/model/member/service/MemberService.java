package com.sbj.urs.model.member.service;

import java.util.List;

import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.domain.Member;

public interface MemberService {
	public List selectAll(); //모든 멤버 불러오기 
	public Member checkId(String user_id); //멤버 중복체크
	public Member checkpw(Member member); //멤버 비밀번호 체크
	public Member select(Member member); //멤버 하나 불러오기 
	public Member selectOne(int member_id); //아이디로 멤버하나 불러오기.. 마이페이지를 위해서.
	//public Member selectBySotreId(int store_id); // 관리자의 점포삭제 = reservation, receipt,menu, member 강등이 필요하기 때문
	public void insert(FileManager fileManager,Member member); // 멤버 하나 생성 
	public void update(FileManager fileManager,Member member); // 멤버 수정 
	public void update(Member member); // 멤버 1건 수정
	public void updateToAdmin(Member member); // 관리자의 멤버 수정
	public void delete(int member_id); // 멤버 삭제
	public void resetpw(String user_id); 
	public void updateByPosition(Member member); // 총관리자가 pass시 store로 승격
	public String selectByImage(int member_id); //멤버id로 현재 이미지를 그대로 유지시키기 위함
	public int countMember(); //멤버 수 불러오기
	public void verifyEmail(Member member); //이메일 확인 
	public void changePass(Member mebmer); //비밀변호 변경 
}
