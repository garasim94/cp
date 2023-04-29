package com.example.demo.controller;

import com.example.demo.Exceptions.ResourceNotFoundException;
import com.example.demo.domain.*;
import com.example.demo.service.TrainService;
import com.example.demo.service.TrainTripService;
import com.example.demo.service.TripService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

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
    public String firstPage(Model model) {
        return tripsByPage("",1,"id","asc",model);
    }
    @PostMapping("/trips/{id}/delete")
    public String deleteTrip(@PathVariable("id") Long id,
                             RedirectAttributes redirectAttributes) throws ResourceNotFoundException {
        Trip trip = tripService.getTripById(id);
        if (trip == null) {
            throw new ResourceNotFoundException("Train not found with id: " + id);
        }

        trainTripService.delete(trip.getTrainTrips());
        tripService.deleteTrip(trip);

        redirectAttributes.addFlashAttribute("message", "Train deleted successfully!");
        return "redirect:/trips";
    }
    @GetMapping("/trips/page/{pageNum}")
    public String tripsByPage(@RequestParam(defaultValue = "") String query,
                              @PathVariable(name = "pageNum") int pageNum,
                              @RequestParam(defaultValue = "id") String sort,
                              @RequestParam(defaultValue = "asc") String order,
                              Model model) {
        Page<Trip> pageOfTrips = tripService.getTrips(query, sort, order,pageNum);
        List<Train> trainList= trainService.getAllTrains();
        List<Trip> tripList= pageOfTrips.getContent();
        Integer currentPage=pageNum;
        Long startCount= Long.valueOf((pageNum-1)* tripService.ITEM_PER_PAGE+1);
        Long endCount=startCount+tripService.ITEM_PER_PAGE-1;

        model.addAttribute("totalItems",pageOfTrips.getTotalElements());
        model.addAttribute("totalPages",pageOfTrips.getTotalPages());
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("startCount",startCount);
        model.addAttribute("endCount",endCount);
        model.addAttribute("trainList", trainList);
        model.addAttribute("tripList", tripList);
        model.addAttribute("driverList", userService.getUsersByRole(Role.DRIVER));
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("query", query);

        return "trips";
    }
    @PostMapping("/trips/save")
    public String saveTrip(@RequestParam("departureDate") String departureDateString,
                           @RequestParam("arrivalDate") String arrivalDateString,
                           @RequestParam("departureTime") String departureTime,
                           @RequestParam("arrivalTime") String arrivalTime,
                           @RequestParam("startPoint") String startPoint,
                           @RequestParam("endPoint") String endPoint,
                           @RequestParam("routeNumber") String routeNumber,
                           @RequestParam("driverId") Long driverId,
                           @RequestParam("trainId") Long trainId) throws ParseException {

        Trip trip = new Trip();

        trip.setDepartureDate(LocalDate.parse(departureDateString));
        trip.setArrivalDate(LocalDate.parse(arrivalDateString));
        trip.setDepartureTime(LocalTime.parse(departureTime));
        trip.setArrivalTime(LocalTime.parse(arrivalTime));
        trip.setStartPoint(startPoint);
        trip.setEndPoint(endPoint);
        trip.setRouteNumber(routeNumber);

        User driver = userService.findById(driverId).orElseThrow(() -> new RuntimeException("Driver not found"));
        trip.setDriver(driver);
        Train train = trainService.findById(trainId).orElseThrow(() -> new RuntimeException("Train not found"));

        tripService.save(trip);

        TrainTrip trainTrip = new TrainTrip();
        trainTrip.setTrain(train);
        trainTrip.setTrip(trip);

        trainTripService.save(trainTrip);

        return "redirect:/trips";
    }

}
