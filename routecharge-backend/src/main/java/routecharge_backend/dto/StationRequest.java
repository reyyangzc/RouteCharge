package routecharge_backend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class StationRequest {
    private String name;
    private String operator;
    private String address;
    private Integer powerKw;

    @JsonProperty("isFastCharger")
    private Boolean isFastCharger;

    private Double latitude;
    private Double longitude;

    public StationRequest() {}

    // Getter ve Setter Metotları
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Integer getPowerKw() { return powerKw; }
    public void setPowerKw(Integer powerKw) { this.powerKw = powerKw; }

    public Boolean getIsFastCharger() { return isFastCharger; }
    public void setIsFastCharger(Boolean isFastCharger) { this.isFastCharger = isFastCharger; }

    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }

    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
}