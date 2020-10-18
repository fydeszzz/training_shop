package tw.com.gss.sdsd3.module.query;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * {@link Orders 訂單資料} 查詢條件。
 */

@Getter
@Setter
@ToString
public class OrdersQueryCriteria {
	private Integer member_id;
	private String pay_way;
	private String status;
}
