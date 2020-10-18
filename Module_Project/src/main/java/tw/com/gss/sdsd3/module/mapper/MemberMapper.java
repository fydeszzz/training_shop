package tw.com.gss.sdsd3.module.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import tw.com.gss.sdsd3.module.entity.Members;
import tw.com.gss.sdsd3.module.query.MemberQueryCriteria;

/**
 * {@link Members MEMBERS} 會員資料table 相關操作。
 */
@Repository
public interface MemberMapper {
	
	/**
	 * 0. 依 {@link Members#getAccount() 帳號} 及 {@link Members#getPassword() 密碼}進行登入驗證。
	 */
	public List<Members> checkLogin(String account);

	/**
	 * 1. 依 {@link Members#getId() 流水號} 查詢 {@link Members 會員資料}。
	 */
	public Members findById(int id);
	
	/**
	 * 2. 依 {@link Members#getAccount() 帳號} 查詢 {@link Members 會員資料}。
	 */
	public List<Members> findByAccount(MemberQueryCriteria queryCriteria);
	
	/**
	 * 3. 查詢所有 {@link Members 會員資料}。
	 */
	public List<Members> findAll();
	
	/**
	 * 4. 新增 {@link Members 會員資料}。
	 */
	public int insert(Members member);
	
	/**
	 * 5. 修改{@link Members 會員資料}。
	 */
	public int update(Members member);
	
	/**
	 * 6. 依 {@link Members#getId() 流水號} 刪除  {@link Members 會員資料}。
	 */
	public int deleteById(Integer id);
	
}
