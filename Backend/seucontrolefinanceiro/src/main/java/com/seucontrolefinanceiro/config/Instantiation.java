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
                .mutable(false)
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(loan);

        PaymentCategory salary = PaymentCategory.builder()
                .description("Salário")
                .mutable(false)
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(salary);

        PaymentCategory investment = PaymentCategory.builder()
                .description("Investimento")
                .mutable(false)
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(investment);

        PaymentCategory others = PaymentCategory.builder()
                .description("Outras receitas")
                .mutable(false)
                .billType(BillType.RECEIVEMENT)
                .build();
        paymentCategories.add(others);

        PaymentCategory bank = PaymentCategory.builder()
                .description("Banco")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(bank);

        PaymentCategory foods = PaymentCategory.builder()
                .description("Alimentação")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(foods);

        PaymentCategory health = PaymentCategory.builder()
                .description("Saúde")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(health);

        PaymentCategory services = PaymentCategory.builder()
                .description("Serviços")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(services);

        PaymentCategory snackBar = PaymentCategory.builder()
                .description("Lanchonetes")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(snackBar);

        PaymentCategory shopping = PaymentCategory.builder()
                .description("Compras")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(shopping);

        PaymentCategory debt = PaymentCategory.builder()
                .description("Dívidas")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(debt);

        PaymentCategory education = PaymentCategory.builder()
                .description("Educação")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(education);

        PaymentCategory tax = PaymentCategory.builder()
                .description("Impostos")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(tax);

        PaymentCategory recreation = PaymentCategory.builder()
                .description("Lazer")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(recreation);

        PaymentCategory market = PaymentCategory.builder()
                .description("Supermercado")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(market);

        PaymentCategory gifts = PaymentCategory.builder()
                .description("Presentes")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(gifts);

        PaymentCategory clothes = PaymentCategory.builder()
                .description("Roupas")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(clothes);

        PaymentCategory transport = PaymentCategory.builder()
                .description("Transporte")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(transport);

        PaymentCategory trip = PaymentCategory.builder()
                .description("Viagem")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(trip);

        PaymentCategory othersPayment = PaymentCategory.builder()
                .description("Viagem")
                .mutable(false)
                .billType(BillType.PAYMENT)
                .build();
        paymentCategories.add(othersPayment);

        objExist.paymentExist(paymentCategories, paymentCategoryRepository);


        // ===================================================================================================


        User adm = User.builder()
                .fullName("Administrador")
                .user("admin")
                .password("admin")
                .cpf("45073070828")
                .build();

        boolean exist = userRepository.findAll().stream()
                .filter(x -> x.getUser().equals(adm.getUser()))
                .findAny()
                .stream()
                .collect(Collectors.toList()).size() > 0;

        if (!exist) {
            userRepository.save(adm);

            Bill bill = Bill.builder()
                    .billDescription("NuBank")
                    .amount(BigDecimal.valueOf(150))
                    .everyMonth(false)
                    .sameAmount(false)
                    .payDAy(LocalDate.of(2020, 6, 12))
                    .billType(BillType.PAYMENT)
                    .paymentCategory(bank)
                    .userId(adm.getId())
                    .build();
            billService.insert(bill);
        }
    }
}
