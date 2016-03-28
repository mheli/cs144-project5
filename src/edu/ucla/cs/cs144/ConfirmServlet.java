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

public class ConfirmServlet extends HttpServlet implements Servlet {
       
    public ConfirmServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.getRequestDispatcher("/confirm.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        HttpSession session = request.getSession();
        if (request.isSecure()){
            if (session == null)
                session.setAttribute("item", "");
            else {
                Calendar calendar = Calendar.getInstance();
                SimpleDateFormat format = new SimpleDateFormat("MMM-dd-yy HH:mm:ss");

                String creditcard = (String) request.getParameter("creditcard");
                request.setAttribute("creditcard", creditcard);
                request.setAttribute("time", format.format(calendar.getTime()));
            } 
        }
        else {
            session.setAttribute("item", "");
        }
        request.setAttribute("item", (ItemResult) session.getAttribute("item"));
        session.invalidate();

        request.getRequestDispatcher("/confirm.jsp")
        .forward(request, response); 
    }
}
