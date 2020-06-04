package com.seucontrolefinanceiro.domain;

import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import org.springframework.data.mongodb.core.mapping.Document;

import java.math.BigDecimal;
import java.time.LocalDate;

@Document
@Builder
@Getter
@EqualsAndHashCode(of = {"id"})
public class Bill {
    private String id;
    private String billDescription;
    private BigDecimal amount;
    private boolean everyMonth = false;
    private boolean sameAmount = false;
    private LocalDate payDAy;
    private BillType billType;
}
