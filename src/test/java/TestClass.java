import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class TestClass {

	public static void post(InputStream is, String fileName, String offset, String md5) {

		CloseableHttpClient httpClient = HttpClients.createDefault();

		HttpPost httpPost = new HttpPost("http://localhost:8080/a");

		try {
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);

			builder.addBinaryBody("stream", is, ContentType.DEFAULT_BINARY, fileName);
			builder.addTextBody("fileName", fileName, ContentType.DEFAULT_TEXT);
			builder.addTextBody("offset", offset, ContentType.DEFAULT_TEXT);
			builder.addTextBody("md5", md5, ContentType.DEFAULT_TEXT);

			// 过时了
			// MultipartEntity multipartEntity = new MultipartEntity();
			// multipartEntity.addPart("stream", inputStreamBody);

			HttpEntity httpEntity = builder.build();
			//
			httpPost.setEntity(httpEntity);

			// 执行请求
			CloseableHttpResponse httpResponse = httpClient.execute(httpPost);

			try {
				// response实体
				HttpEntity entity = httpResponse.getEntity();
				if (null != entity) {
					System.out.println("响应状态码:" + httpResponse.getStatusLine());
					System.out.println("-------------------------------------------------");
					System.out.println("响应内容:" + EntityUtils.toString(entity));
					System.out.println("-------------------------------------------------");
				}
			} finally {
				httpResponse.close();
			}

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (httpClient != null) {
					httpClient.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
	
	
	

}
