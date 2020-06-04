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

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findById(String id) {
        Optional<User> obj = userRepository.findById(id);
        return obj.orElseThrow(() -> new ObjectNotFoundException("Object not found!"));
    }

    public User insert(User user) {
        User insert = userRepository.insert(user);
        return insert;
    }

    public void delete(String id) {
        findById(id);
        userRepository.deleteById(id);
    }

    public User update(User newUser) {
        User currentUser = findById(newUser.getId());
        updateData(currentUser, newUser);
        return userRepository.save(currentUser);
    }

    private void updateData(User currentUser, User newUser) {
        currentUser.setFullName(newUser.getFullName());
        currentUser.setUser(newUser.getUser());
        currentUser.setPassword(newUser.getPassword());
        currentUser.setCpf(newUser.getCpf());
    }

}
