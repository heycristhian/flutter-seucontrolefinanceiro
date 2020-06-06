package com.seucontrolefinanceiro.services.util;

import com.seucontrolefinanceiro.domain.Bill;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class BillEveryMonth {

    public List<Bill> checkEveryMonth(Bill bill, String fatherId) {
        List<Bill> bills = new ArrayList<>();
        Integer monthQuantity = 12;

        if (bill.isEveryMonth()) {
            for(Integer i = 1; i < monthQuantity; i++) {
                bills.add(insertData(bill, i, fatherId));
            }
        }
        return bills;
    }

    public Bill insertData(Bill bill, Integer index, String fatherId) {
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
                .father(fatherId)
                .build();
    }
}
