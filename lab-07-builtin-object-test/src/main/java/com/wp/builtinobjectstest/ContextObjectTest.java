package com.wp.builtinobjectstest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ContextObjectTest
 */
@WebServlet("/context_test.do")
public class ContextObjectTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContextObjectTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		
		// step #2. data processing
//		ServletContext context = getServletConfig().getServletContext();
		ServletContext context = getServletContext();
		
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
			out.printf("1.컨텍스트 초기화 파라미터 :<br>\n");
			Enumeration<String> paramNames = context.getInitParameterNames();
			while (paramNames.hasMoreElements()) {
				String name = paramNames.nextElement();
				out.printf("&nbsp;&nbsp;&nbsp; %s = %s <br>", name, context.getInitParameter(name));
			}
			out.printf("2. Server Info. : %s <br>\n", context.getServerInfo());
			out.printf("3. Servlet Version : %d.%d <br>\n", context.getMajorVersion(), context.getMinorVersion());
			out.printf("4. Context Path : %s <br>\n", context.getContextPath());
			out.printf("5. Resource Real Path : %s <br>\n", context.getRealPath("test_home.html"));
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
