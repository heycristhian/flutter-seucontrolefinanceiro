package com.seucontrolefinanceiro.dto;

import lombok.Getter;

@Getter
public class TokenDTO {

    private String token;
    private String tipo;

    public TokenDTO(String token, String bearer) {
        this.token = token;
        this.tipo = bearer;
    }
}
