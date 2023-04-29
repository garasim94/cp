package com.example.demo.domain;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Train {

    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id;

    private String trainNumber;
    private String trainName;

    @OneToMany(mappedBy = "train")
    private Set<TrainTrip> trainTrips;


    public Train() {
    }

    public Train(Long id, String trainNumber, String trainName, Set<TrainTrip> trainTrips) {
        this.id = id;
        this.trainNumber = trainNumber;
        this.trainName = trainName;
        this.trainTrips = trainTrips;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTrainNumber() {
        return trainNumber;
    }

    public void setTrainNumber(String trainNumber) {
        this.trainNumber = trainNumber;
    }

    public String getTrainName() {
        return trainName;
    }

    public void setTrainName(String trainName) {
        this.trainName = trainName;
    }


    public Set<TrainTrip> getTrainTrips() {
        return trainTrips;
    }

    public void setTrainTrips(Set<TrainTrip> trainTrips) {
        this.trainTrips = trainTrips;
    }
}
