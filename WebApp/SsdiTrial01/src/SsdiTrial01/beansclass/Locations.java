package SsdiTrial01.beansclass;

import java.io.Serializable;

public class Locations implements Serializable {
	
	private String regionId,regionName,beaconId,storekeeperName ;

	public Locations() {
		
	}

	public Locations(String regionId, String regionName, String beaconId, String storekeeperName) {
		super();
		this.regionId = regionId;
		this.regionName = regionName;
		this.beaconId = beaconId;
		this.storekeeperName = storekeeperName;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getBeaconId() {
		return beaconId;
	}

	public void setBeaconId(String beaconId) {
		this.beaconId = beaconId;
	}

	public String getStorekeeperName() {
		return storekeeperName;
	}

	public void setStorekeeperName(String storekeeperName) {
		this.storekeeperName = storekeeperName;
	}

	@Override
	public String toString() {
		return "Locations [regionId=" + regionId + ", regionName=" + regionName + ", beaconId=" + beaconId
				+ ", storekeeperName=" + storekeeperName + "]";
	}
	
	
	
	
	
	
	
	

}
