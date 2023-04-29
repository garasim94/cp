package com.example.demo.service;

import com.example.demo.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DriverService {
    @Autowired
    private UserRepo userRepo;

    public static final int ITEM_PER_PAGE=10;
}
