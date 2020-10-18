package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Pay_way;
import tw.com.gss.sdsd3.module.mapper.Pay_wayMapper;

/**
 * {@link Pay_way} 相關商業邏輯。
 */
@Slf4j
@Service
public class Pay_wayService {
	@Autowired private Pay_wayMapper wayMapper;
	
	/**
	 * 依 {@link Pay_way#getId() 流水號} 查詢 {@link Pay_way 付款方式}。
	 */
	public Pay_way findById(int id) {
		Pay_way result = null;
		try {
			result = wayMapper.findById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
		
	/**
	 * 查詢所有 {@link Pay_way 付款方式} 
	 */
	public List<Pay_way> findAllWay(){
		List<Pay_way> result = null;
		try {
			result = wayMapper.findAllWay();
			
		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link Pay_way 付款方式} 後台管理用。
	 */
	public int insertWay(Pay_way way) {
		int result = 0;
		try {
			result = wayMapper.insertWay(way);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 修改{@link Pay_way 付款方式} 後台管理用。
	 */
	public int updateTag(Pay_way way) {
		int result = 0;
		try {
			result = wayMapper.updateWay(way);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Pay_way#getId() 流水號} 刪除  {@link Pay_way 付款方式} 後台管理用。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = wayMapper.deleteByWayId(id);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}	

}
