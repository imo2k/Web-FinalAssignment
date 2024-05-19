package com.wp.scoreprocessing;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ScoreOutputServlet
 */
@WebServlet("/output-score.do")
public class ScoreOutputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScoreOutputServlet() {
        super();
        // TODO Auto-generated constructor stub
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
		
		// step #2. data processing
		ScoreDO scoreDO = (ScoreDO)request.getAttribute("score_data");
		
		// step #3. output results
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset='UTF-8'>");
		out.println("<title>성적 처리 결과</title>");
		out.println("<style>");
		out.println("body { padding-left: 100px; }");
		out.println(".td { padding-left: 5px; }");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.println("<header>");
		out.println("<h2>성적 처리 결과</h2><hr><br>");
		out.println("</header>");
		out.println("<article>");
		out.println("<table>");
		out.println("<tr><td class='td'>성 적</td></tr>");
		int[] scores = scoreDO.getScores();
		for(int i=0; i<scores.length; i++) {
			out.printf("<tr><td class='td'>%d :</td><td class='td'>%s</td></tr>\n", i+1, scores[i]);
		}
		out.println("<tr><td>&nbsp;</td></tr>");
		out.printf("<tr><td class='td'>평 균 :</td><td class='td'>%f</td></tr>\n", scoreDO.getAvg());
		out.printf("<tr><td class='td'>표준편차 :</td><td class='td'>%f</td></tr>\n", scoreDO.getSd());
		out.println("<tr><td>&nbsp;</td></tr>");
		out.printf("<tr align='center'><td colspan='2'><a href='%s'>첫 페이지로 가기</a></td></tr>",
				request.getHeader("Referer"));
		out.println("</table>");
		out.println("</form>");
		out.println("</article>");
		out.println("</body>");
		out.println("</html>");		
	}

}
