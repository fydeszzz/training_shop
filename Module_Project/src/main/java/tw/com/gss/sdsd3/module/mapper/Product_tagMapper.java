package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Product_tag;

/**
 * {@link Product_tag} 商品標籤table 相關操作。
 */
@Repository
public interface Product_tagMapper {

	/**
	 * 依 {@link Product_tag#getId() 流水號} 查詢 {@link Product_tag 標籤}。
	 */
	public Product_tag findById(int id);
	
	/**
	 * 查詢所有 {@link Product_tag 商品標籤}。
	 */
	public List<Product_tag> findAllTag();
	
	/**
	 * 新增 {@link Product_tag 商品標籤}。
	 */
	public int insertTag(Product_tag tag);
	
	/**
	 * 修改{@link Product_tag 商品標籤}。
	 */
	public int updateTag(Product_tag tag);
	
	/**
	 * 依 {@link Product_tag#getId() 流水號} 刪除  {@link Product_tag 商品標籤}。
	 */
	public int deleteByTagId(Integer id);
	
}
