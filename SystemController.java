package com.golden.controller;

import java.io.OutputStream;
import java.io.StringWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.Callable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.golden.config.cache.CacheUtil;
import com.golden.entity.oa.Tuser;
import com.golden.model.json.JsonModel;
import com.golden.service.FamilyService;
import com.golden.service.PaFamilyBasicService;
import com.golden.util.GlobalConstant;
import com.lowagie.text.pdf.BaseFont;

import freemarker.template.Configuration;
import freemarker.template.Template;

@RequestMapping("")
@Controller
public class SystemController {

	private static Log logger = LogFactory.getLog(SystemController.class);
	
	@Autowired
	private PaFamilyBasicService paFamilyBasicService;
	@Autowired
	private FamilyService familyService;

	@Autowired
	private CacheUtil cacheUtil;

	@RequestMapping("nologin")
	public String tonoLoginPage() {
		return "error/noLogin";
	}

	@RequestMapping("flushCache")
	@ResponseBody
	public String flushCache(Long t) {
		if (new Date().getDate() == new Date(t).getDate()) {
			cacheUtil.putDictionaryToCache();
			logger.info("刷新了字典配置数据缓存...");

			cacheUtil.putExamineConfigDate();
			logger.info("刷新了审核流程配置数据缓存...");

			return "刷新缓存成功！";
		} else {
			return "刷新缓存失败！";
		}
	}

