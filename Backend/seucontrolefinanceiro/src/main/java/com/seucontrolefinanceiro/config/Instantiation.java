package com.seucontrolefinanceiro.config;

import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.BillType;
import com.seucontrolefinanceiro.domain.PaymentCategory;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.repository.PaymentCategoryRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;

@Configuration
public class Instantiation implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private PaymentCategoryRepository paymentCategoryRepository;

    @Override
    public void run(String... args) throws Exception {

        userRepository.deleteAll();
        billRepository.deleteAll();
        paymentCategoryRepository.deleteAll();

        User user1 = User.builder()
                .fullName("Cristhian Dias")
                .user("heycristhian")
                .password("123")
                .cpf("45073070828")
                .build();

        User user2 = User.builder()
                .fullName("Eloisa Rozendo")
                .user("eloisarozendo")
                .password("123")
                .cpf("70873045028")
                .build();

        User user3 = User.builder()
                .fullName("Fulanin rei delas")
                .user("oreidelas")
                .password("123")
                .cpf("12312312311")
                .build();

        PaymentCategory paymentCategory1 = PaymentCategory.builder()
                .description("Banco")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();

        PaymentCategory paymentCategory2 = PaymentCategory.builder()
                .description("Estudo")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();

        Bill bill1 = Bill.builder()
                .billDescription("NuBank")
                .amount(BigDecimal.valueOf(670.89))
                .everyMonth(true)
                .sameAmount(false)
                .payDAy(LocalDate.of(2020, 6, 12))
                .billType(BillType.PAYMENT)
                .paymentCategory(paymentCategory1)
                .build();

        Bill bill2 = Bill.builder()
                .billDescription("FEMA")
                .amount(BigDecimal.valueOf(711))
                .everyMonth(true)
                .sameAmount(true)
                .payDAy(LocalDate.of(2020, 6, 12))
                .billType(BillType.PAYMENT)
                .paymentCategory(paymentCategory2)
                .build();

        paymentCategoryRepository.saveAll(Arrays.asList(paymentCategory1, paymentCategory2));

        userRepository.saveAll(Arrays.asList(user1, user2, user3));
        billRepository.saveAll(Arrays.asList(bill1, bill2));
        user1.addToListBill(bill1);
        user1.addToListBill(bill2);
        userRepository.save(user1);
    }
}
