package com.seucontrolefinanceiro.form;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.BillType;
import com.seucontrolefinanceiro.domain.PaymentCategory;
import com.seucontrolefinanceiro.services.PaymentCategoryService;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class BillForm {

    @Autowired
    private PaymentCategoryService service;

    private String id;
    @NonNull
    private String billDescription;
    @NonNull
    private BigDecimal amount;
    @NonNull
    private boolean everyMonth;
    @NonNull
    private boolean sameAmount;
    @NonNull
    private LocalDate payDAy;
    @NonNull
    private BillType billType;
    @NonNull
    private PaymentCategory paymentCategory;

    public Bill converter() {
        return Bill.builder()
                .id(this.id)
                .billDescription(this.billDescription)
                .amount(this.amount)
                .everyMonth(this.everyMonth)
                .sameAmount(this.sameAmount)
                .payDAy(this.payDAy)
                .billType(this.billType)
                .paymentCategory(this.paymentCategory)
                .build();
    }
}
