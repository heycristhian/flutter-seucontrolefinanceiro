package com.seucontrolefinanceiro.domain;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Builder
@Getter
@Setter
@EqualsAndHashCode(of = {"id"})
@Document()
public class User {

    @Id
    private String id;
    private String fullName;
    private String user;
    private String password;
    private String cpf;


    /*

   {
  "fullName": "Cristhian Dias",
  "user": "heycristhian",
  "password": "123",
  "cpf": "45073070828"
}
     */
}
