package tw.com.gss.sdsd3.module.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 配送方式。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString(callSuper = true)
public class Delivery extends Entity<Integer>{
	private String status_name;		// 配送狀態
		
}
