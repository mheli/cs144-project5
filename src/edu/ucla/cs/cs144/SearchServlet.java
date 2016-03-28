package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.net.URLEncoder;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
    	int toSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
    	int toReturn = Integer.parseInt(request.getParameter("numResultsToReturn"));

        AuctionSearchClient searchClient = new AuctionSearchClient();
        SearchResult[] results = searchClient.basicSearch(request.getParameter("q"), toSkip, toReturn);

        request.setAttribute("queryURL", URLEncoder.encode(request.getParameter("q"), "UTF-8"));
	    request.setAttribute("results", results);
    	request.getRequestDispatcher("/keywordSearch.jsp").forward(request, response);
    }
}
