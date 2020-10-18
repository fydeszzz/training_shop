package tw.com.gss.sdsd3.module.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 會員資料。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString(callSuper = true)
public class Members extends Entity<Integer> {
	private String account;
	private String password;
	private String phone;
	private String address;
}
