package hong.jy.service;

import java.util.List;

import hong.jy.domain.BoardVO;
import hong.jy.domain.Criteria;
import hong.jy.domain.PagingVO;

public interface BoardService {
	List<BoardVO> getLists(Criteria page, Criteria searchKeyword);	
	List<BoardVO> getList();
	public BoardVO content(Long seq);
	public void input(BoardVO board);
	public int delete(Long seq);
	public int update(BoardVO board);
	public void updateReadnum(Long seq);
	List<BoardVO> listPage(Criteria cri);
	int getTotalCount(Criteria cri);
}
