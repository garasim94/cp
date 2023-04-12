package com.example.demo.domain;


import javax.persistence.*;
import java.util.Set;

@Entity
public class Trip {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;



    private Integer routeNumber;
    private String text;

    private String route;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    @OneToOne(mappedBy = "trip")
    private TrainTrip trainTrips;

    public Trip() {
    }

    public Trip(Long id, String text, String filename, User author, TrainTrip trainTrips) {
        this.id = id;
        this.text = text;
        this.author = author;
        this.trainTrips = trainTrips;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }


    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public TrainTrip getTrainTrips() {
        return trainTrips;
    }

    public void setTrainTrips(TrainTrip trainTrips) {
        this.trainTrips = trainTrips;
    }
    public Integer getRouteNumber() {
        return routeNumber;
    }

    public void setRouteNumber(Integer routeNumber) {
        this.routeNumber = routeNumber;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public Trip(Long id, Integer routeNumber, String text, String route, User author, TrainTrip trainTrips) {
        this.id = id;
        this.routeNumber = routeNumber;
        this.text = text;
        this.route = route;
        this.author = author;
        this.trainTrips = trainTrips;
    }
}
