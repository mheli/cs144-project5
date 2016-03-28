package edu.ucla.cs.cs144;

import java.util.Locale;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Bid implements Comparable<Bid>{
    private String bidderUID;
    private String time;
    private String amount;
    private String rating;
    private String location;
    private String country;

    public Bid(String b, String t, String a, String r, String l, String c){
        bidderUID = b;
        time = t;
        amount = a;
        rating = r;
        location = l;
        country = c;
    }

    @Override
    public int compareTo(Bid o){
        return o.getDateTime().compareTo(getDateTime());
    } 

    public Date getDateTime() {
        DateFormat format = new SimpleDateFormat("MMM-dd-yy HH:mm:ss", Locale.ENGLISH);
        Date date = null;
        try{
            date = format.parse(time);        
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return date;
    }

    public String getBidderUID(){
        return bidderUID;
    }

    public String getTime(){
        return time;
    }

    public String getAmount(){
        return amount;
    }

    public String getRating(){
        return rating;
    }

    public String getLocation(){
        return location;
    }

    public String getCountry(){
        return country;
    }
}