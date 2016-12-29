package hello;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;

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

public class FileUtil {

	public static void post(InputStream is, String fileName, String offset, String md5) {

		CloseableHttpClient httpClient = HttpClients.createDefault();

		HttpPost httpPost = new HttpPost("http://localhost:8080/a");

		try {
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);

			// builder.addPart("stream", inputStreamBody);
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

			// //创建参数列表
			// List<NameValuePair> list = new ArrayList<NameValuePair>();
			// list.add(new BasicNameValuePair("a", "zhaoshuxue"));
			//
			// //url格式编码
			// UrlEncodedFormEntity uefEntity = new
			// UrlEncodedFormEntity(list,"UTF-8");
			// httpPost.setEntity(uefEntity);
			System.out.println("POST 请求...." + httpPost.getURI());
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
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

	private static long SIZE = 1024 * 1024;

	public static Long[] sliceFile(String filePath) {
		File file = new File(filePath);
		long length = file.length();
		long start = 0L;

		int arrayLength;
		if (length % SIZE == 0) {
			arrayLength = (int) (length / SIZE);
		} else {
			arrayLength = (int) (length / SIZE) + 1;
		}

		Long[] longs = new Long[arrayLength];
		int i = 0;
		while (start < length) {
			longs[i++] = start;
			start += SIZE;
		}
		return longs;
	}

	public static InputStream readFileToInputStream(long offset, String filePath) {
		RandomAccessFile randomAccessFile = null;
		try {
			// 初使化这个文件
			randomAccessFile = new RandomAccessFile(filePath, "r");
			byte[] tempByte = null;
			// 判断传入的指针是否比总文件长度还要长，只要小于文件长度，才是正常的
			if (offset < randomAccessFile.length()) {
				// 把指针移到要开始的字节位置
				randomAccessFile.seek(offset);
				// 这里是做一个判断，判断从这个位置开始读取，读取这个长度，是否已经超过了文件的长度,一般情况下，我们的块的
				// 长度是固定的，比如1M，而对于一个10.5M的文件，要分11包，当读最后一个包的时候，就会出现这种情况
				if (offset + (SIZE) > randomAccessFile.length()) {
					// 如果已经超过了文件的长度，初使化字节数组的时候，就用文件长度减去指针的位置
					tempByte = new byte[((int) (randomAccessFile.length() - offset))];
					// 这个方法 ，会读取字节长度的数据，然后把数据存储到字节数组
					randomAccessFile.read(tempByte);
				} else {
					// 如果我们要读的一个块的长度，没有超过文件的长度，那就把字节数组初始化为块的长度
					tempByte = new byte[(int) SIZE];
					randomAccessFile.read(tempByte);
				}
				return new ByteArrayInputStream(tempByte);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			if (randomAccessFile != null) {
				try {
					// 关闭文件流
					randomAccessFile.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
}
