package kr.spring.board.domain;

import java.sql.Date;

public class BoardReFavVO {
	private int refav_num;
	private Date refav_date;
	private int re_num;
	private int mem_num;
	
	public int getRefav_num() {
		return refav_num;
	}
	public void setRefav_num(int refav_num) {
		this.refav_num = refav_num;
	}
	public Date getRefav_date() {
		return refav_date;
	}
	public void setRefav_date(Date refav_date) {
		this.refav_date = refav_date;
	}
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	@Override
	public String toString() {
		return "BoardReFavVO [refav_num=" + refav_num + ", refav_date=" + refav_date + ", re_num=" + re_num
				+ ", mem_num=" + mem_num + "]";
	}
}
