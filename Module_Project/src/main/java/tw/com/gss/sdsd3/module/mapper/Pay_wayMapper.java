package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Pay_way;

/**
 * {@link Pay_way} 付款方式table 相關操作。
 */
@Repository
public interface Pay_wayMapper {

	/**
	 * 依 {@link Pay_way#getId() 流水號} 查詢 {@link Pay_way 付款方式}。
	 */
	public Pay_way findById(int id);
	
	/**
	 * 查詢所有 {@link Pay_way 付款方式}。
	 */
	public List<Pay_way> findAllWay();
	
	/**
	 * 新增 {@link Pay_way 付款方式}。
	 */
	public int insertWay(Pay_way way);
	
	/**
	 * 修改{@link Pay_way 付款方式}。
	 */
	public int updateWay(Pay_way way);
	
	/**
	 * 依 {@link Pay_way#getId() 流水號} 刪除  {@link Pay_way 付款方式}。
	 */
	public int deleteByWayId(Integer id);
	
}
