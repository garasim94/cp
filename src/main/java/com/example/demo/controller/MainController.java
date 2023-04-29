package com.example.demo.controller;

import com.example.demo.domain.Role;
import com.example.demo.domain.Trip;
import com.example.demo.domain.User;
import com.example.demo.repos.TripRepo;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    //    @Autowired
//    private TripRepo tripRepo;
    @Autowired
    private UserService userService;
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

//    @GetMapping("/main")
//    public String main(@RequestParam(required = false, defaultValue = "")Integer filter, Model model) {
//        Iterable<Trip> trips = tripRepo.findAll();
//        List<User> drivers= userService.getUsersByRole(Role.DRIVER);
//        if (filter != null) {
//            trips = tripRepo.findByRouteNumber(filter);
//        } else {
//            trips = tripRepo.findAll();
//        }
//
//        model.addAttribute("trips", trips);
//        model.addAttribute("filter", filter);
//        model.addAttribute("drivers", drivers);
//        return "main";
//    }

//    @PostMapping("/main/save")
//    public String add(
////            @AuthenticationPrincipal User user,
//            //            @RequestParam("file") MultipartFile file
//            @RequestParam("id") Long userId,
//            @RequestParam String text,
//            @RequestParam String tag, Map<String, Object> model) throws IOException {
//        User user=userService.getUserById(userId);
//        Trip trip = new Trip(text, tag, user);
//
////        if (file != null && !file.getOriginalFilename().isEmpty()) {
////            File uploadDir = new File(uploadPath);
////
////            if (!uploadDir.exists()) {
////                uploadDir.mkdir();
////            }
////
////            String uuidFile = UUID.randomUUID().toString();
////            String resultFilename = uuidFile + "." + file.getOriginalFilename();
////
////            file.transferTo(new File(uploadPath + "/" + resultFilename));
////
////            trip.setFilename(resultFilename);
////        }
//
//        tripRepo.save(trip);
//
//        Iterable<Trip> trips = tripRepo.findAll();
//
//        model.put("trips", trips);
//
//        return "redirect:/main";
//    }
}