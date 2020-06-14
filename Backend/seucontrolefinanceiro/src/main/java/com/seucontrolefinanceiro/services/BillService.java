package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import com.seucontrolefinanceiro.services.util.BillEveryMonth;
import com.seucontrolefinanceiro.services.util.GenerateObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BillService implements IService<Bill> {

    @Autowired
    private BillRepository repository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    private Integer billAmount = 5;

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
        if (bill.isEveryMonth()) {
            List<Bill> bills = GenerateObject.generateBills(bill, billAmount);
            repository.insert(bill);
            User user = userService.findById(bill.getUserId());
            user.setBills(repository.findByUserId(bill.getUserId()).get());

            for (Bill b : bills) {
                b.setParent(bill.getId());
                repository.insert(b);
                user.addToListBill(b);
            }
            userRepository.save(user);
        } else {
            repository.insert(bill);
        }
        return bill;
    }

    @Override
    public void delete(String id) {
        findById(id);
        repository.deleteById(id);
    }

    @Override
    public Bill update(Bill newObj) {
        Bill oldObj = findById(newObj.getId());
        boolean oldObjIsEveryMonth = oldObj.isEveryMonth();
        boolean newObjIsEveryMonth = newObj.isEveryMonth();

        newObj.setParent((newObj.getParent() == null) ? newObj.getId() : newObj.getParent());

        User user = userService.findById(newObj.getUserId());
        user.setBills(repository.findByUserId(newObj.getUserId()).get());
        List<Bill> bills;

        if (newObjIsEveryMonth && !oldObjIsEveryMonth) {
            bills = GenerateObject.generateBills(newObj, billAmount);

            for (Bill b : bills) {
                b.setParent(newObj.getId());
                repository.insert(b);
                user.addToListBill(b);
            }
            userRepository.save(user);
        } else if (oldObjIsEveryMonth && !newObjIsEveryMonth) {
            repository.findByUserId(newObj.getUserId())
                .get().stream()
                .filter(x -> x.getParent().equals(newObj.getParent())
                    && x.isPaid() == false)
                .collect(Collectors.toList())
                .forEach(x -> repository.delete(x));
        } else if(newObj.isEveryMonth()){
            bills = repository.findByUserId(newObj.getUserId())
                    .get().stream()
                    .filter(x -> x.getParent().equals(newObj.getParent())
                        && x.isPaid() == false
                    && !x.getId().equals(newObj.getId()))
                    .collect(Collectors.toList());

            for (Bill b : bills) {
                b = GenerateObject.cloneBill(b, newObj);
                repository.save(b);
            }
        }
        repository.save(newObj);
        return newObj;
    }

    @Override
    public Bill updateData(Bill newObj, String id) {
        return Bill.builder()
                .id(id)
                .billDescription(newObj.getBillDescription())
                .amount(newObj.getAmount())
                .everyMonth(newObj.isEveryMonth())
                .sameAmount(newObj.isSameAmount())
                .payDAy(newObj.getPayDAy())
                .billType(newObj.getBillType())
                .paymentCategory(newObj.getPaymentCategory())
                .paid(newObj.isPaid())
                .parent(newObj.getParent())
                .userId(newObj.getUserId())
                .build();
    }

    public List<Bill> returnBillsChild(Bill bill) {
        return repository.findAll().stream()
                .filter(x -> x.getParent().equals(bill.getParent())
                        && !x.getId().equals(bill.getId())
                        && x.isPaid() == false)
                .collect(Collectors.toList());
    }
}
