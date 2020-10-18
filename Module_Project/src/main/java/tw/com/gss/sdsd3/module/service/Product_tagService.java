package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Product_tag;
import tw.com.gss.sdsd3.module.mapper.Product_tagMapper;

/**
 * {@link Product_tag} 相關商業邏輯。
 */
@Slf4j
@Service
public class Product_tagService {
	@Autowired private Product_tagMapper tagMapper;
	
	/**
	 * 依 {@link Product_tag#getId() 流水號} 查詢 {@link Product_tag 商品標籤}。
	 */
	public Product_tag findById(int id) {
		Product_tag result = null;
		try {
			result = tagMapper.findById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
		
	/**
	 * 查詢所有 {@link Product_tag 商品標籤} 
	 */
	public List<Product_tag> findAllTag(){
		List<Product_tag> result = null;
		try {
			result = tagMapper.findAllTag();
			
		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link Product_tag 產品標籤} 後台管理用。
	 */
	public int insertTag(Product_tag tag) {
		int result = 0;
		try {
			result = tagMapper.insertTag(tag);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 修改{@link Product_tag 產品標籤} 後台管理用。
	 */
	public int updateTag(Product_tag tag) {
		int result = 0;
		try {
			result = tagMapper.updateTag(tag);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Product_tag#getId() 流水號} 刪除  {@link Product_tag 產品標籤} 後台管理用。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = tagMapper.deleteByTagId(id);
			
		} catch(Exception cause){
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}	

}
