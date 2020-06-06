package com.seucontrolefinanceiro.config.util;

import com.seucontrolefinanceiro.domain.PaymentCategory;
import com.seucontrolefinanceiro.domain.User;
import com.seucontrolefinanceiro.repository.PaymentCategoryRepository;
import com.seucontrolefinanceiro.repository.UserRepository;
import com.seucontrolefinanceiro.services.util.ObjectExistUtil;

import java.util.List;

public class ObjectExist {

    ObjectExistUtil util = new ObjectExistUtil();

    public void paymentExist(List<PaymentCategory> paymentCategories, PaymentCategoryRepository repository) {
        for (PaymentCategory paymentCategory : paymentCategories){
            if(util.paymentExist(paymentCategory, repository)) {
                repository.save(paymentCategory);
            }
        }
    }

    public boolean userExist(User user, UserRepository repository) {
        return util.userExist(user, repository);
    }
}
