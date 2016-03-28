/* CS144
 *
 * Parser skeleton for processing item-???.xml files. Must be compiled in
 * JDK 1.5 or above.
 *
 * Instructions:
 *
 * This program processes all files passed on the command line (to parse
 * an entire diectory, type "java MyParser myFiles/*.xml" at the shell).
 *
 * At the point noted below, an individual XML file has been parsed into a
 * DOM Document node. You should fill in code to process the node. Java's
 * interface for the Document Object Model (DOM) is in package
 * org.w3c.dom. The documentation is available online at
 *
 * http://java.sun.com/j2se/1.5.0/docs/api/index.html
 *
 * A tutorial of Java's XML Parsing can be found at:
 *
 * http://java.sun.com/webservices/jaxp/
 *
 * Some auxiliary methods have been written for you. You may find them
 * useful.
 */

package edu.ucla.cs.cs144;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.ErrorHandler;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.lang.StringBuilder;
import java.io.PrintWriter;

public class MyParser {
    
    private Map<String, String> itemMap = new HashMap<String, String>();
    private List<String> categoryList = new ArrayList<String>();
    private List<Bid> bidList = new ArrayList<Bid>();

    public Map<String, String> getItemMap(){
        return itemMap;
    }

    public List<String> getCategoryList(){
        return categoryList;
    }

    public List<Bid> getBidList(){
        return bidList;
    }

    /* Non-recursive (NR) version of Node.getElementsByTagName(...)
     */
    private Element[] getElementsByTagNameNR(Element e, String tagName) {
        Vector< Element > elements = new Vector< Element >();
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
            {
                elements.add( (Element)child );
            }
            child = child.getNextSibling();
        }
        Element[] result = new Element[elements.size()];
        elements.copyInto(result);
        return result;
    }
    
    /* Returns the first subelement of e matching the given tagName, or
     * null if one does not exist. NR means Non-Recursive.
     */
    private Element getElementByTagNameNR(Element e, String tagName) {
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
                return (Element) child;
            child = child.getNextSibling();
        }
        return null;
    }
    
    /* Returns the text associated with the given element (which must have
     * type #PCDATA) as child, or "" if it contains no text.
     */
    private String getElementText(Element e) {
        if (e.getChildNodes().getLength() == 1) {
            Text elementText = (Text) e.getFirstChild();
            return elementText.getNodeValue();
        }
        else
            return "";
    }

    
    /* Returns the attribute associated with the given tagName 
     * or "" if the attribute does not have a specified or default value
     */
    private String getAttributeTextByTagName(Element e, String tagName) {
        return e.getAttribute(tagName);
    }

    /* Returns the text (#PCDATA) associated with the first subelement X
     * of e with the given tagName. If no such X exists or X contains no
     * text, "" is returned. NR means Non-Recursive.
     */
    private String getElementTextByTagNameNR(Element e, String tagName) {
        Element elem = getElementByTagNameNR(e, tagName);
        if (elem != null)
            return getElementText(elem);
        else
            return "";
    }
    
    /* Returns the text (#PCDATA) associated with all subelements
     * of e with the given tagName. If no such subelements exist or 
     * subelements contains no text, "" is returned.
     */
    private String[] getAllElementTextByTagName(Element e, String tagName) {
        Element[] elements = getElementsByTagNameNR(e, tagName);
        Vector< String > texts = new Vector< String >();
        for (int i = 0; i < elements.length; i++){
            texts.add(getElementText(elements[i]));
        }

        String[] result = new String[texts.size()];
        texts.copyInto(result);
        return result;
    }

    public void processFile(Document xmlFile) {
        Document doc = xmlFile;

        // Get root element "Item"
        Element root = doc.getDocumentElement();

        Element current = root;

        // Seller
        Element eSeller = getElementByTagNameNR(current, "Seller");

        // Seller UID
        String sellerUserID = getAttributeTextByTagName(eSeller, "UserID");
        itemMap.put("seller", sellerUserID);

        // Seller rating
        String sellerRating = getAttributeTextByTagName(eSeller, "Rating");
        itemMap.put("sellerRating", sellerRating);

        // ItemID (required, unique)
        String itemID = getAttributeTextByTagName(current, "ItemID");
        itemMap.put("itemID", itemID);

        // Name
        String name = getElementTextByTagNameNR(current, "Name");
        itemMap.put("name", name);

        // Categories (at least one)
        String[] categories = getAllElementTextByTagName(current, "Category");
        for (int j = 0; j < categories.length; j++){
            categoryList.add(categories[j]);
        }

        // current price
        String currently = getElementTextByTagNameNR(current, "Currently");
        itemMap.put("currently", currently);

        // buy_price (optional)
        String buyPrice = getElementTextByTagNameNR(current, "Buy_Price");
        itemMap.put("buyPrice", buyPrice);

        // first_bid
        String firstBid = getElementTextByTagNameNR(current, "First_Bid");
        itemMap.put("firstBid", firstBid);

        // number of bids
        String numberOfBids = getElementTextByTagNameNR(current, "Number_of_Bids");
        itemMap.put("numberOfBids", numberOfBids);

        // bids (0 or more)
        Element eBids = getElementByTagNameNR(current, "Bids");
        Element[] bids = getElementsByTagNameNR(eBids, "Bid");
        for (int k = 0; k < bids.length; k++){
            // Bidder
            Element eBidder = getElementByTagNameNR(bids[k], "Bidder");

            // Bidder UID
            String bidderUID = getAttributeTextByTagName(eBidder, "UserID");

            // Bidder Rating
            String bidderRating = getAttributeTextByTagName(eBidder, "Rating");

            // Bidder Location (optional)
            String bidderLocation = getElementTextByTagNameNR(eBidder, "Location");

            // Bidder Country (optional)
            String bidderCountry = getElementTextByTagNameNR(eBidder, "Country");

            // Time
            String time = getElementTextByTagNameNR(bids[k], "Time");

            // Amount
            String amount = getElementTextByTagNameNR(bids[k], "Amount");

            bidList.add(new Bid(bidderUID, time, amount, bidderRating, bidderLocation, bidderCountry));
        }
        Collections.sort(bidList);

        // location
        Element eLocation = getElementByTagNameNR(current, "Location");
        String location = getElementTextByTagNameNR(current, "Location");
        itemMap.put("location", location);

        // latitude (optional)
        String latitude = getAttributeTextByTagName(eLocation, "Latitude");
        itemMap.put("latitude", latitude);

        // longitude (optional)
        String longitude = getAttributeTextByTagName(eLocation, "Longitude");
        itemMap.put("longitude", longitude);

        // Country 
        String country = getElementTextByTagNameNR(current, "Country");
        itemMap.put("country", country);

        // Started
        String started = getElementTextByTagNameNR(current, "Started");
        itemMap.put("started", started);

        // Ends
        String ends = getElementTextByTagNameNR(current, "Ends");
        itemMap.put("ends", ends);

        // Description
        String description = getElementTextByTagNameNR(current, "Description");
        itemMap.put("description", description);

    }
    
}
