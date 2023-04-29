package com.example.demo.service;

import com.example.demo.domain.TrainTrip;
import com.example.demo.repos.TrainTripRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainTripService {
    @Autowired
    private TrainTripRepo trainTripRepo;

    public void saveTrainTrip(TrainTrip trainTrip) {
        trainTripRepo.save(trainTrip);
    }

    public List<TrainTrip> getAllTrainTrips() {
        return (List<TrainTrip>) trainTripRepo.findAll();
    }

    public TrainTrip getTrainTripById(Long id) {
        return trainTripRepo.findById(id).orElse(null);
    }

    public void save(TrainTrip trainTrip) {
        trainTripRepo.save(trainTrip);
    }

    public void delete(TrainTrip trainTrip) {
        trainTripRepo.delete(trainTrip);
    }
}
