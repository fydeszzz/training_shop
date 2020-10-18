package tw.com.gss.sdsd3.module.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Product;
import tw.com.gss.sdsd3.module.entity.Product_tag;
import tw.com.gss.sdsd3.module.query.ProductQueryCriteria;
import tw.com.gss.sdsd3.module.service.ProductService;
import tw.com.gss.sdsd3.module.service.Product_tagService;
import tw.com.gss.sdsd3.module.service.SystemPropertyService;

@Slf4j
@Controller
public class ProductController {

	public static final String URL_CONTROLLER_PREFIX = "/product";
	public static final String URL_BACKEND_PREFIX = "/backend";

	private final String ATTRIBUTE_ID = "id";
	private final String ATTRIBUTE_MODEL = "modelAttribute";

	private final String URL_QUERY = "/query";
	private final String URL_TAG = "/tag";

	private final String URL_BACKEND_INDEX = "/productManage";
	private final String URL_ADD = "/add";
	private final String URL_UPDATE = "/update";
	private final String URL_SHELF = "/shelf";
	private final String URL_VIEW = "/view";

	@Autowired
	private ProductService productService;
	@Autowired
	private Product_tagService tagService;
	@Autowired
	private SystemPropertyService systemService;

	// 前台查詢所有商品(進全部商品頁顯示)
	@GetMapping(URL_CONTROLLER_PREFIX)
	public String showQueryPage(Map<String, Object> model, HttpServletRequest request) {

		model.put("queryResult", productService.findAll());

		List<Product_tag> tagList = tagService.findAllTag();
		request.setAttribute("tagList", tagList);

		return "product";
	}

	// 依名稱或標籤id查詢商品資料
	@PostMapping({ URL_CONTROLLER_PREFIX, URL_CONTROLLER_PREFIX + URL_QUERY })
	public String query(@ModelAttribute(ATTRIBUTE_MODEL) ProductQueryCriteria queryCriteria, Map<String, Object> model,
			HttpServletRequest request) {

		model.put("queryResult", productService.findBy(queryCriteria));

		List<Product_tag> tagList = tagService.findAllTag();
		request.setAttribute("tagList", tagList);

		return "product";
	}

	// 顯示個別商品頁面
	@GetMapping(URL_CONTROLLER_PREFIX + "/{" + ATTRIBUTE_ID + "}" + URL_VIEW)
	public String showViewPage(HttpServletRequest request) {

		List<Product_tag> tagList = tagService.findAllTag();
		request.setAttribute("tagList", tagList);

		return "productView";
	}

	// 導入後台商品頁面&以商品編號顯示全部產品
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX)
	public String productBackend(Map<String, Object> model) {

		model.put("queryResult", productService.findAll2());

		return "productManage";
	}
	
	// 後台搜尋產品
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + URL_QUERY)
	public String searchProductBackend(@ModelAttribute(ATTRIBUTE_MODEL) ProductQueryCriteria queryCriteria, Map<String, Object> model,
			HttpServletRequest request) {
		model.put("queryResult", productService.findBy(queryCriteria));
		
		return "productManage";
	}

	// 後台修改商品頁面
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String showUpdatePage() {
		return "productUpdate";
	}

	// 修改商品資料 - 修改後更新
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String update(@ModelAttribute(ATTRIBUTE_MODEL) Product product) {
		productService.update(product);

		return "processResult";
	}
	
	// 新增商品資料- 導入新增頁
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + URL_ADD)
	public String showInsertPage() {
		return "productAdd";
	}

	// 新增商品資料- 新增資料
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = RuntimeException.class)
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + URL_ADD)
	public String insert(@ModelAttribute(ATTRIBUTE_MODEL) Product product) {
		productService.insert(product);

		return "processResult";
	}
	
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX +"/uploadFile")
	public String showUploadPage() {
		return "uploadFile";
	}
	
	// 上傳圖片(後台新增/修改商品)
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX +"/uploadFile")
	@ResponseBody
	public String fileUpload(@RequestParam("file") MultipartFile file, @RequestParam("id") Integer id,
			HttpServletRequest request) throws Exception {   

//		String realPath = request.getSession().getServletContext().getRealPath("/resources/img");
		String realPath = systemService.findByKey(1).getValue();		
		File targetFile = new File(realPath);

		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		// 圖片檔名
		String filename = null;

		if (id == 0) {
			List<Product> list = productService.findAll2();
			filename = "item"+ (list.size()) + ".png";
			file.transferTo(new File(realPath, filename));
		} else {
			filename = "item"+ id + ".png";
			file.transferTo(new File(realPath, filename));
		}
			return "success"; 
		}  

	// 商品上下架
	@ResponseBody
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_SHELF)
	public String shelf(@PathVariable(ATTRIBUTE_ID) Integer id) {
		
		Product product = productService.findById2(id);
		boolean status = false;
		
		if (product.isShelf() == status) {
			product.setShelf(!status);
			productService.update(product);
		} else {
			product.setShelf(status);
			productService.update(product);
		}
		return "done";
	}

	// modelAttribute build
	@ModelAttribute(ATTRIBUTE_MODEL)
	protected Object prepareModelAttribute(@PathVariable(value = ATTRIBUTE_ID, required = false) Integer id,
			HttpServletRequest request, HttpSession session) {

		Object modelAttribute = null;

		String requestURI = request.getRequestURI();
		log.info("[prepareModelAttribute] request URI = {}", requestURI);

		if (StringUtils.isBlank(requestURI)) {
			log.warn("incoming request URI is null.");
		} else {
			String urlPrefix = request.getContextPath() + URL_CONTROLLER_PREFIX;

			try {
				if (requestURI.endsWith(urlPrefix) || requestURI.startsWith(urlPrefix + URL_QUERY)
						|| requestURI.endsWith(URL_BACKEND_INDEX) || requestURI.endsWith(URL_QUERY)) {
					modelAttribute = new ProductQueryCriteria();

				} else if (requestURI.startsWith(urlPrefix + URL_ADD) || requestURI.endsWith(URL_TAG)
						|| requestURI.endsWith(URL_ADD)) {
					modelAttribute = new Product();

				} else if (requestURI.startsWith(urlPrefix) && requestURI.endsWith(URL_VIEW)) {
					session.setAttribute("productid", id);
					modelAttribute = productService.findById(id);
				
				} else if (requestURI.endsWith("/uploadFile")){
					
				} else {
					modelAttribute = productService.findById2(id);
				}
			} catch (Exception cause) {
				log.error(cause.getMessage(), cause);
			}
		}

		log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

		return modelAttribute;
	}

}
