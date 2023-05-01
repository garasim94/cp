package com.example.demo.controller;

import com.example.demo.domain.Issue;
import com.example.demo.domain.Status;
import com.example.demo.domain.Train;
import com.example.demo.domain.Trip;
import com.example.demo.service.IssueService;
import com.example.demo.service.TrainService;
import com.example.demo.service.TripService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class IssueController {
    @Autowired
    private IssueService issueService;
    @Autowired
    private TripService tripService;

    @Autowired
    private TrainService trainService;

    @PostMapping("/issue/save")
    private String saveIssue(@RequestParam String message,
                             @RequestParam Long tripId,
                             @RequestParam String type,
                             RedirectAttributes redirectAttributes){
        try {
            Trip trip=tripService.getTripById(tripId);
            trip.setStatus(Status.DENIED);
            Issue issue=issueService.createIssue(message);
            if(trip==null)
                throw new Exception("Trip doesn't exist");
            switch(type){
                case "trip":;
                    break;
                case "train":;
                    break;
            }
            switch(type){
                case "trip":trip.getIssues().add(issue);
                    tripService.saveTrip(trip);
                    issue.setTrip(trip);
                    break;
                case "train":trip.getTrainTrips().getTrain().getIssues().add(issue);
                    trainService.saveTrain(trip.getTrainTrips().getTrain());
                    issue.setTrain(trip.getTrainTrips().getTrain());
                    break;
            }
            issueService.save(issue);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message","Error while reporting issue: " + e.getMessage());
        }
        redirectAttributes.addFlashAttribute("message","Issue has been reported successfully!");
        return "redirect:/driver_trips";
    }


    @GetMapping("/trips/issue/{tripId}/change_status/{id}/{status}")
    public String change_status_trip(@PathVariable(name="tripId") Long tripId,@PathVariable(name="id") Long id, @PathVariable(name="status") String status, RedirectAttributes redirectAttributes, Model model){
        issueService.changeStatus(id, status);
        return "redirect:/trips/issue/"+tripId;
    }
    @GetMapping("/trains/issue/{trainId}/change_status/{id}/{status}")
    public String change_status_train(@PathVariable(name="trainId") Long trainId,@PathVariable(name="id") Long id, @PathVariable(name="status") String status, RedirectAttributes redirectAttributes, Model model){
        issueService.changeStatus(id, status);
        return "redirect:/trains/issue/"+trainId;
    }
    @GetMapping("/trains/issue/{trainId}")
    public String viewIssueTrain(@PathVariable("trainId") Long id, Model model){
        Train train=trainService.getTrainById(id);
        List<Issue> issues = new ArrayList<>(train.getIssues());
        model.addAttribute("issues",issues);
        model.addAttribute("train",train);
        return "train_issue";
    }
    @GetMapping("/trips/issue/{tripId}")
    public String viewIssueTrip(@PathVariable("tripId") Long id, Model model){
        Trip trip=tripService.getTripById(id);
        List<Issue> issues = new ArrayList<>(trip.getIssues());
        model.addAttribute("issues",issues);
        model.addAttribute("trip",trip);
        return "trip_issue";
    }
}
