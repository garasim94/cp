package com.example.demo.service;

import com.example.demo.domain.Trip;
import com.example.demo.repos.TripRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TripService {
    @Autowired
    private TripRepo tripRepo;

    public void saveTrip(Trip trip) {
        tripRepo.save(trip);
    }

    public List<Trip> getAllTrips() {
        return (List<Trip>) tripRepo.findAll();
    }


    public Trip getTripById(Integer id) {
        return tripRepo.findById(id).orElse(null);
    }
}
