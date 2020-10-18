package tw.com.gss.sdsd3.module.query;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import tw.com.gss.sdsd3.module.entity.SystemProperty;

/**
 * {@link SystemProperty 系統屬性} 查詢條件。
 */

@Getter
@Setter
@ToString
public class SystemPropertyQueryCriteria {
	private String system;
    private String name;
}
