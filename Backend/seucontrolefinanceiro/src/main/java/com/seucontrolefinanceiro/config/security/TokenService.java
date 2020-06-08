package com.seucontrolefinanceiro.config.security;


import com.seucontrolefinanceiro.domain.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.TextCodec;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

@Service
public class TokenService {
/*
    @Value("${forum.jwt.expiration}")
    private String expiration;

    @Value("${forum.jwt.secret}")
    private String secret;*/

    private String secret = "mysecret";

    public String generateToken(Authentication authentication) {
        User loggedUser = (User) authentication.getPrincipal();
        LocalDate expirationDate = LocalDate.now().plusDays(1);

        return Jwts.builder()
                .setIssuer("API - Seu controle financeiro")
                .setIssuedAt(Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()))
                .setSubject(loggedUser.getId())
                .setExpiration(Date.from(expirationDate.atStartOfDay(ZoneId.systemDefault()).toInstant()))
                .signWith(
                        SignatureAlgorithm.HS256,
                        TextCodec.BASE64.decode("Yn2kjibddFAWtnPJ2AFlL8WXmohJMCvigQggaEypa5E=")
                )
                .compact();

    }
}
