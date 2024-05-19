package com.wp.builtinobjectstest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestTestServlet
 */
@WebServlet("/request_test.do")
public class RequestTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		request.setCharacterEncoding("UTF-8");
		
		// step #2. data processing
		
		// step #3. output results
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<head>");
			out.println("<title>HttpServletRequest 주요 API 테스트</title>");
		out.println("</head>");
		out.println("<body>");
			out.println("<h2>HttpServletRequest 주요 API 테스트</h2><hr><br>");
			out.println("<div style='font-size: 1.2rem;'>");
			out.printf("1. 요청 URL : %s <br>\n", request.getRequestURL());
			out.printf("2. 요청 method : %s <br>\n", request.getMethod());
			out.printf("3. 요청 쿼리스트링 : %s <br>\n", request.getQueryString());
			out.printf("4. 요청 파라미터:<br>\n");
			Enumeration<String> paramNames = request.getParameterNames();
			while (paramNames.hasMoreElements()) {
				String name = paramNames.nextElement();
				out.printf("&nbsp;&nbsp;&nbsp;%s = %s <br>\n", name, request.getParameter(name));
			}		
			out.printf("5. 요청 헤더:<br>\n");
			Enumeration<String> headerNames = request.getHeaderNames();
			while (headerNames.hasMoreElements()) {
				String name = headerNames.nextElement();
				out.printf("&nbsp;&nbsp;&nbsp;%s = %s <br>\n", name, request.getHeader(name));
			}		
			out.println("</div>");
		out.println("</body>");
		out.println("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
