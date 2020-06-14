package com.seucontrolefinanceiro.repository;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface BillRepository extends MongoRepository<Bill, String> {

    Optional<List<Bill>> findByUserId(String id);
}
