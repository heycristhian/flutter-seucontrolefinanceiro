import 'package:flutter/material.dart';

class ManyIcons {
  static iconCategory(String text) {
    if (text == 'Alimentação') return Image.asset('assets/icons/fast-food.png');
    if (text == 'Banco') return Image.asset('assets/icons/bank.png');
    if (text == 'Compras') return Image.asset('assets/icons/buy.png');
    if (text == 'Dívidas') return Image.asset('assets/icons/depts.png');
    if (text == 'Educação') return Image.asset('assets/icons/education.png');
    if (text == 'Impostos') return Image.asset('assets/icons/tax.png');
    if (text == 'Lazer') return Image.asset('assets/icons/recreation.png');
    if (text == 'Presentes') return Image.asset('assets/icons/gift.png');
    if (text == 'Roupas') return Image.asset('assets/icons/clothes.png');
    if (text == 'Saúde') return Image.asset('assets/icons/health.png');
    if (text == 'Serviços') return Image.asset('assets/icons/service.png');
    if (text == 'Supermercado')
      return Image.asset('assets/icons/supermarket.png');
    if (text == 'Viagem') return Image.asset('assets/icons/travel.png');
    if (text == 'Transporte') return Image.asset('assets/icons/transport.png');
    if (text == 'Empréstimo') return Image.asset('assets/icons/loan.png');
    if (text == 'Investimento')
      return Image.asset('assets/icons/investment.png');
    if (text == 'Salário') return Image.asset('assets/icons/salary.png');
    if (text == 'Lanchonetes') return Image.asset('assets/icons/snack-bar.png');
    return Image.asset('assets/icons/others.png');
  }
}
