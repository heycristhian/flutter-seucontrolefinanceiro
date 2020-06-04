package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> find(String query) {
        if(query == null) {
            return userRepository.findAll();
        }
        return userRepository.findAll();
    }

    public User findById(String id) {
        Optional<User> obj = userRepository.findById(id);
        return obj.orElseThrow(() -> new ObjectNotFoundException("Object not found!")); }

}