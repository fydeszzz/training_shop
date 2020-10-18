package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Delivery;

/**
 * {@link Delivery} 配送方式table 相關操作。
 */
@Repository
public interface DeliveryMapper {

	/**
	 * 依 {@link Delivery#getId() 流水號} 查詢 {@link Delivery 配送方式}。
	 */
	public Delivery findById(int id);
	
	/**
	 * 查詢所有 {@link Delivery 配送方式}。
	 */
	public List<Delivery> findAll();
	
	/**
	 * 新增 {@link Delivery 配送方式}。
	 */
	public int insert(Delivery delivery);
	
	/**
	 * 修改{@link Delivery 付款方式}。
	 */
	public int update(Delivery delivery);
	
	/**
	 * 依 {@link Delivery#getId() 流水號} 刪除  {@link Delivery 付款方式}。
	 */
	public int deleteById(Integer id);
	
}
