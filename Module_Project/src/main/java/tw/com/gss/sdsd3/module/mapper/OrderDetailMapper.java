package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.OrderDetail;
import tw.com.gss.sdsd3.module.query.OrderDetailQueryCriteria;

/**
 * {@link OrderDetail} 詳細訂單table 相關操作。
 */
@Repository
public interface OrderDetailMapper {

	/**
	 * 依 {@link OrderDetail#getOrderid() 訂單id} 查詢 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findByOrderid(OrderDetailQueryCriteria queryCriteria);
	
	/**
	 * 依 {@link OrderDetail#getProductid() 產品id} 查詢 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findByProductid(OrderDetailQueryCriteria queryCriteria);
	
	/**
	 * 查詢所有 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findAll();
	
	/**
	 * 新增 {@link OrderDetail 詳細訂單}。
	 */
	public int insertDetail(OrderDetail orderDetail);
	
	/**
	 * 修改{@link OrderDetail 詳細訂單}。
	 */
	public int updateDetail(OrderDetail orderDetail);
	
	/**
	 * 依 {@link OrderDetail#getOrderId() 流水號} 刪除  {@link OrderDetail 詳細訂單}。
	 */
	public int deleteByDetailId(Integer id);
	
}
