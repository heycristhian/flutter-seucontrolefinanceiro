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
        BillEveryMonth everyMonth = new BillEveryMonth();
        Bill insert = repository.insert(bill);
        insert.setParent(insert.getId());
        repository.save(insert);
        List<Bill> billsChild = everyMonth.checkEveryMonth(bill, null);

        User user = userService.findById(insert.getUserId());
        user.addToListBill(insert);
        userRepository.save(user);

        if (billsChild != null) {
            for(Bill b : billsChild) {
                repository.insert(b);
                user.addToListBill(b);
                userRepository.save(user);
            }
        }
        return insert;
    }

    @Override
    public void delete(String id) {
        findById(id);
        repository.deleteById(id);
    }

    @Override
    public Bill update(@RequestBody Bill newObj) {
        Bill oldObj = findById(newObj.getId());
        newObj.setParent(oldObj.getParent());
        BillEveryMonth everyMonth = new BillEveryMonth();

        if(newObj.isEveryMonth() && !oldObj.isEveryMonth()) {
            oldObj = updateData(newObj, oldObj.getId());
            generateObject(oldObj, 11);
        } else if (!newObj.isEveryMonth() && oldObj.isEveryMonth()) {
            oldObj = updateData(newObj, oldObj.getId());
            returnBillsChild(oldObj)
                    .forEach(x -> repository.delete(x));
        } else {
            oldObj = updateData(newObj, oldObj.getId());
            repository.deleteAll(returnBillsChild(oldObj));
            generateObject(oldObj, 11);
        }
        return repository.save(oldObj);
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

    public void generateObject (Bill bill, Integer quantity) {
        List<Bill> bills = new ArrayList<>();

        for (int i = 1; i < quantity; i ++) {
            Bill newBill = GenerateObject.insertData(bill, i);
            newBill.setId(null);
            bills.add(newBill);
        }

        User user = userService.findById(bill.getUserId());
        for (Bill b : bills) {
            repository.insert(b);
            user.addToListBill(b);
            userRepository.save(user);
        }
    }
}
