<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = (String) (request.getParameter("filename"));
	String saveFolder = "File";

	ServletContext context = getServletContext();

	String realFolder = "";

	String savePath = realFolder;//+ "\\" + filename;    

	String tempSavePath = request.getRealPath(File.separator)
			+ "upload\\"; // 경로

	savePath = tempSavePath.replace('\\', '/'); // 구분자 리플레이스
	
	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	String client = "";

	System.out.println(savePath + "\\" + filename);
	
	try {
		// 파일을 읽어 스트림에 담기
		try {
			file = new File(savePath, filename);
			in = new FileInputStream(file);
		} catch (FileNotFoundException fe) {
			skip = true;
		}

		filename = java.net.URLEncoder.encode(filename, "UTF-8");
		
		client = request.getHeader("User-Agent");

		// 파일 다운로드 헤더 지정
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		
		if (!skip) {

			// IE
			if (client.indexOf("MSIE") != -1) {
				response.setHeader(
						"Content-Disposition",
						"attachment; filename="
								+ new String(filename
										.getBytes("KSC5601"),
										"ISO8859_1"));
			} else {
				// IE 이외
				response.setHeader("Content-Disposition",
						"attachment; filename=\"" + filename + "\"");
				response.setHeader("Content-Type",
						"application/octet-stream; charset=utf-8");
			}

			response.setHeader("Content-Length", "" + file.length());

			out.clear();
			pageContext.pushBody();

			os = response.getOutputStream();
			byte b[] = new byte[(int) file.length()];
			int leng = 0;

			while ((leng = in.read(b)) > 0) {
				os.write(b, 0, leng);
			}

		} else {
			response.setContentType("text/html;charset=UTF-8");
			out.println("<script language='javascript'>alert('파일을 찾을 수 없습니다:" + savePath + " : " + filename + "');history.back();</script>");
		}

		in.close();
		os.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
%>