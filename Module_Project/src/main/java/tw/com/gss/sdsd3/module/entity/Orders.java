package tw.com.gss.sdsd3.module.entity;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 訂單資料。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString(callSuper = true)
public class Orders extends Entity<Integer>{

	private Integer member_id;	// 會員id(Members)
	private String member_name; // 收件人姓名(預設Members)
	private String phone;		// 會員電話(預設Members)
	private String address;		// 配送地址(預設Members)
	private Integer total;      // 訂單總價
	private Integer pay_way;    // 付款方式(Pay_way)
	private Date order_date;    // 下訂時間
	private Integer status;		// 訂單狀態
	
	private String addressPrefix; // 地址前綴(接Zopcode掛件用, 不入資料庫)
	
	private Pay_way method;		// 付款方式(一對多連結Pay_way)
	private Delivery delivery;  // 配送方式(一對多連結Delivery)
	private List<OrderDetail> detailList; // 訂單細節(Order_Detail)
	
}
