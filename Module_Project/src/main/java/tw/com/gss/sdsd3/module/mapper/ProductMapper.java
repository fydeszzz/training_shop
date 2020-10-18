package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Product;
import tw.com.gss.sdsd3.module.query.ProductQueryCriteria;

/**
 * {@link Product PRODUCT} 會員資料table 相關操作。
 */
@Repository
public interface ProductMapper {
	
	/**
	 * 依 {@link Product#getId() 流水號} 查詢 {@link Product 產品資料} 後台用(只有上架商品)。
	 */
	public Product findById(int id);
	
	/**
	 * 依 {@link Product#getId() 流水號} 查詢 {@link Product 產品資料} 後台用(含下架商品)。
	 */
	public Product findById2(int id);
	
	/**
	 * 依 {@link Product#getProduct_name() 產品名稱} 查詢 {@link Product 產品資料} 前端頁面 / 後台管理用。
	 */
	public List<Product> findByName(ProductQueryCriteria queryCriteria);
	
	/**
	 * 依 {@link Product#getTag() 產品標籤} 查詢 {@link Product 產品資料} 前端頁面 / 後台管理用。
	 */
	public List<Product> findByTag(int tag_id);
	
	/**
	 * 查詢所有 {@link Product 產品資料} 前端頁面 / 後台管理用。
	 */
	public List<Product> findAll();
	
	/**
	 * 查詢所有 {@link Product 產品資料} 前端頁面 / 後台管理用。
	 */
	public List<Product> findAll2();
	
	/**
	 * 新增 {@link Product 產品資料} 後台管理用。
	 */
	public int insert(Product product);
	
	/**
	 * 修改{@link Product 產品資料} 後台管理用。
	 */
	public int update(Product product);
	
	/**
	 * 依 {@link Product#getId() 流水號} 刪除  {@link Product 產品資料} 後台管理用。
	 */
	public int deleteById(Integer id);
	
}
