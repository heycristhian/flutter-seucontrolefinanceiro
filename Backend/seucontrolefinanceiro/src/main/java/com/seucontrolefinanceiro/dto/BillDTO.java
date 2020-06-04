package com.seucontrolefinanceiro.dto;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.BillType;
import com.seucontrolefinanceiro.domain.User;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

public class BillDTO {
    private final String id;
    private final String billDescription;
    private final BigDecimal amount;
    private final LocalDate payDAy;
    private final BillType billType;

    public BillDTO(Bill bill) {
        this.id = bill.getId();
        this.billDescription = bill.getBillDescription();
        this.amount = bill.getAmount();
        this.payDAy = bill.getPayDAy();
        this.billType = bill.getBillType();
    }

    public static List<BillDTO> converter(List<Bill> bills) {
        return bills.stream().map(BillDTO::new).collect(Collectors.toList());
    }
}
