package com.seucontrolefinanceiro.controller.dto;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class UserDTO {
    private String fullName;
    private String user;
    private String cpf;
/*
    public static List<UserDTO> converter(List<User> users) {
        return users.stream().map(UserDTO::new).collect(Collectors.toList());
    }*/

}
