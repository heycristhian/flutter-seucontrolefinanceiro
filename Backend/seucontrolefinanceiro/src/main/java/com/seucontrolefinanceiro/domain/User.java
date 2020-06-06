package com.seucontrolefinanceiro.domain;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.constraints.NotNull;
import java.util.*;
import java.util.stream.Collectors;

@Setter
@Builder
@Document()
@EqualsAndHashCode(of = {"fullName", "user"})
@ToString(of = {"fullName", "bills"})
@AllArgsConstructor(staticName = "of")
public class User {

    @Id
    @Getter
    private String id;
    @Getter
    @NotNull
    private String fullName;
    @Getter
    private String user;
    @Getter
    private String password;
    @Getter
    private String cpf;

    @DBRef(lazy = true)
    @Builder.Default private List<Bill> bills;

    @Deprecated
    User() {}

    public static class UserBuilder {

        public User build() {
            User user = User.of(this.id, this.fullName, this.user, this.password, this.cpf, new ArrayList<>());

            Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

            Set<ConstraintViolation<User>> violations = validator.validate(user);

            if (!violations.isEmpty()) {
                String message = violations.stream().map(v -> String.format("%s: %s", v.getPropertyPath(), v.getMessage())).collect(Collectors.joining("\n"));
                throw new RuntimeException(message);
            }
            return user;
        }
    }

    public List<Bill> getBills () {
        return Collections.unmodifiableList(this.bills);
    }

    public void addToListBill(Bill bill) {
        this.bills.stream().filter(x -> x.equals(bill))
                .findAny()
                .ifPresent(valor -> {
                    return;
                });
        this.bills.add(bill);
    }
}
