package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.domain.BoardVO;
import kr.spring.board.domain.BoardFavVO;
import kr.spring.board.domain.BoardReFavVO;
import kr.spring.board.domain.BoardReplyVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource
	private BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> selectList(Map<String, Object> map) {
		return boardMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return boardMapper.selectRowCount(map);
	}

	@Override
	public void insertBoard(BoardVO board) {
		boardMapper.insertBoard(board);
	}

	@Override
	public BoardVO selectBoard(Integer board_num) {
		return boardMapper.selectBoard(board_num);
	}

	@Override
	public void updateHit(Integer num) {
		boardMapper.updateHit(num);
	}

	@Override
	public void updateBoard(BoardVO board) {
		boardMapper.updateBoard(board);
	}

	@Override
	public void deleteBoard(Integer board_num) {
		//좋아요 삭제
		boardMapper.deleteFavByBoardNum(board_num);
		//(****주의)댓글의 좋아요를 먼제 삭제
		boardMapper.deleteReFavByBoardNum(board_num);
		//댓글이 존재하면 댓글을 우선 삭제하고 부모글을 삭제
		boardMapper.deleteReplyByBoardNum(board_num);
		//부모글 삭제
		boardMapper.deleteBoard(board_num);
	}

	@Override
	public List<BoardReplyVO> selectListReply(Map<String, Object> map) {
		return boardMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return boardMapper.selectRowCountReply(map);
	}

	@Override
	public void insertReply(BoardReplyVO boardReply) {
		boardMapper.insertReply(boardReply);
	}

	@Override
	public void updateReply(BoardReplyVO boardReply) {
		boardMapper.updateReply(boardReply);
	}

	@Override
	public void deleteReply(Integer re_num) {
		//(*******주의)댓글 좋아요가 있을 경우
		boardMapper.deleteReFavByRe_num(re_num);
		boardMapper.deleteReply(re_num);
	}

	@Override
	public BoardFavVO selectFav(BoardFavVO fav) {
		return boardMapper.selectFav(fav);
	}

	@Override
	public void insertFav(BoardFavVO boardFav) {
		boardMapper.insertFav(boardFav);
	}
	
	@Override
	public int selectFavCount(Integer board_num) {
		return boardMapper.selectFavCount(board_num);
	}

	@Override
	public void deleteFav(Integer fav_num) {
		boardMapper.deleteFav(fav_num);
	}

	@Override
	public BoardReFavVO selectReFav(BoardReFavVO fav) {
		return boardMapper.selectReFav(fav);
	}

	@Override
	public int selectReFavCount(Integer board_num) {
		return boardMapper.selectReFavCount(board_num);
	}

	@Override
	public void insertReFav(BoardReFavVO fav) {
		boardMapper.insertReFav(fav);
	}

	@Override
	public void deleteReFav(Integer fav_num) {
		boardMapper.deleteReFav(fav_num);
	}
}





