package kr.spring.board.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.spring.board.domain.BoardVO;
import kr.spring.board.service.BoardService;
import kr.spring.member.domain.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class BoardController {
	private Logger log = Logger.getLogger(this.getClass());
	private int rowCount = 10;
	private int pageCount = 10;

	@Resource
	private BoardService boardService;

	//커맨드 객체 초기화
	@ModelAttribute("boardVO")
	public BoardVO initCommand() {
		return new BoardVO();
	}
	
	//==============게시판 글 등록=============//
	//등록 폼
	@RequestMapping(value="/board/write.do",
			method=RequestMethod.GET)
	public String form() {
		return "boardWrite";
	}
	//전송된 데이터 처리
	@RequestMapping(value="/board/write.do",
			method=RequestMethod.POST)
	public String submit(@Valid BoardVO boardVO,
	BindingResult result,
	HttpServletRequest request, RedirectAttributes redirect,
	HttpSession session) {

		if(log.isDebugEnabled()) {
			log.debug("<<게시판 글 저장>> : " + boardVO);
		}

		if(result.hasErrors()) {
			return "boardWrite";
		}
 
		//회원 번호 셋팅
		boardVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		//ip셋팅
		boardVO.setIp(request.getRemoteAddr());
		//글쓰기
		boardService.insertBoard(boardVO);
		
		//RedirectAttributes 객체는 리다이렉트 시점에 한 번만 사용되는 데이터를 전송
		//브라우저에 데이터를 전송하지만 URI상에는 보이지 않는 숨겨진 데이터의 형태로 전달
		redirect.addFlashAttribute("result","success");
		
		//또다른 방법
		//FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
		//fm.put("result", "success");

		return "redirect:/board/list.do";
	}
	//==============게시판 글 목록=============//
	@RequestMapping("/board/list.do")
	public ModelAndView process(
			@RequestParam(value="pageNum",defaultValue="1")
			int currentPage,
			@RequestParam(value="keyfield",defaultValue="")
			String keyfield,
			@RequestParam(value="keyword",defaultValue="")
			String keyword
			) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//총 글의 갯수 또는 검색된 글의 갯수
		int count = boardService.selectRowCount(map);

		if(log.isDebugEnabled()) {
			log.debug("<<count>> : " + count);
		}

		PagingUtil page = 
				new PagingUtil(keyfield,keyword,
						currentPage,count,rowCount,pageCount,
						"list.do");

		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());

		List<BoardVO> list = null;
		if(count > 0) {
			list = boardService.selectList(map);

			if(log.isDebugEnabled()) {
				log.debug("<<list>> : " + list);
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml",page.getPagingHtml());

		return mav;
	}
	//==============게시판 글 상세=============//
	@RequestMapping("/board/detail.do")
	public ModelAndView process(@RequestParam int board_num) {

		if(log.isDebugEnabled()) {
			log.debug("<<board_num>> : " + board_num);
		}

		//해당 글의 조회수 증가
		boardService.updateHit(board_num);
		
		BoardVO board = boardService.selectBoard(board_num);
		//줄바꿈 처리 (summer note 사용시 주석 처리)
		//board.setContent(StringUtil.useBrNoHtml(board.getContent()));
		
		return new ModelAndView("boardView","board",board);
	}
	//파일 다운로드
	@RequestMapping("/board/file.do")
	public ModelAndView download(@RequestParam("board_num")
	int board_num) {

		BoardVO board = 
				boardService.selectBoard(board_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		//속성명       속성값(byte[]의 데이터)
		mav.addObject("downloadFile", board.getUploadfile());
		mav.addObject("filename", board.getFilename());

		return mav;
	}
	//이미지 출력
	@RequestMapping("/board/imageView.do")
	public ModelAndView viewImage(@RequestParam int board_num) {

		BoardVO board = 
				boardService.selectBoard(board_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		//속성명       속성값(byte[]의 데이터)
		mav.addObject("imageFile", board.getUploadfile());
		mav.addObject("filename", board.getFilename());

		return mav;
	}
	//==============게시판 글 수정=============//
	//수정 폼
	@RequestMapping(value="/board/update.do",
			        method=RequestMethod.GET)
	public String form(@RequestParam int board_num,
			           Model model) {
		
		BoardVO boardVO = 
				boardService.selectBoard(board_num);
		
		model.addAttribute("boardVO", boardVO);
		
		return "boardModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@RequestMapping(value="/board/update.do",
	        method=RequestMethod.POST)
	public String submitUpdate(@Valid BoardVO boardVO,
	                     BindingResult result,HttpServletRequest request,
	                     Model model) {
		
		if(log.isDebugEnabled()) {
			log.debug("<<글 정보 수정>> : " + boardVO);
		}
		
		if(result.hasErrors()) {
			return "boardModify";
		}
				
		//ip셋팅
		boardVO.setIp(request.getRemoteAddr());
		
		//글 수정
		boardService.updateBoard(boardVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url", 
				request.getContextPath() + "/board/list.do");
		
		return "common/resultView";
	}
	//==============게시판 글 삭제=============//
	@RequestMapping("/board/delete.do")
	public String submitDelete(@RequestParam int board_num) {
		
		if(log.isDebugEnabled()) {
			log.debug("<<게시판 글 삭제>> : " + board_num);
		}
		
		//글 삭제
		boardService.deleteBoard(board_num);
		
		return "redirect:/board/list.do";
	}
	//============글쓰기 이미지 업로드 ===========//
	//summernote 용
	/*@RequestMapping("/board/imageUploader.do")
	 * public void uploadImage(MultipartFile file, HttpSession session, HttpServletResponse response,
			                                    HttpServletRequest request) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		// 업로드할 폴더 경로
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = System.currentTimeMillis() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		MemberVO memberVO = (MemberVO)session.getAttribute("user");
		
		String filepath = realFolder + "\\" + memberVO.getMem_num() + "\\" + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		out.println(request.getContextPath()+"/resources/image_upload/"+memberVO.getMem_num()+"/"+str_filename);
		out.close();
	}*/
	@RequestMapping("/board/imageUploader.do")
	@ResponseBody
	public Map<String,Object> uploadImage(MultipartFile upload, HttpSession session, HttpServletResponse response,
			                                    HttpServletRequest request) throws Exception {
		// 업로드할 폴더 경로
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");

		// 업로드할 파일 이름
		String org_filename = upload.getOriginalFilename();
		String str_filename = System.currentTimeMillis() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		MemberVO memberVO = (MemberVO)session.getAttribute("user");
		
		String filepath = realFolder + "\\" + memberVO.getMem_num() + "\\" + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		upload.transferTo(f);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded", true);
		map.put("url", request.getContextPath()+"/resources/image_upload/"+memberVO.getMem_num()+"/"+str_filename);
		
		return map;
	}
}







