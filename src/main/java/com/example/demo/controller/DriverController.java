package com.example.demo.controller;

import com.example.demo.domain.Trip;
import com.example.demo.domain.User;
import com.example.demo.exporter.DriverExcelExporter;
import com.example.demo.service.DriverService;
import com.example.demo.service.TrainService;
import com.example.demo.service.TripService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class DriverController {
    @Autowired
    private TrainService trainService;

    @Autowired
    private TripService tripService;

    @Autowired
    private DriverService driverService;

    @GetMapping("/driver_trips")
    public String firstPage(@AuthenticationPrincipal User user, Model model){
        return tripsByPage(user,"",1,"id","asc",model);
    }
    @GetMapping("/driver_trips/page/{pageNum}")
    public String tripsByPage(@AuthenticationPrincipal User user,
                              @RequestParam(defaultValue = "") String query,
                              @PathVariable(name = "pageNum") int pageNum,
                              @RequestParam(defaultValue = "id") String sort,
                              @RequestParam(defaultValue = "asc") String order,
                              Model model) {
        Page<Trip> pageOfTrips = tripService.getTrips(user.getId(),query,sort,order,pageNum);
        List<Trip> driversTrips= pageOfTrips.getContent();
        Integer currentPage=pageNum;
        Long startCount= Long.valueOf((pageNum-1)* trainService.ITEM_PER_PAGE+1);
        Long endCount=startCount+driverService.ITEM_PER_PAGE-1;

        model.addAttribute("totalItems",pageOfTrips.getTotalElements());
        model.addAttribute("totalPages",pageOfTrips.getTotalPages());
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("startCount",startCount);
        model.addAttribute("endCount",endCount);
        model.addAttribute("trips", driversTrips);
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("query", query);

        return "drivers_trips";
    }
    @GetMapping("/driver_trips/export")
    public void exportToExcel(@AuthenticationPrincipal User user,HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        String headerKey="Content-Disposition";

        DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());
        String fileName = "trips_" + currentDateTime + ".xlsx";
        String headerValue = "attachment; filename=" + fileName;

        response.setHeader(headerKey,headerValue);
        List<Trip> trips=tripService.findAllByDriver(user.getId());

        DriverExcelExporter excelExporter=new DriverExcelExporter(trips);
        excelExporter.export(response);
    }
    @GetMapping("/driver_trips/change_status/{id}/{status}")
    public String change_status(@PathVariable(name="id") Long id, @PathVariable(name="status") String status,RedirectAttributes redirectAttributes, Model model){
        tripService.changeStatus(id, status);
        return "redirect:/driver_trips";
    }
}
