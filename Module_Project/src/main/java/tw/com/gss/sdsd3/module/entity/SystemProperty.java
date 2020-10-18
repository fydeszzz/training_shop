package tw.com.gss.sdsd3.module.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 系統屬性。
 */
@SuppressWarnings("serial")
@Getter
@Setter
@ToString(callSuper = true)
public class SystemProperty extends Entity<Integer> {
	private String system;
	private String name;
	private String value;
}
