package com.sbj.urs.model.member.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbj.urs.exceptoion.CheckIdException;
import com.sbj.urs.exceptoion.CheckIdforPwException;
import com.sbj.urs.exceptoion.CheckPwException;
import com.sbj.urs.exceptoion.MemberNotFoundException;
import com.sbj.urs.model.Common.FileManager;
import com.sbj.urs.model.Common.GenerateRandomPassword;
import com.sbj.urs.model.Common.MailSender;
import com.sbj.urs.model.Common.SecureManager;
import com.sbj.urs.model.domain.Member;
import com.sbj.urs.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberDAO memberDAO;
	
	//메일발송 객체
	@Autowired
	private MailSender mailSender;
	
	//암호화 객체 
	@Autowired
	private SecureManager secureManager;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return memberDAO.selectAll();
	}

	@Override
	public Member select(Member member) throws MemberNotFoundException{
		
		String hash = secureManager.getSecureData(member.getUser_password());
		member.setUser_password(hash);
		Member obj = memberDAO.select(member);
		
		return obj;
	}
	
	@Override
	public Member selectOne(int member_id) {
		return memberDAO.selectOne(member_id);
	}
	
	@Override
	public Member checkId(String user_id) throws CheckIdException{
		
		Member obj = memberDAO.checkId(user_id);
		
		return obj;
	}

	@Override
	public void insert(FileManager fileManager, Member member) {
		String ext = fileManager.getExtend(member.getU_image().getOriginalFilename());
		member.setUser_image(ext); //확장자 결정
		//암호화 처리 
		String secureData = secureManager.getSecureData(member.getUser_password());
		member.setUser_password(secureData); //변환시켜 다시 VO에 대입
		
		memberDAO.insert(member);
		
		String name=member.getUser_name();
		String addr=member.getUser_email_id();
		String email = member.getUser_email_id()+"@"+member.getUser_email_server();
		
		mailSender.send(email , name+"님 [URS]가입축하드려요", "감사합니다!");
		
	
		
		String profile = member.getMember_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveMemberDir()+File.separator+profile, member.getU_image());
	}

	@Override
	public void update(FileManager fileManager,Member member) throws CheckPwException{
		
		String hash = secureManager.getSecureData(member.getUser_password()); 
		member.setUser_password(hash);
		Member obj = memberDAO.checkpw(member);
		if(member.getU_image().getOriginalFilename() == "") {
			member.setUser_image(obj.getUser_image());
		}else {
			if(obj.getUser_image() != "") {
			fileManager.deleteFile(fileManager.getSaveMemberDir()+File.separator+obj.getMember_id()+"."+obj.getUser_image());
			}
			String ext = fileManager.getExtend(member.getU_image().getOriginalFilename());
			member.setUser_image(ext); //확장자 결정
			String profile = obj.getMember_id()+"."+ext; 
			fileManager.saveFile(fileManager.getSaveMemberDir()+File.separator+profile, member.getU_image());
		}
		System.out.println(member.getMember_id());
		System.out.println(member);
		memberDAO.update(member);	
	}

	@Override
	   public void delete(int member_id) { 
		 
		memberDAO.delete(member_id);
	   }
	
	@Override
	public void resetpw(String user_id) throws CheckIdforPwException {
		Member obj = memberDAO.checkIdforpw(user_id);
		String new_pw = GenerateRandomPassword.getRamdomPassword(10);
		String secureData = secureManager.getSecureData(new_pw);
		obj.setUser_password(secureData); //변환시켜 다시 VO에 대입
		
		memberDAO.resetpw(obj);
		
		String name=obj.getUser_name();
		String addr=obj.getUser_email_id();
		String email = obj.getUser_email_id()+"@"+obj.getUser_email_server();
		
		mailSender.send(email , name+"님 비밀번호 초기화 메일입니다", "감사합니다!",new_pw);

	}
	
	@Override
	public Member checkpw(Member member) throws CheckPwException{
		//유저가 전송한 파라미터비번을 해시값으로 변환하여 아래의 메서드 호출 
		String hash = secureManager.getSecureData(member.getUser_password()); 
		member.setUser_password(hash);
		Member obj = memberDAO.checkpw(member);
		return obj; 
	}
	
	@Override
	   public void updateByPosition(Member member) {
	      memberDAO.updateByPosition(member);
	   }
	
	@Override
	   public String selectByImage(int member_id) {
	      return memberDAO.selectByImage(member_id);
	   }

	@Override
	public int countMember() {
		return memberDAO.countMember();
	}

	@Override
	public void update(Member member) {
		memberDAO.update(member);
	}

	@Override
	public void updateToAdmin(Member member) {
		memberDAO.updateToAdmin(member);
	}
}
