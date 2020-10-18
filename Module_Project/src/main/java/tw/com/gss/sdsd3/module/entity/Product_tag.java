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
public class Product_tag extends Entity<Integer>{
	private String tag_name;		// 商品標籤
		
}
