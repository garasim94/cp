package com.example.demo.service;

import com.example.demo.domain.*;
import com.example.demo.repos.TripRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
public class TripService {
    @Autowired
    private TripRepo tripRepo;
    @Autowired
    private TrainTripService trainTripService;
    public static final int ITEM_PER_PAGE=10;

    public void saveTrip(Trip trip) {
        tripRepo.save(trip);
    }

    public Trip getTripById(Long id) {
        return tripRepo.findById(id).orElse(null);
    }

    public List<Trip> findAll() {
        return (List<Trip>) tripRepo.findAll(Sort.by("id").ascending());
    }
    public void deleteTrip(Trip trip){
        tripRepo.delete(trip);
    }
    public void save(Trip trip) {
        tripRepo.save(trip);
    }
    public Page<Trip> getTrips(String query, String sort, String order, int pageNum) {
        Sort.Direction direction = Sort.Direction.fromString(order);
        Sort sorted = Sort.by(direction, sort);
        Pageable pageable = PageRequest.of(pageNum-1,ITEM_PER_PAGE,sorted);

        if (query != null && !query.isEmpty()) {
            return tripRepo.findAll(query,pageable);
        }
        return tripRepo.findAll(pageable);
    }

    public Page<Trip> getActualTrips(String query, String sort, String order, int pageNum) {
        Sort.Direction direction = Sort.Direction.fromString(order);
        Sort sorted = Sort.by(direction, sort);
        Pageable pageable = PageRequest.of(pageNum-1,ITEM_PER_PAGE,sorted);

        if (query != null && !query.isEmpty()) {
            return tripRepo.findActualTrips(query,pageable);
        }
        return tripRepo.findActualTrips(pageable);
    }
    public Page<Trip> getTrips(Long userId, String query, String sort, String order, int pageNum) {
        Sort.Direction direction = Sort.Direction.fromString(order);
        Sort sorted = Sort.by(direction, sort);
        Pageable pageable = PageRequest.of(pageNum-1, ITEM_PER_PAGE, sorted);

        if (query != null && !query.isEmpty()) {
            return tripRepo.findAllByUserId(query, userId, pageable);
        }
        return tripRepo.findAllByUserId(userId,pageable);
    }
    public List<Trip> findAllByDriver(Long userId){
        return tripRepo.findAllByDriver(userId);
    }
    public boolean changeStatus(Long id,String status) {
        Trip trip= getTripById(id);
        if(trip==null) return false;
        switch (status) {
            case "accept":
                trip.setStatus(Status.ACCEPT);
                break;
            case "deny":
                trip.setStatus(Status.DENIED);
                break;
            default:
                return false;
        }
        tripRepo.save(trip);
        return true;
    }

    public boolean isTripNumberUnique(Long id, String routeNumber) {
        Trip tripByTripNumber=tripRepo.findByRouteNumber(routeNumber);
        if(tripByTripNumber==null){
            return true;
        }
        boolean isCreatingNew=(id==null);
        if(isCreatingNew){
            if(tripByTripNumber!=null) return false;
        }else {
            if(tripByTripNumber.getId()!=id){
                return false;
            }
        }
        return true;
    }

    public boolean isDriverFree(User driver, String departureDate, String arrivalDate,String departureTime,String arrivalTime) {
        List<Trip> trips = tripRepo.findByDriver(driver);
        if(trips.isEmpty()) return true;
        LocalDateTime newTripDepartureDateTime =LocalDateTime.of(LocalDate.parse(departureDate), LocalTime.parse(departureTime));
        LocalDateTime newTripArrivalDateTime=LocalDateTime.of(LocalDate.parse(arrivalDate), LocalTime.parse(arrivalTime));
        for (Trip trip : trips) {
            LocalDateTime tripDepartureDateTime = LocalDateTime.of(trip.getDepartureDate(), trip.getDepartureTime());
            LocalDateTime tripArrivalDateTime = LocalDateTime.of(trip.getArrivalDate(), trip.getArrivalTime());
            if ((newTripDepartureDateTime.isEqual(tripDepartureDateTime) || newTripDepartureDateTime.isAfter(tripDepartureDateTime))
                    && newTripDepartureDateTime.isBefore(tripArrivalDateTime)) {
                return false;
            }
            if ((newTripArrivalDateTime.isEqual(tripDepartureDateTime) || newTripArrivalDateTime.isAfter(tripDepartureDateTime))
                    && newTripArrivalDateTime.isBefore(tripArrivalDateTime)) {
                return false;
            }
        }
        return true;
    }
    public boolean isTrainFree(Train train, String departureDate, String arrivalDate,String departureTime,String arrivalTime) {
        List<TrainTrip> trainTrips = train.getTrainTrips().stream().toList();
        if(trainTrips.isEmpty()) return true;
        LocalDateTime newTripDepartureDateTime =LocalDateTime.of(LocalDate.parse(departureDate), LocalTime.parse(departureTime));
        LocalDateTime newTripArrivalDateTime=LocalDateTime.of(LocalDate.parse(arrivalDate), LocalTime.parse(arrivalTime));
        for (TrainTrip trainTrip : trainTrips) {
            LocalDateTime tripDepartureDateTime = LocalDateTime.of(trainTrip.getTrip().getDepartureDate(), trainTrip.getTrip().getDepartureTime());
            LocalDateTime tripArrivalDateTime = LocalDateTime.of(trainTrip.getTrip().getArrivalDate(), trainTrip.getTrip().getArrivalTime());
            if ((newTripDepartureDateTime.isEqual(tripDepartureDateTime) || newTripDepartureDateTime.isAfter(tripDepartureDateTime))
                    && newTripDepartureDateTime.isBefore(tripArrivalDateTime)) {
                return false;
            }
            if ((newTripArrivalDateTime.isEqual(tripDepartureDateTime) || newTripArrivalDateTime.isAfter(tripDepartureDateTime))
                    && newTripArrivalDateTime.isBefore(tripArrivalDateTime)) {
                return false;
            }
        }
        return true;
    }
}