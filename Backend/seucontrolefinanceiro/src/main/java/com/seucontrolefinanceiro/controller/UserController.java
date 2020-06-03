package com.seucontrolefinanceiro.controller;

import com.seucontrolefinanceiro.controller.dto.UserDTO;
import com.seucontrolefinanceiro.controller.form.UserForm;
import com.seucontrolefinanceiro.model.User;
import com.seucontrolefinanceiro.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("scf-service/user")
public class UserController {

    private UserRepository userRepository;

    @GetMapping
    public List<UserDTO> find(String query) {

        User user = User.builder()
                .id(1L)
                .fullName("Cristhian Dias")
                .user("heycristhian")
                .password("123")
                .cpf("45073070828")
                .build();

        return UserDTO.converter(Arrays.asList(user, user, user));
    }

    @PostMapping
    public ResponseEntity<UserDTO> addUser(@RequestBody UserForm userForm, UriComponentsBuilder uriBuilder) {
        //Take information sent and make it the correct object
        User user = userForm.converter();
        //Save's method
        userRepository.save(user);
        URI uri = uriBuilder.path("/scf-service/user/{id}").buildAndExpand(user.getId()).toUri();
        //returning status code and the body
        return ResponseEntity.created(uri).body(new UserDTO(user));
    }
}
