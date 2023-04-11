package com.example.demo.controller;

import com.example.demo.Exceptions.ResourceNotFoundException;
import com.example.demo.domain.Train;
import com.example.demo.service.TrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
public class TrainController {

    @Autowired
    private TrainService trainService;

    @GetMapping("/trains/create")
    public String createTrainForm(Model model) {
        model.addAttribute("train", new Train());
        return "create-train";
    }

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
    public String editTrainForm(@PathVariable("id") Integer id, Model model) throws ResourceNotFoundException {
        Train train = trainService.getTrainById(id);
        if (train == null) {
            throw new ResourceNotFoundException("Train not found with id: " + id);
        }
        model.addAttribute("train", train);
        return "edit-train";
    }

    @GetMapping("/trains/search")
    public ModelAndView searchTrains(@RequestParam("query") String query) {
        List<Train> trains = trainService.searchTrains(query);
        ModelAndView modelAndView = new ModelAndView("parts/trains-table");
        modelAndView.addObject("trains", trains);
        return modelAndView;
    }

    @PostMapping("/trains/{id}/update")
    public String updateTrain(@PathVariable("id") Integer id,
                              @ModelAttribute("train") @Valid Train train,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "edit-train";
        }

        train.setId(id);
        trainService.saveTrain(train);

        redirectAttributes.addFlashAttribute("message", "Train updated successfully!");
        return "redirect:/trains";
    }

    @PostMapping("/trains/{id}/delete")
    public String deleteTrain(@PathVariable("id") Integer id,
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
    public String getAllTrains(Model model) {
        List<Train> trains = trainService.getAllTrains();
        model.addAttribute("trains", trains);
        return "trains";
    }
}

