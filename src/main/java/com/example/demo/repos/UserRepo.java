package com.example.demo.repos;

import com.example.demo.domain.Role;
import com.example.demo.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;
@Repository
public interface UserRepo extends PagingAndSortingRepository<User,Long> {
    User findByUsername(String username);
    Optional<User> findById(Long id);
    List<User> findByRolesContaining(Role role);
    @Query("SELECT u FROM User u WHERE LOWER(u.username) LIKE LOWER(CONCAT('%',?1,'%')) ")
    Page<User> findAll(String query, Pageable pageable);
    @Override
    Iterable<User> findAll(Sort sort);

}