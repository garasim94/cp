package com.example.demo.service;

import com.example.demo.domain.Train;
import com.example.demo.repos.TrainRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TrainService {
    @Autowired
    private TrainRepo trainRepo;

    public List<Train> getAllTrains() {
        return trainRepo.findAll();
    }

    public Train getTrainById(Integer id) {
        Optional<Train> trainOptional = trainRepo.findById(id);
        return trainOptional.orElse(null);
    }

    public void saveTrain(Train train) {
        trainRepo.save(train);
    }

    public void deleteTrain(Train train) {
        trainRepo.delete(train);
    }
    public List<Train> searchTrains(String query) {
        List<Train> trainsByNumber = trainRepo.searchByTrainNumber(query);
        List<Train> trainsByName = trainRepo.searchByTrainName(query);
        Set<Train> trainsSet = new HashSet<>();
        trainsSet.addAll(trainsByNumber);
        trainsSet.addAll(trainsByName);
        return new ArrayList<>(trainsSet);
    }

}
