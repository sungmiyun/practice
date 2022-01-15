package kr.spring.board.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.board.domain.BoardFavVO;
import kr.spring.board.domain.BoardReFavVO;
import kr.spring.board.domain.BoardReplyVO;
import kr.spring.board.service.BoardService;
import kr.spring.member.domain.MemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class BoardAjaxController {
	private Logger log = Logger.getLogger(this.getClass());
	private int rowCount = 10;
	private int pageCount = 10;

	@Resource
	private BoardService boardService;

	//부모글 좋아요 읽기
	@RequestMapping("/board/getFav.do")
	@ResponseBody
	public Map<String,Object> getFav(BoardFavVO fav,HttpSession session){

		if(log.isDebugEnabled()) {
			log.debug("<<게시판 좋아요>> : " + fav);
		}

		Map<String,Object> mapJson = 
				new HashMap<String,Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "success");
			mapJson.put("status", "noFav");
			mapJson.put("count", boardService.selectFavCount(fav.getBoard_num()));
		}else {
			//로그인된 아이디 셋팅
			fav.setMem_num(user.getMem_num());

			BoardFavVO boardFav = boardService.selectFav(fav);

			if(boardFav!=null) {
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
				mapJson.put("count", boardService.selectFavCount(fav.getBoard_num()));
			}else {
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
				mapJson.put("count", boardService.selectFavCount(fav.getBoard_num()));
			}
		}

		return mapJson;
	}
	//부모글 좋아요 등록
	@RequestMapping("/board/writeFav.do")
	@ResponseBody
	public Map<String,Object> writeFav(BoardFavVO fav,HttpSession session){

		if(log.isDebugEnabled()) {
			log.debug("<<부모글 좋아용 등록>> : " + fav);
		}

		Map<String,Object> map = 
				new HashMap<String,Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			map.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			if(log.isDebugEnabled()) {
				log.debug("<<부모글 좋아용 등록>> : " + fav);
			}
			
			BoardFavVO boardFav = boardService.selectFav(fav);

			if(boardFav!=null) {
				boardService.deleteFav(boardFav.getFav_num());

				map.put("result", "success");
				map.put("status", "noFav");
				map.put("count", boardService.selectFavCount(fav.getBoard_num()));
			}else {
				boardService.insertFav(fav);

				map.put("result", "success");
				map.put("status", "yesFav");
				map.put("count", boardService.selectFavCount(fav.getBoard_num()));
			}
		}
		return map;
	}

	//댓글 등록
	@RequestMapping("/board/writeReply.do")
	@ResponseBody
	public Map<String,String> writeReply(
			BoardReplyVO boardReplyVO,
			HttpSession session,
			HttpServletRequest request){

		if(log.isDebugEnabled()) {
			log.debug("<<boardReplyVO>> : " + 
					boardReplyVO);
		}

		Map<String,String> map = 
				new HashMap<String,String>();
		
		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			//로그인 안 됨
			map.put("result", "logout");
		}else {
			//ip등록
			boardReplyVO.setRe_ip(
					request.getRemoteAddr());
			//댓글 등록
			boardService.insertReply(boardReplyVO);
			map.put("result", "success");
		}

		return map;
	}
	//댓글 목록
	@RequestMapping("/board/listReply.do")
	@ResponseBody
	public Map<String,Object> getList(
			@RequestParam(value="pageNum",defaultValue="1")
			int currentPage,
			@RequestParam("board_num") int board_num,
			HttpSession session){
		//(******주의)댓글 좋아요 처리시만 HttpSession 넣을 것
		if(log.isDebugEnabled()) {
			log.debug("<<currentPage>> : " + currentPage);
			log.debug("<<board_num>> : " + board_num);
		}

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("board_num", board_num);

		//총 글의 갯수
		int count = boardService.selectRowCountReply(map);

		PagingUtil page = new PagingUtil(currentPage,count,
				rowCount,pageCount,null);
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		//(***주의)댓글 좋아요 처리할 경우만
		map.put("board_num", board_num);
		MemberVO memberVO = (MemberVO)session.getAttribute("user");
		if(memberVO!=null) {
			map.put("mem_num", memberVO.getMem_num());
		}else {
			map.put("mem_num", 0); 
		}
		List<BoardReplyVO> list = null;
		if(count > 0) {
			list = boardService.selectListReply(map);
		}else {
			list = Collections.emptyList();
		}

		Map<String,Object> mapJson = 
				new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);

		return mapJson;
	}
	//댓글 삭제
	@RequestMapping("/board/deleteReply.do")
	@ResponseBody
	public Map<String,String> deleteReply(
			@RequestParam("re_num") int re_num,
			@RequestParam("mem_num") int mem_num,
			HttpSession session){
   
		if(log.isDebugEnabled()) {
			log.debug("<<re_num>> : " + re_num);
			log.debug("<<mem_num>> : " + mem_num);
		}

		Map<String,String> map = 
				new HashMap<String,String>();

		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			//로그인이 되어있지 않음
			map.put("result", "logout");
		}else if(user!=null && user.getMem_num()==mem_num) {
			//로그인 되어 있고 로그인한 아이디와 작성자 아이디 일치
			boardService.deleteReply(re_num);
			map.put("result", "success");
		}else {
			//로그인 아이디와 작성자 아이디 불일치
			map.put("result", "wrongAccess");
		}		
		return map;
	}
	//댓글 수정
	@RequestMapping("/board/updateReply.do")
	@ResponseBody
	public Map<String,String> modifyReply(
			BoardReplyVO boardReplyVO,
			HttpSession session,
			HttpServletRequest request){

		if(log.isDebugEnabled()) {
			log.debug("<<boardReplyVO>> : " + 
					boardReplyVO);
		}

		Map<String,String> map = 
				new HashMap<String,String>();

		MemberVO user = 
				(MemberVO)session.getAttribute("user");
		if(user==null) {
			//로그인이 안 되어있는 경우
			map.put("result", "logout");
		}else if(user!=null && user.getMem_num()==boardReplyVO.getMem_num()){
			//로그인 회원 번호와 작성자 회원번호 일치

			//ip 등록
			boardReplyVO.setRe_ip(
					request.getRemoteAddr());

			//댓글 수정
			boardService.updateReply(boardReplyVO);
			map.put("result", "success");
		}else {
			//로그인 아이디와 작성자 아이디 불일치
			map.put("result", "wrongAccess");
		}

		return map;
	}

	//댓글 좋아요 읽기
	@RequestMapping("/board/getReFav.do")
	@ResponseBody
	public Map<String,Object> getReFav(BoardReFavVO fav,HttpSession session){

		if(log.isDebugEnabled()) {
			log.debug("<<BoardReFavVO>> : " + fav);
		}

		Map<String,Object> mapJson = 
				new HashMap<String,Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "success");
			mapJson.put("status", "noFav");
			mapJson.put("count", boardService.selectReFavCount(fav.getRe_num()));
		}else {
			//로그인된 아이디 셋팅
			fav.setMem_num(user.getMem_num());

			BoardReFavVO boardReFav = boardService.selectReFav(fav);

			if(boardReFav!=null) {
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
				mapJson.put("count", boardService.selectReFavCount(fav.getRe_num()));
			}else {
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
				mapJson.put("count", boardService.selectReFavCount(fav.getRe_num()));
			}
		}

		return mapJson;
	}

	//댓글 좋아요 등록
	@RequestMapping("/board/writeReFav.do")
	@ResponseBody
	public Map<String,Object> writeRFav(BoardReFavVO fav,HttpSession session){

		if(log.isDebugEnabled()) {
			log.debug("<<BoardReFavVO>> : " + fav);
		}

		Map<String,Object> map = 
				new HashMap<String,Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			map.put("result", "logout");
		}else {
			//로그인된 아이디 셋팅
			fav.setMem_num(user.getMem_num());

			BoardReFavVO boardReFav = boardService.selectReFav(fav);

			if(boardReFav!=null) {
				boardService.deleteReFav(boardReFav.getRefav_num());

				map.put("result", "success");
				map.put("status", "noFav");
				map.put("count", boardService.selectReFavCount(fav.getRe_num()));
			}else {
				boardService.insertReFav(fav);

				map.put("result", "success");
				map.put("status", "yesFav");
				map.put("count", boardService.selectReFavCount(fav.getRe_num()));
			}
		}
		return map;
	}
}












