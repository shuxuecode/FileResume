import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.pdf.BaseFont;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;

public class Pdf {
	
	public static void main(String[] args) {
		Pdf pdf = new Pdf();
		try {
			pdf.name();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void name() throws Exception, MalformedTemplateNameException, ParseException, IOException {
		Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
		cfg.setClassForTemplateLoading(getClass(), "/PDFTemplat");
		Template template = cfg.getTemplate("pdf.ftl", "UTF-8");
	}
	

	public void main2(String[] args) {

		// 创建一个FreeMarker实例
		// 负责管理FreeMarker模板的Configuration实例
		Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
		// 指定FreeMarker模板文件的位置
		// cfg.setServletContextForTemplateLoading(request.getSession().getServletContext(),
		// "/pdfTemplate");
//		this.getClass()
		cfg.setClassForTemplateLoading(getClass(), "/pdf");

		
		ITextRenderer renderer = new ITextRenderer();
		try {
			String realPath = ""; //request.getSession().getServletContext().getRealPath("/");
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
			Template template = cfg.getTemplate("pdf.ftl", "UTF-8");
			template.setEncoding("UTF-8");
			StringWriter writer = new StringWriter();
			// 将数据输出到html中
			// template.process(getFamilyAllDataByFamilyNoAndId(16122711160487900L,
			// "5342"), writer);
			template.process(data, writer);
			writer.flush();
			html = writer.toString();
			//
			renderer.setDocumentFromString(html);

			// 解决图片的相对路径问题 ##必须在设置document后再设置图片路径，不然不起作用
			renderer.getSharedContext().setBaseURL(realPath + "/images/");
			renderer.layout();

			/*
			 * 设置浏览器下载响应
			 */
			// response.reset();
			// response.setContentType("application/pdf");
			// response.setContentType("application/force-download");
			// String fileName = "导出测试.pdf";
			// fileName = new String(fileName.getBytes("gb2312"), "iso8859-1");
			// response.addHeader("Content-Disposition", "attachment; filename="
			// + fileName);
			// OutputStream out = response.getOutputStream();
			// renderer.createPDF(out, false);
			// renderer.finishPDF();
			// out.flush();
			// out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
