package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Orders;
import tw.com.gss.sdsd3.module.query.OrdersQueryCriteria;

/**
 * {@link Orders} 訂單資料table 相關操作。
 */
@Repository
public interface OrdersMapper {

	/**
	 * 依 {@link Orders#getId() 流水號} 查詢 {@link Orders 訂單資料}。
	 */
	public Orders findById(int id);

	/**
	 * 依 {@link Orders#getMemberid() 會員id} 查詢 {@link Orders 訂單資料}。
	 */
	public List<Orders> findByMemberid(OrdersQueryCriteria queryCriteria);
	
	/**
	 * 依 {@link Orders#getPayway() 付款方式} 查詢 {@link Orders 訂單資料}。
	 */
	public List<Orders> findByPayway(OrdersQueryCriteria queryCriteria);
	
	/**
	 * 依 {@link Orders#getStatus() 訂單狀態} 查詢 {@link Orders 訂單資料}。
	 */
	public List<Orders> findByStatus(OrdersQueryCriteria queryCriteria);
	
	/**
	 * 查詢所有 {@link Orders 訂單資料}。
	 */
	public List<Orders> findAll();
	
	/**
	 * 新增 {@link Orders 訂單資料}。
	 */
	public int insert(Orders orders);
	
	/**
	 * 修改{@link Orders 訂單資料}。
	 */
	public int update(Orders orders);
	
	/**
	 * 依 {@link Orders#getId() 流水號} 刪除  {@link Orders 訂單資料}。
	 */
	public int deleteById(Integer id);
	
}
