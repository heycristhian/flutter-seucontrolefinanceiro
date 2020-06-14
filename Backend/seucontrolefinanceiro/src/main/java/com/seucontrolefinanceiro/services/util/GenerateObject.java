package com.seucontrolefinanceiro.services.util;

import com.seucontrolefinanceiro.domain.Bill;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class GenerateObject {

    public static List<Bill> generateBills(Bill bill, Integer index) {
        List<Bill> bills = new ArrayList<>();
        for(int i = 1; i < index; i++) {
            bills.add(GenerateObject.insertData(bill, i));
        }
        return bills;
    }

    private static Bill insertData(Bill bill, Integer index) {
        return Bill.builder()
                .billDescription(bill.getBillDescription())
                .amount(bill.isSameAmount() ? bill.getAmount() : BigDecimal.valueOf(0))
                .everyMonth(bill.isEveryMonth())
                .sameAmount(bill.isSameAmount())
                .payDAy(bill.getPayDAy().plusMonths(index))
                .billType(bill.getBillType())
                .paymentCategory(bill.getPaymentCategory())
                .paid(bill.isPaid())
                .userId(bill.getUserId())
                .build();
    }

    public static Bill cloneBill(Bill oldObj, Bill newObj) {

        oldObj.setBillDescription(newObj.getBillDescription());
        oldObj.setAmount(newObj.isSameAmount() ? newObj.getAmount() : BigDecimal.valueOf(0));
        oldObj.setEveryMonth(newObj.isEveryMonth());
        oldObj.setSameAmount(newObj.isSameAmount());
        oldObj.setPayDAy(newObj.getPayDAy());
        oldObj.setBillType(newObj.getBillType());
        oldObj.setPaymentCategory(newObj.getPaymentCategory());
        oldObj.setPaid(newObj.isPaid());
        oldObj.setParent(newObj.getParent());
        oldObj.setUserId(newObj.getUserId());

        return oldObj;
    }
}
