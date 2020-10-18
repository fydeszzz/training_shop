package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Orders;
import tw.com.gss.sdsd3.module.mapper.OrdersMapper;
import tw.com.gss.sdsd3.module.query.OrdersQueryCriteria;

/**
 * {@link Orders} 相關商業邏輯。
 */
@Slf4j
@Service
public class OrdersService {
	@Autowired private OrdersMapper ordersMapper;

	/**
	 * 依 {@link Orders#getId() 流水號} 查詢 {@link Orders 訂單資料}。
	 */
	public Orders findById(int id) {
		Orders result = null;
		try {
			result = ordersMapper.findById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Orders#getMember_id() 會員編號} 查詢 {@link Order 訂單資料}。
	 */
	public List<Orders> findByMemberid(OrdersQueryCriteria queryCriteria) {
		List<Orders> result = null;
		try {
			result = ordersMapper.findByMemberid(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Orders#getPayway() 訂單狀態} 查詢 {@link Orders 訂單資料}。
	 */
	public List<Orders> findByPayway(OrdersQueryCriteria queryCriteria) {
		List<Orders> result = null;
		try {
			result = ordersMapper.findByPayway(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Orders#getStatus() 訂單狀態} 查詢 {@link Orders 訂單資料}。
	 */
	public List<Orders> findByMemo(OrdersQueryCriteria queryCriteria) {
		List<Orders> result = null;
		try {
			result = ordersMapper.findByStatus(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 查詢所有 {@link Orders 訂單資料}。
	 */
	public List<Orders> findAll(){
		List<Orders> result = null;
		try {
			result = ordersMapper.findAll();
			
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link Orders 訂單資料}。
	 */
	public int insert(Orders orders) {
		int result = 0;
		try {
			result = ordersMapper.insert(orders);
		
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 修改{@link Orders 訂單資料}。
	 */
	public int update(Orders orders) {
		int result = 0;
		try {
			result = ordersMapper.update(orders);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Orders#getId() 流水號} 刪除  {@link Orders 詳細訂單}。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = ordersMapper.deleteById(id);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}	

}
