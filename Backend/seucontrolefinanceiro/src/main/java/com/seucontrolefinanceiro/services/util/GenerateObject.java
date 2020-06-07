package com.seucontrolefinanceiro.services.util;

import com.seucontrolefinanceiro.domain.Bill;

import java.math.BigDecimal;

public class GenerateObject {

    public static Bill insertData(Bill bill, Integer index) {
        return Bill.builder()
                .id(bill.getId())
                .billDescription(bill.getBillDescription())
                .amount(bill.isSameAmount() ? bill.getAmount() : BigDecimal.valueOf(0))
                .everyMonth(bill.isEveryMonth())
                .sameAmount(bill.isSameAmount())
                .payDAy(bill.getPayDAy().plusMonths(index))
                .billType(bill.getBillType())
                .paymentCategory(bill.getPaymentCategory())
                .paid(bill.isPaid())
                .userId(bill.getUserId())
                .parent(bill.getParent())
                .build();
    }
}
