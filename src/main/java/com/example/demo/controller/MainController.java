package com.example.demo.controller;

import com.example.demo.domain.Role;
import com.example.demo.domain.Train;
import com.example.demo.domain.Trip;
import com.example.demo.domain.User;
import com.example.demo.repos.TripRepo;
import com.example.demo.service.TrainService;
import com.example.demo.service.TripService;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private UserService userService;
    @Autowired
    private TripService tripService;
    @Autowired
    private TrainService trainService;
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String firstPage(Model model) {
        return byPage("",1,"departureDate","asc",model);
    }

    @GetMapping("/page/{pageNum}")
    public String byPage(@RequestParam(defaultValue = "") String query,
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
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("query", query);

        return "greeting";
    }
}