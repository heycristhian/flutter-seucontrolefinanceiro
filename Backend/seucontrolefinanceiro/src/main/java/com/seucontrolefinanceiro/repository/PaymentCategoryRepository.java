package com.seucontrolefinanceiro.repository;

import com.seucontrolefinanceiro.domain.PaymentCategory;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaymentCategoryRepository extends MongoRepository<PaymentCategory, String> {

    List<PaymentCategory> findByDescription(String query);

}
