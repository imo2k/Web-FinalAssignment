package com.wp.scoreprocessing;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ScoreProcessServlet
 */
@WebServlet("/input-score2.do")
public class ScoreInputBySession extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScoreInputBySession() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		
		// step #2. data processing
		int count = 0;
		HttpSession session = request.getSession();
		if (session.isNew()) {
			session.setAttribute("scores", new ArrayList<String>());
			session.setAttribute("count", 0);
		}
		else {
			count = (int)session.getAttribute("count");
		}
	
		// step #3. output results
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
			out.println("<meta charset=\"UTF-8\">");
			out.println("<title>성적 입력</title>");
			out.println("<style>");
			out.println(".td { padding-left: 5px; }");
			out.println("</style>");
		out.println("</head>");
		out.println("<body>");
			out.println("<header>");
				out.println("<h2>성적 입력</h2><hr><br>");
			out.println("</header>");
			out.println("<article>");
//				String requestURL = response.encodeURL("input-score2.do");
//				out.println("<form action='"+ requestURL +"' method='POST'>");
				out.println("<form action='input-score2.do' method='POST'>");
					out.println("<table>");
						out.println("<tr><td class='td'>성적 :</td><td class='td'><input type='number' name='score' /></td></tr>");
						out.printf("<tr align='center'><td colspan='2'>현재 성적 입력 학생 : %d 명</td></tr>", count);
						out.println("<tr align='center'><td colspan='2'><input type='submit' name='action' value='입력' />&nbsp;&nbsp;");
						out.println("<input type='submit' name='action' value='출력' /></td></tr>");
					out.println("</table>");
				out.println("</form>");
			out.println("</article>");
		out.println("</body>");
		out.println("</html>");	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// step #1. get request parameters
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String score = request.getParameter("score");
		
		// step #2. data processing(business logic)
		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/input-score2.do");
			return;
		}
		
		List<String> scoresList = (List<String>)session.getAttribute("scores");
		int count = (int)session.getAttribute("count");
					
		if (action.equals("입력")) {
			scoresList.add(score);
//			session.setAttribute("scores", scoresList);
			session.setAttribute("count", count + 1);
			
			// step #3. output results
			response.sendRedirect(request.getHeader("Referer"));
		}
		else {	// action == "출력"			
			String[] scoresArray = new String[scoresList.size()];
			scoresList.toArray(scoresArray);
					
			ScoreDO scoreDO = new ScoreDO();
			scoreDO.setScores(scoresArray);
			ScoreProcessingService.process(scoreDO);

			// step #3. output processing results
			// presentation logic
			session.invalidate();
			
			request.setAttribute("score_data", scoreDO);
			
			RequestDispatcher view = request.getRequestDispatcher("output-score.do");
			view.forward(request, response);
		}		
	}

}
