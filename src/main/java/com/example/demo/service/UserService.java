package com.example.demo.service;

import com.example.demo.domain.Role;
import com.example.demo.domain.Train;
import com.example.demo.domain.User;
import com.example.demo.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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

    public static final int ITEM_PER_PAGE=10;

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

    public List<User> getAllUsers() {
        return (List<User>) userRepo.findAll();
    }


    public void saveUser(User user) {
        userRepo.save(user);
    }

    public void deleteUser(User user) {
        userRepo.delete(user);
    }

    public Page<User> getUsers(String query, String sort, String order, int pageNum) {
        Sort.Direction direction = Sort.Direction.fromString(order);
        Sort sorted = Sort.by(direction, sort);
        Pageable pageable = PageRequest.of(pageNum-1,ITEM_PER_PAGE,sorted);

        if (query != null && !query.isEmpty()) {
            return userRepo.findAll(query,pageable);
        }
        return userRepo.findAll(pageable);

    }
    public List<User> findAll(){
        return (List<User>) userRepo.findAll(Sort.by("id").ascending());
    }
}

