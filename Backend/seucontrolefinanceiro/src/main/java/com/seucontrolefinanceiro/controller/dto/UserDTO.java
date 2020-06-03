package com.seucontrolefinanceiro.controller.dto;

import com.seucontrolefinanceiro.model.User;
import lombok.*;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Getter
public class UserDTO {
    private final String fullName;
    private final String user;
    private final String cpf;

    public UserDTO(User user) {
        this.fullName = user.getFullName();
        this.user = user.getUser();
        this.cpf = user.getCpf();
    }


    public static List<UserDTO> converter(List<User> users) {
        //to do the command below, you need a constructor with parameter of the object you want to convert
        return users.stream().map(UserDTO::new).collect(Collectors.toList());
    }

}
