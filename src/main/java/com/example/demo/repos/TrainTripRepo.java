package com.example.demo.repos;

import com.example.demo.domain.TrainTrip;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrainTripRepo extends PagingAndSortingRepository<TrainTrip, Long>, CrudRepository<TrainTrip,Long> {
}