package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.board.domain.BoardVO;
import kr.spring.board.domain.BoardFavVO;
import kr.spring.board.domain.BoardReFavVO;
import kr.spring.board.domain.BoardReplyVO;

public interface BoardService {
	//부모글
	public List<BoardVO> selectList(
			Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	public BoardVO selectBoard(Integer board_num);
	public void updateHit(Integer board_num);
	public void updateBoard(BoardVO board);
	public void deleteBoard(Integer board_num);

	//댓글
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object> map);
	public void insertReply(BoardReplyVO boardReply);
	public void updateReply(BoardReplyVO boardReply);
	public void deleteReply(Integer re_num);
	
	//좋아요
	public BoardFavVO selectFav(BoardFavVO fav);
	public int selectFavCount(Integer board_num);
	public void insertFav(BoardFavVO boardFav);
	public void deleteFav(Integer fav_num);
	
	//댓글 좋아요
	public BoardReFavVO selectReFav(BoardReFavVO fav);
	public int selectReFavCount(Integer num);
	public void insertReFav(BoardReFavVO fav);
	public void deleteReFav(Integer fav_num);
	
}



