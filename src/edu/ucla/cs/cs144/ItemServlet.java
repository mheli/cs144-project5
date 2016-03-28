package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.xml.sax.InputSource;
import java.io.StringReader;


public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        AuctionSearchClient searchClient = new AuctionSearchClient();
		String xml = searchClient.getXMLDataForItemId(request.getParameter("id"));

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		Document xmlDoc = null;
		try{
			builder = factory.newDocumentBuilder();
			xmlDoc = builder.parse(new InputSource(new StringReader(xml)));
		}
		catch(Exception err){
			err.printStackTrace();
		}

	    // create new HTTP Session if necessary
	    HttpSession session = request.getSession(true);
		session.setAttribute("item", null);

		MyParser parser = new MyParser();
		if (xmlDoc == null){
			request.setAttribute("item", "");
		}
		else{
			parser.processFile(xmlDoc);
			ItemResult item = new ItemResult(parser.getItemMap(),
				parser.getCategoryList(), parser.getBidList());
		    request.setAttribute("item", item);

		    // save item information for payment if buy price exists
		    if (!item.getBuyPrice().equals(""))
		    	session.setAttribute("item", item);
		}

    	request.getRequestDispatcher("/getItem.jsp").forward(request, response);

    }
}
