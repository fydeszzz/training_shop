package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.OrderDetail;
import tw.com.gss.sdsd3.module.mapper.OrderDetailMapper;
import tw.com.gss.sdsd3.module.query.OrderDetailQueryCriteria;

/**
 * {@link OrderDetail} 相關商業邏輯。
 */
@Slf4j
@Service
public class OrderDetailService {
	@Autowired private OrderDetailMapper orderDetailMapper;

	/**
	 * 依 {@link OrderDetail#getOrderid() 訂單編號} 查詢 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findByOrderid(OrderDetailQueryCriteria queryCriteria) {
		List<OrderDetail> result = null;
		try {
			result = orderDetailMapper.findByOrderid(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link OrderDetail#getProductid() 產品編號} 查詢 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findByProductid(OrderDetailQueryCriteria queryCriteria) {
		List<OrderDetail> result = null;
		try {
			result = orderDetailMapper.findByProductid(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 查詢所有 {@link OrderDetail 詳細訂單}。
	 */
	public List<OrderDetail> findAll(){
		List<OrderDetail> result = null;
		try {
			result = orderDetailMapper.findAll();
			
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link OrderDetail 詳細訂單}。
	 */
	public int insertDetail(OrderDetail orderDetail) {
		int result = 0;
		try {
			result = orderDetailMapper.insertDetail(orderDetail);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 修改{@link OrderDetail 詳細訂單}。
	 */
	public int updateDetail(OrderDetail orderDetail) {
		int result = 0;
		try {
			result = orderDetailMapper.updateDetail(orderDetail);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link OrderDetail#getOrderId() 流水號} 刪除  {@link OrderDetail 詳細訂單}。
	 */
	public int deleteByDetailId(Integer id) {
		int result = 0;
		try {
			result = orderDetailMapper.deleteByDetailId(id);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}	

}
