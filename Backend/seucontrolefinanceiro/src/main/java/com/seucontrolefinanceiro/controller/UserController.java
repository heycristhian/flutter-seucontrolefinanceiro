package com.seucontrolefinanceiro.controller;

import com.seucontrolefinanceiro.model.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("scf-service/user")
public class UserController {

    @GetMapping
    public List<User> find(String query) {
        List<User> users;
        User user = new User("Cris", "hey", "123", "sss");
        users = Arrays.asList(user, user, user);
        return users;
    }
}
