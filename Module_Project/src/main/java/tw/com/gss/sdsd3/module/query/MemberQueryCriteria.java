package tw.com.gss.sdsd3.module.query;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import tw.com.gss.sdsd3.module.entity.Members;

/**
 * {@link Members 會員系統} 查詢條件。
 */

@Getter
@Setter
@ToString
public class MemberQueryCriteria {
	private String account;
}
