package com.example.demo.service;

import com.example.demo.domain.Role;
import com.example.demo.domain.User;
import com.example.demo.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }
    public List<User> getUsersByRole(Role role) {
        return userRepo.findByRolesContaining(role);
    }
    public User getUserById(Long id) {
        Optional<User> user = userRepo.findById(id);
        return user.orElse(null);
    }

    public Optional<User> findById(Long driverId) {
        return userRepo.findById(driverId);
    }
}

