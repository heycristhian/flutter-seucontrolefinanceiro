package com.seucontrolefinanceiro.resources;

import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.dto.UserDTO;
import com.seucontrolefinanceiro.form.UserForm;
import com.seucontrolefinanceiro.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("scf-service/user")
public class UserResource {

    @Autowired
    private UserService userService;

    @GetMapping
    public ResponseEntity<List<UserDTO>> find(String query) {
        List<User> users = userService.find(query);
        return ResponseEntity.ok().body(UserDTO.converter((users)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> findById(@PathVariable String id) {
        User user = userService.findById(id);
        return ResponseEntity.ok().body(new UserDTO(user));
    }


    @PostMapping
    public ResponseEntity<Void> insert(@RequestBody UserForm userForm, UriComponentsBuilder uriBuilder) {
        return null;
    }
}
