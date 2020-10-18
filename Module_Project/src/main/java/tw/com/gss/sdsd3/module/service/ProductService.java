package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Product;
import tw.com.gss.sdsd3.module.mapper.ProductMapper;
import tw.com.gss.sdsd3.module.query.ProductQueryCriteria;

/**
 * {@link Product} 相關商業邏輯。
 */
@Slf4j
@Service
public class ProductService {
	@Autowired private ProductMapper productMapper;
	
	/**
	 * 依 {@link Product#getId() 流水號} 查詢 {@link Product 商品資料}。
	 */
	public Product findById(int id) {
		Product result = null;
		try {
			result = productMapper.findById(id);
			
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Product#getId() 流水號} 查詢 {@link Product 商品資料}。(含下架)
	 */
	public Product findById2(int id) {
		Product result = null;
		try {
			result = productMapper.findById2(id);
			
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Product#getProduct_name() 產品名稱} 查詢 {@link Product 產品資料} 前端頁面 / 後台管理用。
	 */
	public List<Product> findBy(ProductQueryCriteria queryCriteria) {
		List<Product> result = null;
		try {
			result = productMapper.findByName(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Product#getTag() 產品標籤編號} 查詢 {@link Product 產品資料} sidebar條用
	 */
	public List<Product> findByTag(int tagid){
		List<Product> result = null;
		try {
			result = productMapper.findByTag(tagid);
			
		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 查詢所有 {@link Product 產品資料} 前端頁面用(不含下架商品)。
	 */
	public List<Product> findAll(){
		List<Product> result = null;
		try {
			result = productMapper.findAll();
			
		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 查詢所有 {@link Product 產品資料} 後台管理用(含下架商品)。
	 */
	public List<Product> findAll2(){
		List<Product> result = null;
		try {
			result = productMapper.findAll2();
			
		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link Product 產品資料} 後台管理用。
	 */
	public int insert(Product product) {
		int result = 0;
		try {
			result = productMapper.insert(product);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 修改{@link Product 產品資料} 後台管理用。
	 */
	public int update(Product product) {
		int result = 0;
		try {
			result = productMapper.update(product);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Product#getId() 流水號} 刪除  {@link Product 產品資料} 後台管理用。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = productMapper.deleteById(id);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}	

}
