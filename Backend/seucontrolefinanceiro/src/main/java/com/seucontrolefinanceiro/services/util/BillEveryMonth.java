package com.seucontrolefinanceiro.services.util;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.services.BillService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

public class BillEveryMonth {

    @Autowired
    private BillService billService;

    public List<Bill> checkEveryMonth(Bill bill, List<Bill> allBills) {
        List<Bill> billsChild = new ArrayList<>();
        Integer monthQuantity = 12;

        if (bill.isEveryMonth()) {
            for(Integer i = 1; i < monthQuantity; i++) {
                billsChild.add(GenerateObject.insertData(bill, i));
            }
        } else {
            return allBills;
        }
        return billsChild;
    }


}
