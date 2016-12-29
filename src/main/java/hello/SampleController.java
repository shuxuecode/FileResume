package hello;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@EnableAutoConfiguration
@SpringBootApplication
@ComponentScan
public class SampleController {

	@RequestMapping("/")
	@ResponseBody
	String home() {
		Class<? extends SampleController> class1 = getClass();
		return "Hello World!";
	}

	@RequestMapping("/a")
	@ResponseBody
	String a(@RequestParam(value = "stream", required = true) MultipartFile file, HttpServletRequest request,
			String fileName, String offset, String md5) {
		String result = fileName;
		InputStream is = null;
		RandomAccessFile randomAccessFile = null;
		try {
			System.out.println("我被请求到了: " + new Date().getMinutes() + ":" + new Date().getSeconds());

			File newFile = new File("z:\\" + fileName);
			boolean exis = newFile.exists();
			if (!exis) {
				newFile.createNewFile();
			}

			randomAccessFile = new RandomAccessFile("Z:\\" + fileName, "rwd");
			randomAccessFile.seek(Long.parseLong(offset));

			is = file.getInputStream();
			byte[] buffer = new byte[1024];
			int length = -1;
			while ((length = is.read(buffer)) != -1) {
				randomAccessFile.write(buffer, 0, length);
			}

			FileInputStream fis = new FileInputStream(new File("z:\\" + fileName));
			String md5Hex = DigestUtils.md5Hex(fis);
			if (md5Hex.equals(md5)) {
				result = "传输完毕!";
				System.out.println(result);
			}

			// file.transferTo(new File("D:\\temp\\filetest\\" + a));
		} catch (Exception e) {
		} finally {
			try {
				if (is != null)
					is.close();
				if (randomAccessFile != null)
					randomAccessFile.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return "Hello World!  " + result;
	}

	@RequestMapping("/b")
	@ResponseBody
	public void b(String a, String b) throws IOException {
		InputStream inputStream = null;

//		String filePath = "Z:\\1.mp4";
//		String fileName = "5.mp4";
		String filePath = "Z:\\" + a;
		String fileName = b;

		FileInputStream fis = new FileInputStream(new File(filePath));
		String md5 = DigestUtils.md5Hex(fis);

		Long[] sliceFile = FileUtil.sliceFile(filePath);
		for (Long offset : sliceFile) {
			inputStream = FileUtil.readFileToInputStream(offset, filePath);

			FileUtil.post(inputStream, fileName, String.valueOf(offset), md5);
		}
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(SampleController.class, args);
	}
}