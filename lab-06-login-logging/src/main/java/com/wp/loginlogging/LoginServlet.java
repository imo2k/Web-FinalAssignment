package com.wp.loginlogging;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(
	name = "login_servlet",
	urlPatterns = {"/login.do"},
	initParams = {
		@WebInitParam(name = "log_file_prefix", value = "/Users/yjkim/log/login-log"),
		@WebInitParam(name = "log_file_surffix", value = ".txt")
	})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PrintWriter logOut = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	@Override
	public void init() throws ServletException {
		SimpleDateFormat sdf = new SimpleDateFormat("-yyyy-MM-dd");
//		String logFileName = "/Users/yjkim/log/login-log-" + sdf.format(new Date()) + ".txt";
		
		String prefix = getInitParameter("log_file_prefix");
		String surffix = getInitParameter("log_file_surffix");	
		String logFileName = prefix + sdf.format(new Date()) + surffix;
		
		try {
			logOut = new PrintWriter(new FileWriter(logFileName, true));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() {
		if (logOut != null) {
			logOut.close();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		request.setCharacterEncoding("UTF-8");
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		// step #2. data processing
		// - member authentication
		// - login logging
		String greeting = null;
		
		if (userid.equals("gdhong") && password.equals("1234")) {
			greeting = String.format("반갑습니다, %s 님!", userid);
			
			if (logOut != null) {
				GregorianCalendar now = new GregorianCalendar();
				logOut.printf("%TF %TT - %s\n", now, now, userid);
			}
		}
		else {
			greeting = "사용자 아이디 또는 비밀번호가 맞지 않습니다...";
		}
				
		// step #3. output processing results
		// - output login result
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<head>");
			out.println("<title>로그인 결과</title>");
		out.println("</head>");
		out.println("<body>");
			out.println("<h2>로그인 결과</h2><hr><br>");
			out.println("<div style='font-size: 1.2rem;'>");
			out.println(greeting + "<br><br>");
			out.println("지금은 서비스 준비중입니다...<br>");
			out.println("</div><br><br>");
			out.println("<input type='button' value='돌아가기' onclick='location.href=\"login.html\"'>");
		out.println("</body>");
		out.println("</html>");	
	}
}
