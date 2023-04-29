package com.example.demo.service;

import com.example.demo.domain.Trip;
import com.example.demo.repos.TripRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TripService {
    @Autowired
    private TripRepo tripRepo;
    public static final int ITEM_PER_PAGE=10;

    public void saveTrip(Trip trip) {
        tripRepo.save(trip);
    }

    public Trip getTripById(Long id) {
        return tripRepo.findById(id).orElse(null);
    }

    public List<Trip> FindAll() {
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
}
