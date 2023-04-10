package com.example.demo.repos;

import com.example.demo.domain.Trip;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TripRepo extends CrudRepository<Trip,Integer> {
    List<Trip> findByRouteNumber(Integer routeNumber);
}
