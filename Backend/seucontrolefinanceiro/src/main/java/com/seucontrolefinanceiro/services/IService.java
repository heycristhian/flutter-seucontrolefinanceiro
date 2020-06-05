package com.seucontrolefinanceiro.services;

import com.seucontrolefinanceiro.repository.UserRepository;

import java.util.List;

public interface IService<T> {

    UserRepository repository = null;

    public List<T> findAll();
    public T findById(String id);
    public T insert(T t);
    public void delete(String id);
    public T update(T newObj);
    public void updateData(T currentObj, T newObj);
}
