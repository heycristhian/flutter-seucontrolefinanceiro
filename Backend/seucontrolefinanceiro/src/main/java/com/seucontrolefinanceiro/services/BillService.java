package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import com.seucontrolefinanceiro.services.util.BillEveryMonth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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
        List<Bill> bills = everyMonth.checkEveryMonth(bill, insert.getId());

        User user = userService.findById(insert.getUserId());
        user.addToListBill(insert);
        userRepository.save(user);

        for(Bill b : bills) {
            repository.insert(b);
            user.addToListBill(b);
            userRepository.save(user);
        }
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
                .paid(newObj.isPaid())
                .father(newObj.getFather())
                .userId(newObj.getUserId())
                .build();
    }
}
