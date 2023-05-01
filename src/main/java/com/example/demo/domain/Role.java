package com.example.demo.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {

    DEPOTMANAGER, ADMIN,DISPATCHER,DRIVER;

    @Override
    public String getAuthority() {
        return name();
    }
}
