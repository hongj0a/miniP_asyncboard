package hong.jy.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
	
	private Long seq;
	private String title;
	private String user;
	private String readnum;
	private String content;
	private String regdate;
	private String totalCount;
}
