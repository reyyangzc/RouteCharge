package routecharge_backend.repository;

import routecharge_backend.entity.ChargingStation;
import org.locationtech.jts.geom.Point;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChargingStationRepository extends JpaRepository<ChargingStation, Long> {

    @Query(value = "SELECT * FROM charging_stations s WHERE ST_DWithin(s.location, :userLocation, :distanceMeters)", nativeQuery = true)
    List<ChargingStation> findNearbyStations(@Param("userLocation") Point userLocation, @Param("distanceMeters") double distanceMeters);

    // İsme veya operatöre göre arama (büyük/küçük harf duyarsız)
    List<ChargingStation> findByNameContainingIgnoreCaseOrOperatorContainingIgnoreCase(String name, String operator);
}