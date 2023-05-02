package com.example.demo.controller;

import com.example.demo.Exceptions.ResourceNotFoundException;
import com.example.demo.domain.Role;
import com.example.demo.domain.User;
import com.example.demo.exporter.UserExcelExporter;
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

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/users")
    public String firstPage(Model model) {
        return usersByPage("",1,"id","asc",model);
    }
    @GetMapping("/users/page/{pageNum}")
    public String usersByPage(@RequestParam(defaultValue = "") String query,
                              @PathVariable(name = "pageNum") int pageNum,
                              @RequestParam(defaultValue = "id") String sort,
                              @RequestParam(defaultValue = "asc") String order,
                              Model model) {
        Page<User> pageOfUsers = userService.getUsers(query, sort, order,pageNum);
        List<User> users= pageOfUsers.getContent();
        Integer currentPage=pageNum;
        Long startCount= Long.valueOf((pageNum-1)* userService.ITEM_PER_PAGE+1);
        Long endCount=startCount+userService.ITEM_PER_PAGE-1;

        model.addAttribute("totalItems",pageOfUsers.getTotalElements());
        model.addAttribute("totalPages",pageOfUsers.getTotalPages());
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("startCount",startCount);
        model.addAttribute("endCount",endCount);
        model.addAttribute("users", users);
        model.addAttribute("sort", sort);
        model.addAttribute("order", order);
        model.addAttribute("query", query);
        model.addAttribute("roles",Role.values());
        return "userList";
    }

    @GetMapping("/users/{id}/edit")
    public String editTrainForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) throws ResourceNotFoundException {
        User user = userService.getUserById(id);

        if (user == null) {
            redirectAttributes.addFlashAttribute("message", "User not found");
            return "redirect:/users";
        }
        model.addAttribute("roles",Role.values());
        model.addAttribute("user", user);
        return "userEdit";
    }

    @PostMapping("/users/save")
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user,
            @RequestParam("isActive") boolean isActive,
            RedirectAttributes redirectAttributes
    )  {
        user.setUsername(username);
        user.setActive(isActive);
        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
            user.getRoles().add(Role.valueOf(key));        }
        }    userService.saveUser(user);
        redirectAttributes.addFlashAttribute("message",
                "User updated successfully!");
        return "redirect:/users";}
    @PostMapping("/users/create")
    public String createUser(@RequestParam String username,
                             @RequestParam String password,
                             @RequestParam Map<String, String> form,
                             RedirectAttributes redirectAttributes){
        User user= new User();
        user.setUsername(username);
        user.setPassword(password);


        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userService.saveUser(user);
        redirectAttributes.addFlashAttribute("message", "User created successfully!");
        return "redirect:/users";
    }
    @GetMapping("/users/export")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        String headerKey="Content-Disposition";

        DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());
        String fileName = "users_" + currentDateTime + ".xlsx";
        String headerValue = "attachment; filename=" + fileName;

        response.setHeader(headerKey,headerValue);
        List<User> users=userService.findAll();

        UserExcelExporter excelExporter=new UserExcelExporter(users);
        excelExporter.export(response);
    }
    @PostMapping("/users/{id}/delete")
    public String deleteTrain(@PathVariable("id") Long id,
                              RedirectAttributes redirectAttributes) throws ResourceNotFoundException {
        User user = userService.getUserById(id);
        if (user == null) {
            redirectAttributes.addFlashAttribute("message", "User not found");
            return "redirect:/users";
        }
        userService.deleteUser(user);

        redirectAttributes.addFlashAttribute("message", "User deleted successfully!");
        return "redirect:/users";
    }
}
