package com.example.demo.controller;

import com.example.demo.service.TrainService;
import com.example.demo.service.TripService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EntityRestController {

    @Autowired
    private UserService userService;
    @Autowired
    private TrainService trainService;
    @Autowired
    private TripService tripService;


    @PostMapping("/users/check_username")
    public String checkDuplicateUsername(@Param("id") Long id, @Param("username") String username) {
        return userService.isUsernameUnique(id, username) ? "OK" : "Duplicated";
    }
    @PostMapping("/trains/check_train_number")
    public String checkDuplicateTrainNumber(@Param("id") Long id, @Param("trainNumber") String trainNumber) {
        return trainService.isTrainNumberUnique(id, trainNumber) ? "OK" : "Duplicated";
    }
    @PostMapping("/trips/check_trip_number")
    public String checkDuplicateTripNumber(@Param("id")Long id, @Param("routeNumber") String routeNumber){
        return tripService.isTripNumberUnique(id,routeNumber)?"OK" : "Duplicated";
    }
    @PostMapping("/trips/check_is_driver_free")
    private String isDriverAvailable(@Param("id")Long id, @Param("departureDate") String departureDate, @Param("arrivalDate") String arrivalDate,@Param("departureTime") String departureTime, @Param("arrivalTime") String arrivalTime) {
        return tripService.isDriverFree(userService.getUserById(id),departureDate,arrivalDate,departureTime,arrivalTime)?"OK" : "Duplicated";
    }
    @PostMapping("/trips/check_is_train_free")
    private String isTrainAvailable(@Param("id")Long id, @Param("departureDate") String departureDate, @Param("arrivalDate") String arrivalDate,@Param("departureTime") String departureTime, @Param("arrivalTime") String arrivalTime) {
        return tripService.isTrainFree(trainService.getTrainById(id),departureDate,arrivalDate,departureTime,arrivalTime)?"OK" : "Duplicated";
    }
//    public boolean isAvailable(LocalDateTime start, LocalDateTime end) {
//        for (TrainTrip trip : trainTrips) {
//            LocalDateTime tripStart = LocalDateTime.of(trip.getDepartureDate(), trip.getDepartureTime());
//            LocalDateTime tripEnd = LocalDateTime.of(trip.getArrivalDate(), trip.getArrivalTime());
//            if (start.isBefore(tripEnd) && end.isAfter(tripStart)) {
//                // Train is not available during this time period
//                return false;
//            }
//        }
//        return true;
//    }

}