	@RequestMapping("/checklogin")
	@ResponseBody
	public Callable<String> checkLogin(HttpServletRequest request) {
		// 这么做的好处避免web server的连接池被长期占用而引起性能问题，
		// 调用后生成一个非web的服务线程来处理，增加web服务器的吞吐量。
		System.out.println(request.getSession().getMaxInactiveInterval());
		Tuser user = (Tuser) request.getSession().getAttribute(GlobalConstant.login_user);
		System.out.println(user);
		final Tuser tuser = user;
		return new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2 * 1000L);
				String out = "";
				if (tuser == null) {
					out = "out";
				}
				return out; // + System.currentTimeMillis();
			}
		};
	}

	@RequestMapping("/pdf/export")
	public void exportPdf(HttpServletRequest request, HttpServletResponse response) {
		
		// 创建一个FreeMarker实例
		// 负责管理FreeMarker模板的Configuration实例
	    Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        // 指定FreeMarker模板文件的位置
//        cfg.setServletContextForTemplateLoading(request.getSession().getServletContext(), "/pdfTemplate");
        cfg.setClassForTemplateLoading(getClass(), "/pdf");
		
		ITextRenderer renderer = new ITextRenderer();
		try {
			String realPath = request.getSession().getServletContext().getRealPath("/");
			// 对应css中字体样式 ： font-family:SimSun
			renderer.getFontResolver().addFont(realPath + "pdfTemplate/simsun.ttc", BaseFont.IDENTITY_H,
					BaseFont.NOT_EMBEDDED);
			// 对应css中字体样式 ： font-family:SimHei
			renderer.getFontResolver().addFont(realPath + "pdfTemplate/SIMHEI.TTF", BaseFont.IDENTITY_H,
					BaseFont.NOT_EMBEDDED);

			// 建立数据模型
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("title", "导出pdf模板");
            data.put("name", "数据");

            String html = null;
            cfg.setEncoding(Locale.CHINA, "UTF-8");
            // 获取模板文件 template.ftl
            Template template = cfg.getTemplate("pdf.ftl","UTF-8");
            template.setEncoding("UTF-8");
            StringWriter writer = new StringWriter();
            // 将数据输出到html中
            template.process(getFamilyAllDataByFamilyNoAndId(16122711160487900L, "5342"), writer);
//            template.process(getFamilyAllDataByFamilyNoAndId(4055L, "4055"), writer);
            writer.flush();
            html = writer.toString();
            // 
            renderer.setDocumentFromString(html);

            // 解决图片的相对路径问题  ##必须在设置document后再设置图片路径，不然不起作用
            renderer.getSharedContext().setBaseURL(realPath + "/images/");
            renderer.layout();

            /*
             * 设置浏览器下载响应
             */
            response.reset();  
            response.setContentType("application/pdf");  
            response.setContentType("application/force-download");
            String fileName = "导出测试.pdf";
            fileName = new String(fileName.getBytes("gb2312"), "iso8859-1");
            response.addHeader( "Content-Disposition","attachment; filename=" +fileName) ;
            OutputStream out = response.getOutputStream();  
            renderer.createPDF(out, false);
            renderer.finishPDF();
            out.flush();
            out.close();

			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	private JSONObject getFamilyAllDataByFamilyNoAndId(Long familyNo, String id) {
		JSONObject dataObject = new JSONObject();
		
		{
			// 1、家庭基本信息
			JSONObject baseInfo = new JSONObject();
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("id", id);
			JsonModel model=paFamilyBasicService.findPaFamilyBasicInfo(param);
			JSONArray jsonArray = (JSONArray) model.getData();
			for (Object obj : jsonArray) {
				JSONObject object = (JSONObject) obj;
				String colENName = object.getString("colENName");
				String value = object.getString("value");
				
				if ("householderName".equals(colENName)) {
					baseInfo.put("householderName", value);
				}else if ("gender".equals(colENName)) {
					baseInfo.put("gender", value);
				}else if ("populationNum".equals(colENName)) {
					baseInfo.put("populationNum", value);
				}else if ("nationCode".equals(colENName)) {
					baseInfo.put("nationCode", value);
				}else if ("birthday".equals(colENName)) {
					baseInfo.put("birthday", value);
				}else if ("telNo".equals(colENName)) {
					baseInfo.put("telNo", value);
				}else if ("address1".equals(colENName)) {
					baseInfo.put("address1", value);
				}else if ("address2".equals(colENName)) {
					baseInfo.put("address2", value);
				}else if ("address3".equals(colENName)) {
					baseInfo.put("address3", value);
				}else if ("poorAttributeCode".equals(colENName)) {
					baseInfo.put("poorAttributeCode", value);
				}else if ("mainPoorCauseCode".equals(colENName)) {
					baseInfo.put("mainPoorCauseCode", value);
				}else if ("secondaryPoorCauseCode".equals(colENName)) {
					baseInfo.put("secondaryPoorCauseCode", value);
				}
			}
			dataObject.put("baseInfo", baseInfo);
		}
		
		{
			// 2、生产生活情况
			JSONObject lifeInfo = new JSONObject();
			JsonModel jsonModel = familyService.getFamilyProductionLifeInfo(familyNo);
			JSONArray jsonArray = (JSONArray) jsonModel.getData();
			for (Object obj : jsonArray) {
				JSONObject object = (JSONObject) obj;
				String indexCode = object.getString("indexCode");
				String indexValue = object.getString("indexValue");
			
				if("farmland_fact_area".equals(indexCode)){
					lifeInfo.put("farmland_fact_area", indexValue);
				}else if ("farmland_right_area".equals(indexCode)) {
					lifeInfo.put("farmland_right_area", indexValue);
				}else if ("farmland_irrigate_area".equals(indexCode)) {
					lifeInfo.put("farmland_irrigate_area", indexValue);
				}else if ("farmland_dry_area".equals(indexCode)) {
					lifeInfo.put("farmland_dry_area", indexValue);
				}else if ("farmland_paddy_area".equals(indexCode)) {
					lifeInfo.put("farmland_paddy_area", indexValue);
				}else if ("woodland_fact_area".equals(indexCode)) {
					lifeInfo.put("woodland_fact_area", indexValue);
				}else if ("woodland_right_area".equals(indexCode)) {
					lifeInfo.put("woodland_right_area", indexValue);
				}else if ("return_to_forest_area".equals(indexCode)) {
					lifeInfo.put("return_to_forest_area", indexValue);
				}else if ("fruit_fact_area".equals(indexCode)) {
					lifeInfo.put("fruit_fact_area", indexValue);
				}else if ("fruit_right_area".equals(indexCode)) {
					lifeInfo.put("fruit_right_area", indexValue);
				}else if ("water_fact_area".equals(indexCode)) {
					lifeInfo.put("water_fact_area", indexValue);
				}else if ("water_right_area".equals(indexCode)) {
					lifeInfo.put("water_right_area", indexValue);
				}else if ("grassland_fact_area".equals(indexCode)) {
					lifeInfo.put("grassland_fact_area", indexValue);
				}else if ("grassland_right_area".equals(indexCode)) {
					lifeInfo.put("grassland_right_area", indexValue);
				}else if ("housing_area_info".equals(indexCode)) {
					lifeInfo.put("housing_area_info", indexValue);
				}else if ("structure_type".equals(indexCode)) {
					lifeInfo.put("structure_type", indexValue);
				}else if ("danger_house_level".equals(indexCode)) {
					lifeInfo.put("danger_house_level", indexValue);
				}else if ("out_time".equals(indexCode)) {
					lifeInfo.put("out_time", indexValue);
				}
			}
			dataObject.put("lifeInfo", lifeInfo);
		}
		
		
		
		
		
		
		
		
		
		
		System.out.println();
		System.out.println(JSON.toJSONString(dataObject));
		System.out.println();
		
		
		return dataObject;
	}

}
