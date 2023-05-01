package com.example.demo.repos;


import com.example.demo.domain.Trip;
import com.example.demo.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TripRepo extends PagingAndSortingRepository<Trip, Long> {

    @Query("SELECT t FROM Trip t WHERE " +
            "LOWER(t.startPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "LOWER(t.endPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "t.routeNumber = ?1 OR " +
            "LOWER(t.driver.username) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "LOWER(t.trainTrips.train.trainName) LIKE LOWER(CONCAT('%', ?1, '%'))")
    Page<Trip> findAll(String query, Pageable pageable);

    @Query("SELECT t FROM Trip t WHERE " +
            "(LOWER(t.startPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "LOWER(t.endPoint) LIKE LOWER(CONCAT('%', ?1, '%')) OR " +
            "t.routeNumber = ?1 OR " +
            "LOWER(t.trainTrips.train.trainName) LIKE LOWER(CONCAT('%', ?1, '%'))) " +
            "AND t.driver.id = ?2")
    Page<Trip> findAllByUserId(String query, Long userId, Pageable pageable);

    @Query("SELECT t FROM Trip t WHERE t.driver.id = ?1")
    List<Trip> findAllByDriver(Long userId);
    @Override
    Iterable<Trip> findAll(Sort sort);

    @Query("SELECT t FROM Trip t WHERE  t.driver.id = ?1")
    Page<Trip> findAllByUserId(Long userId, Pageable pageable);

    Trip findByRouteNumber(String routeNumber);

    List<Trip> findByDriver(User driver);
}
