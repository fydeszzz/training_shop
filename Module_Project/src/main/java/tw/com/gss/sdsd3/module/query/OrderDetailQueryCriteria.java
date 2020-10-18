package tw.com.gss.sdsd3.module.query;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import tw.com.gss.sdsd3.module.entity.OrderDetail;

/**
 * {@link OrderDetail 訂單細節} 查詢條件。
 */

@Getter
@Setter
@ToString
public class OrderDetailQueryCriteria {
	private Integer order_id;
	private Integer product_id;
}
