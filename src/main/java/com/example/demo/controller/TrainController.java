package com.example.demo.controller;

import com.example.demo.Exceptions.ResourceNotFoundException;
import com.example.demo.domain.Issue;
import com.example.demo.domain.Train;
import com.example.demo.exporter.TrainExcelExporter;
import com.example.demo.service.IssueService;
import com.example.demo.service.TrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class TrainController {

    @Autowired
    private TrainService trainService;
    @Autowired
    private IssueService issueService;

    @PostMapping("/trains/create")
    public String saveTrain(@RequestParam("trainNumber") String trainNumber,
                            @RequestParam("trainName") String trainName) {
        Train train = new Train();
        train.setTrainNumber(trainNumber);
        train.setTrainName(trainName);

        trainService.saveTrain(train);

        return "redirect:/trains";
    }

    @GetMapping("/trains/{id}/edit")
    public String editTrainForm(@PathVariable("id") Long id, Model model,RedirectAttributes redirectAttributes) throws ResourceNotFoundException {
        Train train = trainService.getTrainById(id);
        if (train == null) {
            redirectAttributes.addFlashAttribute("message", "Train not found");
            return "redirect:/trains";
        }
        model.addAttribute("train", train);
        return "edit-train";
    }

    @PostMapping("/trains/{id}/update")
    public String updateTrain(@PathVariable("id") Long id,
                              @ModelAttribute("train") @Valid Train train,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "edit-train";
        }
        train.setId(id);
        issueService.deleteIssueAfterEdit(trainService.getTrainById(id));
        trainService.saveTrain(train);

        redirectAttributes.addFlashAttribute("message", "Train updated successfully!");
        return "redirect:/trains";
    }

    @PostMapping("/trains/{id}/delete")
    public String deleteTrain(@PathVariable("id") Long id,
                              RedirectAttributes redirectAttributes) throws ResourceNotFoundException {
        Train train = trainService.getTrainById(id);
        if (train == null) {
            throw new ResourceNotFoundException("Train not found with id: " + id);
        }
        trainService.deleteTrain(train);

        redirectAttributes.addFlashAttribute("message", "Train deleted successfully!");
        return "redirect:/trains";
    }
    @GetMapping("/trains")
    public String firstPage(Model model){
        return trainsByPage("",1,"id","asc",model);
    }
    @GetMapping("/trains/page/{pageNum}")
    public String trainsByPage(@RequestParam(defaultValue = "") String query,
                               @PathVariable(name = "pageNum") int pageNum,
                               @RequestParam(defaultValue = "id") String sort,
                               @RequestParam(defaultValue = "asc") String order,
                               Model model) {
        Page<Train> pageOfTrains = trainService.getTrains(query, sort, order,pageNum);
        List<Train> trains= pageOfTrains.getContent();
        Integer currentPage=pageNum;
        Long startCount= Long.valueOf((pageNum-1)* trainService.ITEM_PER_PAGE+1);
        Long endCount=startCount+trainService.ITEM_PER_PAGE-1;

        model.addAttribute("totalItems",pageOfTrains.getTotalElements());
        model.addAttribute("totalPages",pageOfTrains.getTotalPages());
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("startCount",startCount);
        model.addAttribute("endCount",endCount);
        model.addAttribute("trains", trains);
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("query", query);

        return "trains";
    }
    @GetMapping("/trains/export")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        String headerKey="Content-Disposition";

        DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());
        String fileName = "train_" + currentDateTime + ".xlsx";
        String headerValue = "attachment; filename=" + fileName;

        response.setHeader(headerKey,headerValue);
        List<Train> trains=trainService.findAll();

        TrainExcelExporter excelExporter=new TrainExcelExporter(trains);
        excelExporter.export(response);
    }

}

