package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.domain.BoardVO;
import kr.spring.board.domain.BoardFavVO;
import kr.spring.board.domain.BoardReFavVO;
import kr.spring.board.domain.BoardReplyVO;

public interface BoardMapper {
	//부모글
	public List<BoardVO> selectList(
			Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	@Insert("INSERT INTO spboard (board_num,title,content,uploadfile,filename,ip,mem_num) VALUES (board_seq.nextval,#{title},#{content},#{uploadfile},#{filename},#{ip},#{mem_num})")
	public void insertBoard(BoardVO board);
	@Select("SELECT * FROM (SELECT board_num,title,content,hit,reg_date,modify_date,uploadfile,filename,ip,mem_num,lag(board_num,1) over(order by board_num) next,lag(title,1) over(order by board_num) next_title, lead(board_num,1) over(order by board_num) prev,lead(title,1) over(order by board_num) prev_title FROM spboard)b JOIN spmember m ON b.mem_num=m.mem_num WHERE b.board_num=#{board_num}")
	public BoardVO selectBoard(Integer board_num);
	@Update("UPDATE spboard SET hit=hit+1 WHERE board_num=#{board_num}")
	public void updateHit(Integer board_num);
	public void updateBoard(BoardVO board);
	@Delete("DELETE FROM spboard WHERE board_num=#{board_num}")
	public void deleteBoard(Integer board_num);

	//댓글
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM spboard_reply WHERE board_num=#{board_num}")
	public int selectRowCountReply(Map<String,Object> map);
	@Insert("INSERT INTO spboard_reply (re_num,re_content,re_ip,board_num,mem_num) VALUES (reply_seq.nextval,#{re_content},#{re_ip},#{board_num},#{mem_num})")
	public void insertReply(BoardReplyVO boardReply);
	@Update("UPDATE spboard_reply SET re_content=#{re_content},re_ip=#{re_ip} WHERE re_num=#{re_num}")
	public void updateReply(BoardReplyVO boardReply);
	@Delete("DELETE FROM spboard_reply WHERE re_num=#{re_num}")
	public void deleteReply(Integer re_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM spboard_reply WHERE board_num=#{board_num}")
	public void deleteReplyByBoardNum(Integer board_num);

	//좋아요
	@Select("SELECT * from spboard_fav where board_num=#{board_num} and mem_num=#{mem_num}")
	public BoardFavVO selectFav(BoardFavVO fav);
	@Select("SELECT COUNT(*) from spboard_fav where board_num=#{board_num}")
	public int selectFavCount(Integer board_num);
	@Insert("INSERT INTO spboard_fav (fav_num,board_num,mem_num) VALUES (fav_seq.nextval,#{board_num},#{mem_num})")
	public void insertFav(BoardFavVO boardFav);
	@Delete("DELETE FROM spboard_fav WHERE fav_num=#{fav_num}")
	public void deleteFav(Integer fav_num);
	@Delete("DELETE FROM spboard_fav WHERE board_num=#{board_num}")
	public void deleteFavByBoardNum(Integer board_num);

	//댓글 좋아요
	@Select("SELECT * from spreply_fav where re_num=#{re_num} and mem_num=#{mem_num}")
	public BoardReFavVO selectReFav(BoardReFavVO fav);
	@Select("SELECT COUNT(*) from spreply_fav where re_num=#{re_num}")
	public int selectReFavCount(Integer num);
	@Insert("INSERT INTO spreply_fav (refav_num,refav_date,re_num,mem_num) VALUES (refav_seq.nextval,SYSDATE,#{re_num},#{mem_num})")
	public void insertReFav(BoardReFavVO fav);
	@Delete("DELETE FROM spreply_fav WHERE refav_num=#{refav_num}")
	public void deleteReFav(Integer fav_num);
	@Delete("DELETE FROM spreply_fav WHERE re_num=#{re_num}")
	public void deleteReFavByRe_num(Integer re_num);
	@Delete("DELETE FROM spreply_fav WHERE re_num in (SELECT re_num FROM spboard_reply WHERE board_num=#{board_num})")
	public void deleteReFavByBoardNum(Integer board_num);
	

}








