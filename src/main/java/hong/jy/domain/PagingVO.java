package hong.jy.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PagingVO {
	
	protected int sn = 1;
	protected int start = 1;
	protected int end = 20;
	protected long totalCnt = 0;
	protected int page = 1;
	protected int totalPages = 1;
	protected int pageSize = 10;
	protected int listNum = 20;
	 
}