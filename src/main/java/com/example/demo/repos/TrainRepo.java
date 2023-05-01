package com.example.demo.repos;

import com.example.demo.domain.Train;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrainRepo extends PagingAndSortingRepository<Train, Long>{

    @Query("SELECT t FROM Train t WHERE LOWER(t.trainName) " + "LIKE LOWER(CONCAT('%', ?1, '%')) OR LOWER(t.trainNumber) " + "LIKE LOWER(CONCAT('%', ?1, '%'))")
    Page<Train> findAll(String query, Pageable pageable);

    @Override
    Iterable<Train> findAll(Sort sort);

    @Query(value = "SELECT t FROM Train t WHERE EXISTS (SELECT i FROM Issue i WHERE i.train = t) ORDER BY t.id")
    Page<Train> findTrainsWithIssues(Pageable pageable);

    Train findByTrainNumber(String trainNumber);
}
