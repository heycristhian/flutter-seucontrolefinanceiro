package com.seucontrolefinanceiro.config;

import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
public class Instantiation implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void run(String... args) throws Exception {

        userRepository.deleteAll();

        User user1 = User.builder()
                .fullName("Cristhian Dias")
                .user("heycristhian")
                .password("123")
                .cpf("45073070828")
                .build();

        User user2 = User.builder()
                .fullName("Eloisa Rozendo")
                .user("eloisarozendo")
                .password("123")
                .cpf("70873045028")
                .build();

        User user3 = User.builder()
                .fullName("Fulanin rei delas")
                .user("oreidelas")
                .password("123")
                .cpf("12312312311")
                .build();

        userRepository.saveAll(Arrays.asList(user1, user2, user3));
    }
}
