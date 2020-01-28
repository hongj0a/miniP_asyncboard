package hong.jy.mapper;

import java.util.List;

import hong.jy.domain.BoardVO;
import hong.jy.domain.Criteria;
import hong.jy.domain.PagingVO;

public interface BoardMapper {
	List<BoardVO> getList();
	List<BoardVO> getLists(Criteria page, Criteria searchKeyword);
	public BoardVO content(Long seq);
	public void input(BoardVO board);
	public int delete(Long seq);
	public int update(BoardVO board);
	public void updateReadnum(Long seq);
	public int countArticle(String searchOption, String keyword);
	List<BoardVO> listPage(Criteria cri);
	int getTotalCount(Criteria cri);
}
