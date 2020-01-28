package hong.jy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hong.jy.domain.BoardVO;
import hong.jy.domain.Criteria;
import hong.jy.domain.PagingVO;
import hong.jy.mapper.BoardMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList(){
		return mapper.getList();
	}
	@Override
	public List<BoardVO> getLists(Criteria page, Criteria searchKeyword){
		return mapper.getLists(page, searchKeyword);
	}
	@Override
	public void input(BoardVO board) {
		mapper.input(board);
	}
	
	@Override
	public BoardVO content(Long seq) {
		return mapper.content(seq);
	}
	
	@Override
	public int delete(Long seq) {
		
		return  mapper.delete(seq);
	}
	
	@Override
	public int update(BoardVO board) {
		return mapper.update(board);
	}
	
	@Override
	public void updateReadnum(Long seq) {
		mapper.updateReadnum(seq);
	}
	
	@Override
	public List<BoardVO> listPage(Criteria cri)	{
		return mapper.listPage(cri);
	}
	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

}
