package hong.jy.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hong.jy.domain.BoardVO;
import hong.jy.domain.Criteria;
import hong.jy.domain.PageMaker;
import hong.jy.service.BoardService;

@Controller
public class AjaxController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("/ajaxPage")
	public void ajaxPage(Criteria cri, Model model) {
		List<BoardVO> boards = service.listPage(cri);
		model.addAttribute("list", boards);
		PageMaker pageMaker = new PageMaker(cri);
		int totalCount = service.getTotalCount(cri);
		pageMaker.setTotalDataCount(totalCount);
		model.addAttribute("pageMaker", pageMaker);
	}
	
	
	@RequestMapping(value= "/ajaxSearch", method = RequestMethod.GET)
	public @ResponseBody List<BoardVO> search(Criteria page, Criteria perPageNum, Criteria searchType, Criteria keyword) {
		System.out.println(keyword);
		int totalCount = service.getTotalCount(page);
		List<BoardVO> list = service.listPage(page);
		System.out.println("검색된 게시물 갯수" + totalCount);
		return list;
	}
	
	
	@RequestMapping(value ="/ajaxPaging", method = RequestMethod.GET)
	public @ResponseBody List<BoardVO> ajaxPaging(Criteria page, Criteria keyword) {
		List<BoardVO> boards = service.listPage(page);
		return boards;
	}
	
	@RequestMapping(value="/realList", method= RequestMethod.GET)
	public @ResponseBody List<BoardVO> realList(Criteria page){
		List<BoardVO> board = service.listPage(page);
		return board;
	}
	@RequestMapping(value="/realWrite", method= RequestMethod.GET)
	public @ResponseBody BoardVO realWrite(BoardVO board) {
		service.input(board);
		return board;
	}
	@RequestMapping(value="/realContent", method= RequestMethod.GET)
	public @ResponseBody BoardVO realContent(Long seq) {
		System.out.println("seq" + seq);
		BoardVO vo = service.content(seq);
		updateReadnum(seq);
		return vo;
	}
	public void updateReadnum(Long seq) {
		service.updateReadnum(seq);
	}
	
	@RequestMapping(value="/realDetail", method = RequestMethod.GET)
	public @ResponseBody BoardVO realDetail(Long seq) {
		BoardVO board = service.content(seq);
		return board;
	}
	@RequestMapping(value="/realDel", method = RequestMethod.GET)
	public @ResponseBody List<BoardVO> delete(Long seq) throws Exception {
	    if (service.delete(seq) == 1) {
	    	// 정상
	    	Criteria page = new Criteria();
	    	List<BoardVO> list = service.listPage(page);
	    	return list;
	    } else {
	    	throw new Exception("삭제가 안됨");
	    }
	}
	@RequestMapping(value="/realUpdate", method = RequestMethod.GET)
	public @ResponseBody List<BoardVO> realUpdate(BoardVO board) throws Exception{
		 if (service.update(board) == 1) {
		    	// 정상
		    	Criteria page = new Criteria();
		    	List<BoardVO> list = service.listPage(page);
		    	return list;
		    } else {
		    	throw new Exception("수정이 안됨");
		    }
	}
}
