package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BillService implements IService<Bill> {

    @Autowired
    private BillRepository repository;

    @Override
    public List<Bill> findAll() {
        return repository.findAll();
    }

    @Override
    public Bill findById(String id) {
        Optional<Bill> obj = repository.findById(id);
        return obj.orElseThrow(() -> new ObjectNotFoundException("Object not found!"));
    }

    @Override
    public Bill insert(Bill bill) {
        Bill insert = repository.insert(bill);
        return insert;
    }

    @Override
    public void delete(String id) {
        findById(id);
        repository.deleteById(id);
    }

    @Override
    public Bill update(Bill newObj) {
        Bill currentObj = findById(newObj.getId());
        updateData(currentObj, newObj);
        return repository.save(currentObj);
    }

    @Override
    public void updateData(Bill currentObj, Bill newObj) {
        currentObj = Bill.builder()
                .billDescription(newObj.getBillDescription())
                .amount(newObj.getAmount())
                .everyMonth(newObj.isEveryMonth())
                .sameAmount(newObj.isSameAmount())
                .payDAy(newObj.getPayDAy())
                .billType(newObj.getBillType())
                .paymentCategory(newObj.getPaymentCategory())
                .build();
    }
}
