package com.seucontrolefinanceiro.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum BillType {
    PAYMENT("Pagamento"),
    RECEIVEMENT("Recebimento");

    private String description;


}
