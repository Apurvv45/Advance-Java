package com.tca;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/page2")
public class Page2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("ext/html");
		PrintWriter out= response.getWriter();
		
		String[] values  = request.getParameterValues("Lbook");
		int Itotal=0;
		if(values!=null) {
			for(int i=0;i<values.length;i++) {
				Itotal=Itotal +Integer.parseInt(values[i]) ;  
			}
		}
		// Creating session...
		
		HttpSession s=request.getSession(true);
		
		//To Store The Values Into The Session...
		s.setAttribute("Page1_total", Itotal);//Value Saved...
		out.println("<h1>Value Saved In the Session..</h1>");
		
		out.close();
	}

}
