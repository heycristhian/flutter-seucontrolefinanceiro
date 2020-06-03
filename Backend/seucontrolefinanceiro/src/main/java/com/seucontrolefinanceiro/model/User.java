package com.seucontrolefinanceiro.model;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class User {
    private final long id;
    private final String fullName;
    private final String user;
    private final String password;
    private final String cpf;
}
