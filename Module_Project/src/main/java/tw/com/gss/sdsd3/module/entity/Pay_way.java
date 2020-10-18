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
public class Pay_way extends Entity<Integer>{
	private String method;		// 付款方式
		
}
