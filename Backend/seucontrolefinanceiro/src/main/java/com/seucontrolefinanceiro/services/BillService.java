package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.exception.ObjectNotFoundException;
import com.seucontrolefinanceiro.services.util.GenerateObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    private final Integer portion = 11;

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
    public Bill save(Bill bill) {
        User user = userService.findById(bill.getUserId());
        user.setBills(repository.findByUserId(bill.getUserId()).get());

        if (bill.isEveryMonth()) {
            Integer index = bill.getPortion() == null ? portion : bill.getPortion();
            List<Bill> bills = GenerateObject.generateBills(bill, index);
            repository.insert(bill);
            user.addToListBill(bill);
            for (Bill b : bills) {
                b.setParent(bill.getId());
                repository.insert(b);
                user.addToListBill(b);
            }
        } else {
            repository.insert(bill);
            user.addToListBill(bill);
        }
        String parentId = bill.getParent() == null ? bill.getId() : bill.getParent();
        bill.setParent(parentId);
        repository.save(bill);
        userRepository.save(user);
        return bill;
    }

    @Override
    public void delete(String id) {
        findById(id);
        repository.deleteById(id);
    }

    @Override
    public Bill update(Bill newObj) {
        if (!newObj.isPaid()) {
            Bill oldObj = findById(newObj.getId());
            boolean oldObjIsEveryMonth = oldObj.isEveryMonth();
            boolean newObjIsEveryMonth = newObj.isEveryMonth();
            String parentId;

            newObj.setParent((newObj.getParent() == null) ? newObj.getId() : newObj.getParent());

            User user = userService.findById(newObj.getUserId());
            user.setBills(repository.findByUserId(newObj.getUserId()).get());
            List<Bill> bills = new ArrayList<>();

            if (newObjIsEveryMonth && !oldObjIsEveryMonth) {
                Integer index = newObj.getPortion() == null ? portion : newObj.getPortion();
                bills = GenerateObject.generateBills(newObj, index);

                for (Bill b : bills) {
                    b.setParent(newObj.getId());
                    repository.insert(b);
                    user.addToListBill(b);
                }
                userRepository.save(user);
            } else if (oldObjIsEveryMonth && !newObjIsEveryMonth) {
                parentId = newObj.getParent() == null ? newObj.getId() : newObj.getParent();

                repository.findByUserId(newObj.getUserId()).get()
                        .stream().filter(x ->
                            x.isPaid() == false
                            && x.getParent().compareTo(parentId) == 0)
                        .collect(Collectors.toList()).forEach(x -> repository.delete(x));

                newObj.setPortion(null);

            } else if(newObj.isEveryMonth()){
                parentId = newObj.getParent() == null ? newObj.getId() : newObj.getParent();
                try {
                    bills = repository.findByUserId(newObj.getUserId())
                            .get().stream()
                            .filter(x -> x.getParent().equals(parentId)
                                    && x.isPaid() == false
                                    && !x.getId().equals(newObj.getId()))
                            .collect(Collectors.toList());
                } catch (RuntimeException e) {
                    e.printStackTrace();
                }

                int i = 0;
                for (Bill b : bills) {
                    ++i;
                    b = GenerateObject.cloneBill(b, newObj);
                    repository.save(b);
                }
            }
            repository.save(newObj);
            return newObj;
        } else {
            return pay(newObj);
        }
    }

    @Override
    public Bill updateData(Bill newObj, String id) {
        return Bill.builder()
                .id(id)
                .billDescription(newObj.getBillDescription())
                .amount(newObj.getAmount())
                .everyMonth(newObj.isEveryMonth())
                .payDAy(newObj.getPayDAy())
                .billType(newObj.getBillType())
                .paymentCategory(newObj.getPaymentCategory())
                .paid(newObj.isPaid())
                .parent(newObj.getParent())
                .userId(newObj.getUserId())
                .portion(newObj.getPortion())
                .paidIn(newObj.getPaidIn())
                .build();
    }

    public List<Bill> returnBillsChild(Bill bill) {
        return repository.findAll().stream()
                .filter(x -> x.getParent().equals(bill.getParent())
                        && !x.getId().equals(bill.getId())
                        && x.isPaid() == false)
                .collect(Collectors.toList());
    }

    public Bill pay(Bill bill) {
        bill.setPaid(true);
        repository.save(bill);
        return bill;
    }

    public void deleteAll(List<Bill> bills) {
        repository.deleteAll(bills);
    }
}
