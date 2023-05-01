package com.example.demo.service;

import com.example.demo.domain.Issue;
import com.example.demo.domain.Status;
import com.example.demo.domain.Train;
import com.example.demo.domain.User;
import com.example.demo.repos.TrainRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TrainService {
    @Autowired
    private TrainRepo trainRepo;
    public static final int ITEM_PER_PAGE=10;
    public List<Train> getAllTrains() {
        return (List<Train>) trainRepo.findAll();
    }

    public Train getTrainById(Long id) {
        Optional<Train> trainOptional = trainRepo.findById(id);
        return trainOptional.orElse(null);
    }

    public void saveTrain(Train train) {
        trainRepo.save(train);
    }

    public void deleteTrain(Train train) {
        trainRepo.delete(train);
    }

    public Page<Train> getTrains(String query, String sort, String order, int pageNum) {
        Sort.Direction direction = Sort.Direction.fromString(order);
        Sort sorted = Sort.by(direction, sort);

        Pageable  pageable = PageRequest.of(pageNum-1,ITEM_PER_PAGE,sorted);

        if (query != null && !query.isEmpty()) {
            return trainRepo.findAll(query,pageable);
        }
        return trainRepo.findAll(pageable);

    }
    public List<Train> findAll(){
        return (List<Train>) trainRepo.findAll(Sort.by("id").ascending());
    }

    public Optional<Train> findById(Long trainId) {
        return trainRepo.findById(trainId);
    }


    public boolean isTrainNumberUnique(Long id, String trainNumber) {
        Train trainByTrainNumber=trainRepo.findByTrainNumber(trainNumber);
        if(trainByTrainNumber==null){return true;
        }
        boolean isCreatingNew=(id==null);
        if(isCreatingNew){
            if(trainByTrainNumber!=null) return false;
        }else {
            if(trainByTrainNumber.getId()!=id){
                return false;
            }
        }
        return true;
    }
}
