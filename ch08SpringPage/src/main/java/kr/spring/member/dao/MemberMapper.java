package kr.spring.member.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

public interface MemberMapper {
	//회원관리
	//회원 번호 구하기
	@Select("SELECT sprmember_seq.nextval FROM dual")
	public int selectMem_num();
	//회원 등록
	@Insert("INSERT INTO sprmember (mem_num, id) VALUES (#{mem_num}, #{id})")
	public void insertMember(MemberVO member);
	@Insert("INSERT INTO sprmember_detail (mem_num, name, passwd, phone, email, zipcode, address1, address2) VALUES (#{mem_num}, #{name}, #{passwd}, #{phone}, #{email}, #{zipcode}, #{address1}, #{address2})")
	public void insertMember_detail(MemberVO member);
	//아이디 중복 체크 및 로그인 체크
	@Select("SELECT m.mem_num, m.id, m.auth, d.passwd FROM sprmember m LEFT OUTER JOIN sprmember_detail d ON m.mem_num=d.mem_num WHERE m.id=#{id}")
	public MemberVO selectCheckMember(String id);
	//회원 상세정보
	@Select("SELECT * FROM sprmember m JOIN sprmember_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);
	//회원정보 수정
	@Update("UPDATE sprmember_detail SET name=#{name}, phone=#{phone}, email=#{email}, zipcode=#{zipcode}, address1=#{address1}, address2=#{address2}, modify_date=SYSDATE WHERE mem_num=#{mem_num} ")
	public void updateMember(MemberVO member);
	//비밀번호 수정
	@Update("UPDATE sprmember_detail SET passwd=#{passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);
	//회원탈퇴
	@Update("UPDATE sprmember SET auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);
	@Delete("DELETE FROM sprmember_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);
	
	
}	
