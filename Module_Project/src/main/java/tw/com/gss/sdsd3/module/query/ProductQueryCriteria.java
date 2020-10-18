package tw.com.gss.sdsd3.module.query;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import tw.com.gss.sdsd3.module.entity.Product;

/**
 * {@link Product 商品系統} 查詢條件。
 */

@Getter
@Setter
@ToString
public class ProductQueryCriteria {
	private String product_name;
	private Integer tag;
}
