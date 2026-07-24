package routecharge_backend.controller;

import routecharge_backend.dto.StationRequest;
import routecharge_backend.entity.ChargingStation;
import routecharge_backend.repository.ChargingStationRepository;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/stations")
@CrossOrigin(origins = "*")
public class ChargingStationController {

    @Autowired
    private ChargingStationRepository repository;

    private final GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);

    // 1. Tüm istasyonları getiren endpoint: GET /api/stations
    @GetMapping
    public List<ChargingStation> getAllStations() {
        return repository.findAll();
    }

    // 2. ID'ye göre tek istasyon getiren endpoint: GET /api/stations/{id}
    @GetMapping("/{id}")
    public ResponseEntity<ChargingStation> getStationById(@PathVariable Long id) {
        return repository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // 3. Yeni istasyon ekleyen endpoint: POST /api/stations
    @PostMapping
    public ChargingStation addStation(@RequestBody StationRequest request) {
        ChargingStation station = new ChargingStation();
        mapRequestToEntity(station, request);
        return repository.save(station);
    }

    // 4. İstasyon güncelleyen endpoint: PUT /api/stations/{id}
    @PutMapping("/{id}")
    public ResponseEntity<ChargingStation> updateStation(@PathVariable Long id, @RequestBody StationRequest request) {
        return repository.findById(id)
                .map(existingStation -> {
                    mapRequestToEntity(existingStation, request);
                    return ResponseEntity.ok(repository.save(existingStation));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // 5. İstasyon silen endpoint: DELETE /api/stations/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStation(@PathVariable Long id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    // 6. Yakındaki istasyonları filtreleyen endpoint: GET /api/stations/nearby
    @GetMapping("/nearby")
    public List<ChargingStation> getNearbyStations(
            @RequestParam Double latitude,
            @RequestParam Double longitude,
            @RequestParam(defaultValue = "10000") Double distanceMeters) {

        Point userLocation = geometryFactory.createPoint(new Coordinate(longitude, latitude));
        return repository.findNearbyStations(userLocation, distanceMeters);
    }

    // 7. İsim veya Operatör ile arama yapan endpoint: GET /api/stations/search?query=ZES
    @GetMapping("/search")
    public List<ChargingStation> searchStations(@RequestParam String query) {
        return repository.findByNameContainingIgnoreCaseOrOperatorContainingIgnoreCase(query, query);
    }

    // DTO verilerini Entity'ye aktaran yardımcı metot
    private void mapRequestToEntity(ChargingStation station, StationRequest request) {
        station.setName(request.getName());
        station.setOperator(request.getOperator());
        station.setAddress(request.getAddress());
        station.setPowerKw(request.getPowerKw());
        station.setIsFastCharger(request.getIsFastCharger());

        if (request.getLongitude() != null && request.getLatitude() != null) {
            Point location = geometryFactory.createPoint(new Coordinate(request.getLongitude(), request.getLatitude()));
            station.setLocation(location);
        }
    }
}