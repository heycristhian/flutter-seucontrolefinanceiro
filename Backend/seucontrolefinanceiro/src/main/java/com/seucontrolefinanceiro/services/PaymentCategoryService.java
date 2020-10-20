package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.PaymentCategory;
import com.seucontrolefinanceiro.repository.PaymentCategoryRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PaymentCategoryService implements IService<PaymentCategory> {

    @Autowired
    private PaymentCategoryRepository repository;

    @Override
    public List<PaymentCategory> findAll() {
        return repository.findAll();
    }

    @Override
    public PaymentCategory findById(String id) {
        Optional<PaymentCategory> obj = repository.findById(id);
        return obj.orElseThrow(() -> new ObjectNotFoundException("Object not found!"));
    }

    @Override
    public PaymentCategory save(PaymentCategory paymentCategory) {
        PaymentCategory insert = repository.insert(paymentCategory);
        return insert;
    }

    @Override
    public void delete(String id) {
        findById(id);
        repository.deleteById(id);
    }

    @Override
    public PaymentCategory update(PaymentCategory newObj) {
        PaymentCategory currentObj = findById(newObj.getId());
        currentObj = updateData(newObj, currentObj.getId());
        return repository.save(currentObj);
    }

    @Override
    public PaymentCategory updateData(PaymentCategory newObj, String id) {
        return PaymentCategory.builder()
                .id(id)
                .description(newObj.getDescription())
                .billType(newObj.getBillType())
                .build();
    }

    public List<PaymentCategory> findByDescriptionContainingIgnoreCase(String description) {
        return repository.findByDescriptionContainingIgnoreCase(description);
    }
}
