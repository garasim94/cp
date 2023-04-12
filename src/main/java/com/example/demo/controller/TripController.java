package com.example.demo.controller;

import com.example.demo.domain.*;
import com.example.demo.service.TrainService;
import com.example.demo.service.TrainTripService;
import com.example.demo.service.TripService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TripController {
    @Autowired
    private UserService userService;
    @Autowired
    private TripService tripService;
    @Autowired
    private TrainService trainService;
    @Autowired
    private TrainTripService trainTripService;
    @GetMapping("/trips")
    public String createTrip(Model model) {
        model.addAttribute("trainList", trainService.getAllTrains());
        model.addAttribute("drivers", userService.getUsersByRole(Role.DRIVER));
        return "create-trip";
    }
    @PostMapping("/trips/create")
    public String saveTrip(@RequestParam("text") String text,
                           @RequestParam("routeNumber") Integer routeNumber,
                           @RequestParam("trainId") Long trainId,
                           @RequestParam("authorId") Long authorId,
                           Model model) {
        User author = userService.getUserById(authorId);
        Train train = trainService.getTrainById(trainId);

        Trip trip = new Trip();
        trip.setText(text);
        trip.setRouteNumber(routeNumber);
        trip.setAuthor(author);

        TrainTrip trainTrip = new TrainTrip();
        trainTrip.setTrip(trip);
        trainTrip.setTrain(train);

        tripService.saveTrip(trip);
        trainTripService.saveTrainTrip(trainTrip);

        return "redirect:/trips";
    }
}
