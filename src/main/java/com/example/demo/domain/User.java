package com.example.demo.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "usr")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String password;
    private boolean active;

    @OneToMany(mappedBy = "user")
    private Set<Issue> issues;
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;

    @OneToMany(mappedBy = "driver")
    private List<Trip> trips;

    public User(Long id, String username, String password, boolean active, Set<Role> roles, List<Trip> trips) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.active = active;
        this.roles = roles;
        this.trips = trips;
    }

    public User() {
        this.roles= new HashSet<>();
        this.issues=new HashSet<>();
    }

    public List<Trip> getTrips() {
        return trips;
    }

    public void setTrips(List<Trip> trips) {
        this.trips = trips;
    }

    public boolean isAdmin() {
        return roles.contains(Role.ADMIN);
    }

    public boolean isUser() {
        return roles.contains(Role.USER);
    }

    public boolean hasRole(){
        return roles.isEmpty();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Set<Role> getRoles() {
        return roles;
    }
    public String getRolesString(){
        String string = String.join(", ",this.roles.stream().map(Role::name).toArray(String[]::new));
        return string;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
    public boolean hasTrip(){
        return this.trips.isEmpty();
    }
}