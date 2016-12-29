
> 待加文档

## pom.xml

```
		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpclient</artifactId>
		</dependency>
		<dependency>
			<groupId>org.apache.httpcomponents</groupId>
			<artifactId>httpmime</artifactId>
		</dependency>
```



## 先对文件分块

```
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
```

## 分块读取文件并返回文件流

```
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
```


## 使用httpClient模拟post传输文件流

```
	public static void post(InputStream is, String fileName, String offset, String md5) {

		CloseableHttpClient httpClient = HttpClients.createDefault();

		HttpPost httpPost = new HttpPost("http://localhost:8080/upload");

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
```

## 使用main方法测试

```
	public static void main(String[] args) throws Exception {
		
		InputStream inputStream = null;
		
		String filePath = "Z:\\1.mp4";
		String fileName = "5.mp4";
		
		FileInputStream fis = new FileInputStream(new File(filePath));
		String md5 = DigestUtils.md5Hex(fis);
		
		Long[] sliceFile = sliceFile(filePath);
		for (Long offset : sliceFile) {
			inputStream = readFileToInputStream(offset, filePath);
			post(inputStream, fileName, String.valueOf(offset), md5);
		}
	}
```


## 服务端接收代码

```
	@RequestMapping("/upload")
	@ResponseBody
	String a(@RequestParam(value = "stream", required = true) MultipartFile file, HttpServletRequest request,
			String fileName, String offset, String md5) {
		String result = fileName;
		InputStream is = null;
		RandomAccessFile randomAccessFile = null;
		try {
		
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

		return result;
	}

```

```
```


















