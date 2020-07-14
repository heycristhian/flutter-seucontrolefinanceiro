package com.seucontrolefinanceiro.config;

import com.seucontrolefinanceiro.config.util.ObjectExist;
import com.seucontrolefinanceiro.domain.Bill;
import com.seucontrolefinanceiro.domain.BillType;
import com.seucontrolefinanceiro.domain.PaymentCategory;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.BillRepository;
import com.seucontrolefinanceiro.repository.PaymentCategoryRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Configuration
public class Instantiation implements CommandLineRunner {

    @Autowired
    private PaymentCategoryRepository paymentCategoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BillService billService;

    @Autowired
    private BillRepository billRepository;

    @Override
    public void run(String... args) throws Exception {

        ObjectExist objExist = new ObjectExist();
        List<PaymentCategory> paymentCategories = new ArrayList<>();

        // ============================PAYMENT CATEGORY=======================================================

        PaymentCategory loan = PaymentCategory.builder()
                .description("Empréstimo")
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(loan);

        PaymentCategory salary = PaymentCategory.builder()
                .description("Salário")
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(salary);

        PaymentCategory investment = PaymentCategory.builder()
                .description("Investimento")
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(investment);

        PaymentCategory others = PaymentCategory.builder()
                .description("Outros")
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(others);

        PaymentCategory bank = PaymentCategory.builder()
                .description("Banco")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(bank);

        PaymentCategory foods = PaymentCategory.builder()
                .description("Alimentação")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(foods);

        PaymentCategory health = PaymentCategory.builder()
                .description("Saúde")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(health);

        PaymentCategory services = PaymentCategory.builder()
                .description("Serviços")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(services);

        PaymentCategory snackBar = PaymentCategory.builder()
                .description("Lanchonetes")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(snackBar);

        PaymentCategory shopping = PaymentCategory.builder()
                .description("Compras")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(shopping);

        PaymentCategory debt = PaymentCategory.builder()
                .description("Dívidas")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(debt);

        PaymentCategory education = PaymentCategory.builder()
                .description("Educação")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(education);

        PaymentCategory tax = PaymentCategory.builder()
                .description("Impostos")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(tax);

        PaymentCategory recreation = PaymentCategory.builder()
                .description("Lazer")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(recreation);

        PaymentCategory market = PaymentCategory.builder()
                .description("Supermercado")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(market);

        PaymentCategory gifts = PaymentCategory.builder()
                .description("Presentes")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(gifts);

        PaymentCategory clothes = PaymentCategory.builder()
                .description("Roupas")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(clothes);

        PaymentCategory transport = PaymentCategory.builder()
                .description("Transporte")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(transport);

        PaymentCategory trip = PaymentCategory.builder()
                .description("Viagem")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(trip);

        PaymentCategory othersPayment = PaymentCategory.builder()
                .description("Outros")
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(othersPayment);

        objExist.paymentExist(paymentCategories, paymentCategoryRepository);


        // ===================================================================================================


        User adm = User.builder()
                .id("5edc8081336c5266fcc81dd5")
                .fullName("Administrador")
                .email("admin@admin.com.br")
                .password(new BCryptPasswordEncoder().encode("admin"))
                .cpf("45073070828")
                .build();

        boolean exist = userRepository.findAll().stream()
                .filter(x -> x.getEmail().equals(adm.getEmail()))
                .findAny()
                .stream()
                .collect(Collectors.toList()).size() > 0;

        if (!exist) {
            userRepository.save(adm);

            Bill bill = Bill.builder()
                    .billDescription("NuBank")
                    .amount(BigDecimal.valueOf(150))
                    .everyMonth(false)
                    .payDAy(LocalDate.of(2020, 6, 12))
                    .billType(BillType.PAYMENT)
                    .paymentCategory(bank)
                    .userId(adm.getId())
                    .build();
            adm.addToListBill(bill);
            billService.insert(bill);
            userRepository.save(adm);
        }
    }
}
