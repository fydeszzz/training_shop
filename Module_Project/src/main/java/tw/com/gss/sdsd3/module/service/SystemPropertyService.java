package tw.com.gss.sdsd3.module.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.SystemProperty;
import tw.com.gss.sdsd3.module.mapper.SystemPropertyMapper;
import tw.com.gss.sdsd3.module.query.SystemPropertyQueryCriteria;

/**
 * {@link SystemProperty} 相關商業邏輯。
 */
@Slf4j
@Service
public class SystemPropertyService {
	@Autowired private SystemPropertyMapper systemPropertyMapper;

	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty#getValue() 系統屬性值}。
	 */
	public String findValueBy(String system, String name) {
		String result = null;
		try {
			systemPropertyMapper.findValueBy(system, name);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public List<SystemProperty>findBy(SystemPropertyQueryCriteria queryCriteria) {
		List<SystemProperty> result = null;
		try {
			result = systemPropertyMapper.findBy(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link SystemProperty#getSystem() 系統} 及 {@link SystemProperty#getName() 屬性名稱} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public List<Map<String, Object>> findMapBy(SystemPropertyQueryCriteria queryCriteria) {
		List<Map<String, Object>> result = null;
		try {
			result = systemPropertyMapper.findMapBy(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link SystemProperty#getId() 流水號} 查詢 {@link SystemProperty 系統屬性}。
	 */
	public SystemProperty findByKey(int id) {
		SystemProperty result = null;
		try {
			result = systemPropertyMapper.findByKey(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 查詢所有 {@link SystemProperty 系統屬性}。
	 */
	public List<SystemProperty> findAll() {
		List<SystemProperty> result = null;
		try {
			result = systemPropertyMapper.findAll();

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增  {@link SystemProperty 系統屬性}。
	 */
	public int insert(SystemProperty systemProperty) {
		int result = 0;
		try {
			result = systemPropertyMapper.insert(systemProperty);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 修改  {@link SystemProperty 系統屬性}。
	 */
	public int update(SystemProperty systemProperty) {
		int result = 0;
		try {
			result = systemPropertyMapper.update(systemProperty);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link SystemProperty#getId() 流水號} 刪除  {@link SystemProperty 系統屬性}。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = systemPropertyMapper.deleteById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
}
