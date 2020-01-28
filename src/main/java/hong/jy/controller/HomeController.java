package hong.jy.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hong.jy.domain.BoardVO;
import hong.jy.domain.Criteria;
import hong.jy.domain.PageMaker;
import hong.jy.service.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private BoardService service;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	//paging method
	@RequestMapping(value ="/listPage", method = RequestMethod.GET)
	public void listPage(Criteria cri, Model model) throws Exception {
		List<BoardVO> boards = service.listPage(cri);
		model.addAttribute("list", boards);
		PageMaker pageMaker = new PageMaker(cri);
		int totalCount = service.getTotalCount(cri);
		pageMaker.setTotalDataCount(totalCount);
		model.addAttribute("pageMaker", pageMaker);
		
	}
	
	@RequestMapping(value= "/board" , method = RequestMethod.GET)
	public void board (Model model) throws Exception {
		List<BoardVO> list = service.getList();
		model.addAttribute("list",list);
		
	}
	
	@RequestMapping(value="/content", method = RequestMethod.GET)
	public String content(Long seq, Model model, Criteria cri) {
		model.addAttribute("board", service.content(seq));
		updateReadnum(seq);
		return "/content";
	}
	
	public void updateReadnum(Long seq) {
		service.updateReadnum(seq);
	}
	
	@GetMapping("input")
	public String input() {
		return "/input";
	}
	@PostMapping("/input")
	public String input(BoardVO board, String title, String content) {
		service.input(board);
		return "redirect:listPage";
	}
	
	@GetMapping("delete")
	public String delete(@RequestParam Long seq) {
		service.delete(seq);
		return "redirect:listPage";
	}
	
	@RequestMapping(value="/innerContent", method = RequestMethod.GET)
	public String inner(Long seq, Model model) {
		model.addAttribute("board", service.content(seq));
		return "/innerContent";
	}
	
	@PostMapping("update")
	public String update(BoardVO board) {
		service.update(board);
		return "redirect:listPage";
	}
}
