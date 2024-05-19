package com.wp.scoreprocessing;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CookieTest
 */
@WebServlet("/visit.do")
public class CookieTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CookieTest() {
        super();
        // TODO Auto-generated constructor stub
    }

    private Cookie findCookie(Cookie[] cookies, String name) {
    	Cookie result = null;
    	
    	if (cookies != null && name != null && name != "") {
    		for(Cookie cookie : cookies) {
    			if (cookie.getName().equals(name)) {
    				result = cookie;
    				break;
    			}
    		}
    	}
    	
    	return result;
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		Cookie[] cookies = request.getCookies();
		
		// step #2. data processing
		int visitCount = 0;
		Cookie visitCnt = findCookie(cookies, "visit_count");
		if (visitCnt != null) {
			visitCount = Integer.parseInt(visitCnt.getValue());
		}
		else {
			visitCnt = new Cookie("visit_count", "0");
		}
		
		visitCount++;
		visitCnt.setValue(String.valueOf(visitCount));
		if (visitCount >= 5) {
			visitCnt.setMaxAge(0);
		}
		else {
			visitCnt.setMaxAge(3600);
		}
		response.addCookie(visitCnt);
		
		// step #3. output results
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset=\"UTF-8\">");
		out.println("<title>쿠키 테스트</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h2>쿠키 테스트</h2><hr><br>");
		out.println("<div>");
		out.println("<b>당신의 방문 회수는 " + visitCount + " 입니다!</b>");
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
