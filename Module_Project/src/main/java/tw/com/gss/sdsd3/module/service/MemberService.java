package tw.com.gss.sdsd3.module.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Members;
import tw.com.gss.sdsd3.module.mapper.MemberMapper;
import tw.com.gss.sdsd3.module.query.MemberQueryCriteria;
import tw.com.gss.sdsd3.module.util.MD5Util;

/**
 * {@link Members} 相關商業邏輯。
 */
@Slf4j
@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	private MD5Util encryption;

	/**
	 * 依 {@link Members#getAccount() 帳號} 進行登入驗證。
	 */
	public List<Members> checkLogin(String account, String password) {
		List<Members> result = null;
		try {
			result = memberMapper.checkLogin(account);

			if (result == null) {
				return null;
			} else {
				String encodePassword = MD5Util.textToMD5L32(password, 32);
				
				if (result.get(0).getPassword().equals(encodePassword)) {
					return result;
				}
			}
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return null;
	}

	/**
	 * 依 {@link Members#getId() 流水號} 查詢 {@link Members 會員資料}。
	 */
	public Members findById(int id) {
		Members result = null;
		try {
			result = memberMapper.findById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link Members#getAccount() 帳號} 查詢 {@link Members 會員資料}。
	 */
	public List<Members> findByAccount(MemberQueryCriteria queryCriteria) {
		List<Members> result = null;
		try {
			result = memberMapper.findByAccount(queryCriteria);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 查詢所有 {@link Members 會員資料}。
	 */
	public List<Members> findAll() {
		List<Members> result = null;
		try {
			result = memberMapper.findAll();

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 新增 {@link Members 會員資料}。註冊&後台用
	 */
	public int insert(Members member) {
		int result = 0;
		try {
			// 密碼進行MD5加密
			String newPassword = MD5Util.textToMD5L32(member.getPassword(), 32);
			member.setPassword(newPassword);
			result = memberMapper.insert(member);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Members#getAccount() 帳號} 進行帳號檢查
	 */
	public boolean checkAccount(String account) {
		boolean result = true;
		try {
			// 檢查帳號是否重複
			MemberQueryCriteria queryCriteria = new MemberQueryCriteria();
			queryCriteria.setAccount(account);
			
			if (!memberMapper.findByAccount(queryCriteria).isEmpty()) {
				result = false;
			}
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}
	
	/**
	 * 依 {@link Members#getPassword() 密碼} 進行密碼檢查
	 */
	public boolean checkPassword(Integer id, String password) {
		boolean result = true;
		try {
			// 檢查密碼加密後是否與資料庫相同
			String encodePassword = MD5Util.textToMD5L32(password, 32);
			
			if (!memberMapper.findById(id).getPassword().equals(encodePassword)) {
				result = false;
			}
		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 修改{@link Members 會員資料}。
	 */
	public int update(Members member) {
		int result = 0;
		try {
			// 密碼進行MD5加密
			String newPassword = MD5Util.textToMD5L32(member.getPassword(), 32);
			member.setPassword(newPassword);
			result = memberMapper.update(member);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	/**
	 * 依 {@link Members#getId() 流水號} 刪除 {@link Members 會員資料}。
	 */
	public int deleteById(Integer id) {
		int result = 0;
		try {
			result = memberMapper.deleteById(id);

		} catch (Exception cause) {
			log.error(cause.getMessage(), cause);
			throw new RuntimeException(cause);
		}
		return result;
	}

	public MD5Util getEncryption() {
		return encryption;
	}

	public void setEncryption(MD5Util encryption) {
		this.encryption = encryption;
	}

}
