package com.seucontrolefinanceiro.domain;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Builder
@Getter
@EqualsAndHashCode(of = {"id"})
@Document()
public class User {

    @Id
    private final String id;
    private final String fullName;
    private final String user;
    private final String password;
    private final String cpf;


    /*

   {
  "fullName": "Cristhian Dias",
  "user": "heycristhian",
  "password": "123",
  "cpf": "45073070828"
}
     */
}
