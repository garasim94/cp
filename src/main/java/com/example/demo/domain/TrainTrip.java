package com.example.demo.domain;

import javax.persistence.*;

@Entity
public class TrainTrip {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "train_id")
    private Train train;

    @OneToOne
    @JoinColumn(name = "trip_id")
    private Trip trip;

    // конструкторы, геттеры и сеттеры

    public TrainTrip() {
    }

    public TrainTrip(Long id, Train train, Trip trip) {
        this.id = id;
        this.train = train;
        this.trip = trip;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Train getTrain() {
        return train;
    }

    public void setTrain(Train train) {
        this.train = train;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }
}

