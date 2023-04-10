package com.example.demo.repos;

import com.example.demo.domain.TrainTrip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TrainTripRepo extends JpaRepository<TrainTrip, Integer> {
}