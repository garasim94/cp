package com.example.demo.repos;

import com.example.demo.domain.Train;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrainRepo extends JpaRepository<Train, Long> {
    @Query("SELECT t FROM Train t WHERE t.trainNumber LIKE %:query%")
    List<Train> searchByTrainNumber(@Param("query") String query);

    @Query("SELECT t FROM Train t WHERE t.trainName LIKE %:query%")
    List<Train> searchByTrainName(@Param("query") String query);

}
