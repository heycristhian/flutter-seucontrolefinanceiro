package com.seucontrolefinanceiro.repository;

import com.seucontrolefinanceiro.model.User;

import java.util.List;

public class UserRepository {

    List<User> findByName(String query) {
        System.out.println("findByName it's work in the UserRepository");
        List<User> users = null;
        return users;
    }

    public void save(User user) {
        System.out.println("save it's work in the UserRepository");
    }
}
