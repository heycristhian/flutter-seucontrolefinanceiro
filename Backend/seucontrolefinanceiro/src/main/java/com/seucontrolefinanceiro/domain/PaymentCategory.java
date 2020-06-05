package com.seucontrolefinanceiro.domain;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
@Builder
@Document()
@EqualsAndHashCode(of = {"id"})
public class PaymentCategory {

    @Id
    private String id;
    @NonNull
    private String description;
    private boolean mutable = true;
    private BillType billType;
}
