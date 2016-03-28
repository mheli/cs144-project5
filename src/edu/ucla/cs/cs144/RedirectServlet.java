package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class RedirectServlet extends HttpServlet implements Servlet {
       
    public RedirectServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String target = request.getParameter("target");
        String server = request.getServerName(); // localhost
        int port = 1448;
        String path = request.getContextPath(); // /eBay

        response.sendRedirect("http://"+server+":"+port+path+"/"+target);
    }
}
