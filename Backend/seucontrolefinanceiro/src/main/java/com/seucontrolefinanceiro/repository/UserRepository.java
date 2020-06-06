package com.seucontrolefinanceiro.repository;

import com.seucontrolefinanceiro.domain.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends MongoRepository<User, String> {

    List<User> findByCpfContainingIgnoreCase(String cpf);

}
