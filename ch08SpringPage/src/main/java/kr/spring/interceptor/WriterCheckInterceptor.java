package kr.spring.interceptor;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;

public class WriterCheckInterceptor extends HandlerInterceptorAdapter{
	private Logger log = Logger.getLogger(this.getClass());
	
	//의존 관계 설정
	@Resource
	private BoardService boardService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception{
		
		if(log.isDebugEnabled()) {
			log.debug("===로그인 회원번호와 작성자 회원번호가 일치 여부 체크===");
		}
		
		//작성자 회원 번호 구하기
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		BoardVO board = boardService.selectBoard(board_num);
		
		//로그인 회원번호 구하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(log.isDebugEnabled()) {
			log.debug("<<로그인 회원번호>> : " + user_num);
			log.debug("<<작성자 회원번호>> : " + board.getMem_num());
		}
		
		//로그인 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != board.getMem_num()) {
			if(log.isDebugEnabled()) {
				log.debug("<<로그인 회원번호와 작성자 회원번호 불일치>>");
			}
			
			//포워드 방식으로 VIEW 호출
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/board/notice.jsp");
			dispatcher.forward(request, response);
			
			return false;
		}
		
		return true;
	}
	
}






