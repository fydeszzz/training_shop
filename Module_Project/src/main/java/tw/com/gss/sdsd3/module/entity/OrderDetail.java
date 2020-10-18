package tw.com.gss.sdsd3.module.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 訂單詳細資料。
 */
@Getter
@Setter
@ToString(callSuper = true)
public class OrderDetail{
	
	private Integer order_id;	// 訂單id(Order)
	private Integer product_id;	// 商品id(Product)
	private Integer quantity;   // 商品數量(Order)
	private Integer sum;		// 購買總價(數量x商品當下單價)
	
	private Product product; // 商品名稱(Product) 
}
