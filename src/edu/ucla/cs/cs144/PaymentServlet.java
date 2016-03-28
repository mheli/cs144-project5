package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PaymentServlet extends HttpServlet implements Servlet {
       
    public PaymentServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
	    HttpSession session = request.getSession();
    	if (session == null)
    		session.setAttribute("item", "");
    	else {
            request.setAttribute("server", request.getServerName()); // localhost
            request.setAttribute("upshift", 8443);
            request.setAttribute("path", request.getContextPath()); // /eBay
        }
    	request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }
}
