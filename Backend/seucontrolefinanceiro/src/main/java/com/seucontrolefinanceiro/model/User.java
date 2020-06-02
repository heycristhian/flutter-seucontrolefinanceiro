package com.seucontrolefinanceiro.model;

public class User {

    private String fullName;
    private String user;
    private String password;
    private String cpf;

    public User(String fullName, String user, String password, String cpf) {
        this.fullName = fullName;
        this.user = user;
        this.password = password;
        this.cpf = cpf;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getFullName() {
        return fullName;
    }

    public String getUser() {
        return user;
    }

    public String getPassword() {
        return password;
    }

    public String getCpf() {
        return cpf;
    }
}
