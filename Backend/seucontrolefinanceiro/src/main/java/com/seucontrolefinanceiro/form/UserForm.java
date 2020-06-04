package com.seucontrolefinanceiro.form;

import com.seucontrolefinanceiro.domain.User;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UserForm {

    private final String id;
    private final String fullName;
    private final String user;
    private final String password;
    private final String cpf;

    public User converter() {
        return User.builder()
                .id(this.id)
                .fullName(this.fullName)
                .user(this.user)
                .password(this.password)
                .cpf(this.cpf)
                .build();
    }
}