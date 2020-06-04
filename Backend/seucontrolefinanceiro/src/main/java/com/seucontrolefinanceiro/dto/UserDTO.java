package com.seucontrolefinanceiro.dto;

import com.seucontrolefinanceiro.domain.User;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class UserDTO {

        private final String id;
        private final String fullName;
        private final String user;
        private final String cpf;

        public UserDTO(User user) {
            this.id = user.getId();
            this.fullName = user.getFullName();
            this.user = user.getUser();
            this.cpf = user.getCpf();
        }

        public static List<UserDTO> converter(List<User> users) {
            return users.stream().map(UserDTO::new).collect(Collectors.toList());
        }
}
