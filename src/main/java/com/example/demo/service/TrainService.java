package com.example.demo.service;

import com.example.demo.domain.Train;
import com.example.demo.repos.TrainRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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
}
