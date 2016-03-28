package edu.ucla.cs.cs144;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.StringBuffer;

import java.io.PrintWriter;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        String search = URLEncoder.encode(request.getParameter("q"));
        URL url = new URL("http://google.com/complete/search?output=toolbar&q="+search);

        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String line;
        StringBuffer body = new StringBuffer();

        while ((line = in.readLine()) != null){
        	body.append(line);
        }
        in.close();

        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();
        out.write(body.toString());
        out.close();
    }
}
