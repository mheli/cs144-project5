package edu.ucla.cs.cs144;

import java.util.Map;
import java.util.List;

public class ItemResult {
    private String seller;
    private String sellerRating;
    private String itemID;
    private String name;
    private String currently;
    private String buyPrice;
    private String firstBid;
    private String numberOfBids;
    private String location;
    private String latitude;
    private String longitude;
    private String country;
    private String started;
    private String ends;
    private String description;
	private String [] categories;
    private Bid [] bids;

	public ItemResult() {}
    
	public ItemResult(Map<String, String> itemMap, List<String> categoryList, List<Bid> bidList) {
		seller = itemMap.get("seller");
		sellerRating = itemMap.get("sellerRating");
		itemID = itemMap.get("itemID");
		name = itemMap.get("name");
		currently = itemMap.get("currently");
		buyPrice = itemMap.get("buyPrice");
		firstBid = itemMap.get("firstBid");
		numberOfBids = itemMap.get("numberOfBids");
		location = itemMap.get("location");
		latitude = itemMap.get("latitude");
		longitude = itemMap.get("longitude");
		country = itemMap.get("country");
		started = itemMap.get("started");
		ends = itemMap.get("ends");
		description = itemMap.get("description");
		categories = new String[categoryList.size()];
		categories = categoryList.toArray(categories);
		bids = new Bid[bidList.size()];
		bids = bidList.toArray(bids);
	}
    
	public String getSeller(){
		return seller;
	}

	public String getSellerRating(){
		return sellerRating;
	}

	public String getItemID(){
		return itemID;
	}

	public String getName(){
		return name;
	}

	public String getCurrently(){
		return currently;
	}

	public String getBuyPrice(){
		return buyPrice;
	}

	public String getFirstBid(){
		return firstBid;
	}

	public String getNumberOfBids(){
		return numberOfBids;
	}

	public String getLocation(){
		return location;
	}

	public String getLatitude(){
		return latitude;
	}

	public String getLongitude(){
		return longitude;
	}

	public String getCountry(){
		return country;
	}

	public String getStarted(){
		return started;
	}

	public String getEnds(){
		return ends;
	}

	public String getDescription(){
		return description;
	}

	public String[] getCategories(){
		return categories;
	}
	
	public Bid[] getBids(){
		return bids;
	}
}
