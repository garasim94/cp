package com.example.demo.controller;

import com.example.demo.domain.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AccountController {
    @Autowired
    private UserService userService;

    @GetMapping("/account")
    public String viewDetails(@AuthenticationPrincipal User loggedUser, Model model){
        model.addAttribute("user",loggedUser);
        return "account_form";
    }

    @PostMapping("/account/update")
    public String updateUser(@ModelAttribute("user") User user, RedirectAttributes redirectAttributes){
        userService.updateUser(user);
        redirectAttributes.addFlashAttribute("message","Your details have been changed.");
        return "redirect:/account";
    }
}
