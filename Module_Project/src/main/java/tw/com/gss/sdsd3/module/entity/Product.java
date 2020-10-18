package tw.com.gss.sdsd3.module.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 商品資料。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString(callSuper = true)
public class Product extends Entity<Integer>{
	private String product_name;	// 商品名稱
	private String detail;			// 商品描述
	private Integer tag;			// 商品標籤(Product_tag)
	private Integer price;			// 商品價錢
	private Integer storage;        // 商品庫存(管理者用)
	private boolean shelf;			// 商品上下架(預設為1)
	
	private Integer quantity;       // 商品數量(不入資料庫)
	
	private Product_tag product_tag; // 商品標籤名稱(Product_tag)
}
