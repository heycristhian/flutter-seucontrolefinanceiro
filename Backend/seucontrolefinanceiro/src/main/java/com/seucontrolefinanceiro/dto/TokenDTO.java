package com.seucontrolefinanceiro.dto;

import lombok.Getter;

@Getter
public class TokenDTO {

    private String token;
    private String type;

    public TokenDTO(String token, String bearer) {
        this.token = token;
        this.type = bearer;
    }
}
