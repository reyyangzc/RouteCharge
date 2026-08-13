package routecharge_backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import org.locationtech.jts.geom.Point;

@Entity
@Table(name = "charging_stations")
public class ChargingStation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String operator;
    private String address;
    private Integer powerKw;
    private Boolean isFastCharger;

    @JsonIgnore // Infinite recursion / envelope döngüsünü engeller
    @Column(columnDefinition = "geometry(Point,4326)")
    private Point location;

    public ChargingStation() {}

    // --- JSON ÇIKTISINA ÖZEL ENLEM VE BOYLAM ALANLARI ---

    @JsonProperty("latitude")
    public Double getLatitude() {
        return location != null ? location.getY() : null;
    }

    @JsonProperty("longitude")
    public Double getLongitude() {
        return location != null ? location.getX() : null;
    }

    // --- STANDART GETTER VE SETTER METOTLARI ---

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

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

    public Point getLocation() { return location; }
    public void setLocation(Point location) { this.location = location; }
}