package SsdiTrial01.beansclass;

import java.io.Serializable;

public class Discounts implements Serializable {
	
	private String id,RegionId,OfferText,Price,DiscountPercent,ImageUrl,RegionName,BeaconId,StoreKeeperName;

	public Discounts() {
		
	}

	public Discounts(String id, String regionId, String offerText, String price, String discountPercent,
			String imageUrl, String regionName, String beaconId, String storeKeeperName) {
		super();
		this.id = id;
		RegionId = regionId;
		OfferText = offerText;
		Price = price;
		DiscountPercent = discountPercent;
		ImageUrl = imageUrl;
		RegionName = regionName;
		BeaconId = beaconId;
		StoreKeeperName = storeKeeperName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRegionId() {
		return RegionId;
	}

	public void setRegionId(String regionId) {
		RegionId = regionId;
	}

	public String getOfferText() {
		return OfferText;
	}

	public void setOfferText(String offerText) {
		OfferText = offerText;
	}

	public String getPrice() {
		return Price;
	}

	public void setPrice(String price) {
		Price = price;
	}

	public String getDiscountPercent() {
		return DiscountPercent;
	}

	public void setDiscountPercent(String discountPercent) {
		DiscountPercent = discountPercent;
	}

	public String getImageUrl() {
		return ImageUrl;
	}

	public void setImageUrl(String imageUrl) {
		ImageUrl = imageUrl;
	}

	public String getRegionName() {
		return RegionName;
	}

	public void setRegionName(String regionName) {
		RegionName = regionName;
	}

	public String getBeaconId() {
		return BeaconId;
	}

	public void setBeaconId(String beaconId) {
		BeaconId = beaconId;
	}

	public String getStoreKeeperName() {
		return StoreKeeperName;
	}

	public void setStoreKeeperName(String storeKeeperName) {
		StoreKeeperName = storeKeeperName;
	}

	@Override
	public String toString() {
		return "discounts [id=" + id + ", RegionId=" + RegionId + ", OfferText=" + OfferText + ", Price=" + Price
				+ ", DiscountPercent=" + DiscountPercent + ", ImageUrl=" + ImageUrl + ", RegionName=" + RegionName
				+ ", BeaconId=" + BeaconId + ", StoreKeeperName=" + StoreKeeperName + "]";
	}
	
	
	
	
	

}
