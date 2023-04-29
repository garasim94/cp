package com.example.demo.repos;


import com.example.demo.domain.Trip;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TripRepo extends PagingAndSortingRepository<Trip, Long> {

    @Query("SELECT t FROM Trip t WHERE " +
            "LOWER(t.startPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "LOWER(t.endPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "t.routeNumber = ?1 OR " +
            "LOWER(t.driver.username) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "LOWER(t.trainTrips.train.trainName) LIKE LOWER(CONCAT('%', ?1, '%'))")
    Page<Trip> findAll(String query, Pageable pageable);

    @Override
    Iterable<Trip> findAll(Sort sort);
}
