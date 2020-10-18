package tw.com.gss.sdsd3.module.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.SystemProperty;
import tw.com.gss.sdsd3.module.query.SystemPropertyQueryCriteria;

/**
 * {@link SystemProperty SYSTEM_PROPERTY} table 相關操作。
 */
@Repository
public interface SystemPropertyMapper {
	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty#getValue() 系統屬性值}。
	 */
	public String findValueBy(@Param("system") String system, @Param("name") String name);

	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public List<SystemProperty> findBy(SystemPropertyQueryCriteria queryCriteria);

	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public List<Map<String, Object>> findMapBy(SystemPropertyQueryCriteria queryCriteria);

	/**
	 * 依 {@link SystemProperty#getId() 流水號} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public SystemProperty findByKey(int id);

	/**
	 * 查詢所有 {@link SystemProperty 系統屬性}。
	 */
	public List<SystemProperty> findAll();

	/**
	 * 新增  {@link SystemProperty 系統屬性}。
	 */
	public int insert(SystemProperty systemProperty);

	/**
	 * 修改  {@link SystemProperty 系統屬性}。
	 */
	public int update(SystemProperty systemProperty);

	/**
	 * 依 {@link SystemProperty#getId() 流水號} 刪除  {@link SystemProperty 系統屬性}。
	 */
	public int deleteById(Integer id);
}
