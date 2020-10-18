package tw.com.gss.sdsd3.module.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.SystemProperty;
import tw.com.gss.sdsd3.module.query.SystemPropertyQueryCriteria;
import tw.com.gss.sdsd3.module.service.SystemPropertyService;

@Slf4j
@Controller
@RequestMapping(SystemPropertyController.URL_CONTROLLER_PREFIX)
public class SystemPropertyController {
	
	public static final String URL_CONTROLLER_PREFIX = "/systemProperty"; 

	private final String ATTRIBUTE_ID = "id";
	private final String ATTRIBUTE_MODEL = "modelAttribute";

	private final String URL_QUERY = "/query";
	private final String URL_ADD = "/add";
	private final String URL_UPDATE = "/update";
	private final String URL_DELETE = "/delete";
	private final String URL_VIEW = "/view";

	@Autowired private SystemPropertyService systemPropertyService;

	@RequestMapping(value = { "", URL_QUERY }, method = RequestMethod.GET)
	public String showQueryPage(Map<String, Object> model) {

		model.put("queryResult", systemPropertyService.findAll());

		return "systemPropertyQuery";
	}

	@RequestMapping(value = { "", URL_QUERY }, method = RequestMethod.POST)
	public String query(
			@ModelAttribute(ATTRIBUTE_MODEL) SystemPropertyQueryCriteria queryCriteria, Map<String, Object> model) {

		model.put("queryResult", systemPropertyService.findBy(queryCriteria));

		return "systemPropertyQuery";
	}

	@GetMapping(URL_ADD)
	public String showAddPage(@ModelAttribute(ATTRIBUTE_MODEL) SystemProperty systemProperty) {
		return "systemProperty";
	}

	@PostMapping(URL_ADD)
	public String add(@ModelAttribute(ATTRIBUTE_MODEL) SystemProperty systemProperty) {
		systemPropertyService.insert(systemProperty);

		return "processResult";
	}

	@GetMapping("/{" + ATTRIBUTE_ID + "}" + URL_VIEW)
	public String showViewPage() {
		return "systemPropertyView";
	}

	@GetMapping("/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String showUpdatePage() {
		return "systemProperty";
	}

	@PostMapping("/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String update(@ModelAttribute(ATTRIBUTE_MODEL) SystemProperty systemProperty) {
		systemPropertyService.update(systemProperty);

		return "processResult";
	}

	@PostMapping("/{" + ATTRIBUTE_ID + "}" + URL_DELETE)
	public String delete(@PathVariable(ATTRIBUTE_ID) String id) {
		systemPropertyService.deleteById(NumberUtils.toInt(id));

		return "processResult";
	}

    @ModelAttribute(ATTRIBUTE_MODEL)
    protected Object prepareModelAttribute(
    		@PathVariable(value = ATTRIBUTE_ID, required = false) String id,
    		HttpServletRequest request) {

        Object modelAttribute = null;

        String requestURI = request.getRequestURI();
        log.info("[prepareModelAttribute] request URI = {}", requestURI);

        if (StringUtils.isBlank(requestURI)) {
            log.warn("incoming request URI is null.");
        } else {
            String urlPrefix = request.getContextPath() + URL_CONTROLLER_PREFIX;
            try {
            	if (requestURI.endsWith(urlPrefix) || requestURI.startsWith(urlPrefix + URL_QUERY)) {
            		modelAttribute = new SystemPropertyQueryCriteria();

            	} else if (requestURI.startsWith(urlPrefix + URL_ADD)) {
            		modelAttribute = new SystemProperty();

                } else if (requestURI.startsWith(urlPrefix) &&
                		(requestURI.endsWith(URL_UPDATE) || requestURI.endsWith(URL_VIEW))) {

                    modelAttribute = systemPropertyService.findByKey(NumberUtils.toInt(id));
                }
            } catch(Exception cause)  {
                log.error(cause.getMessage(), cause);
            }
        }

        log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

        return modelAttribute;
    }
}
