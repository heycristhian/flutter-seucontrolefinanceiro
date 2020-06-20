import 'package:flutter/material.dart';

class IconCategory { 
  static iconCategory(String text) {

    if (text == 'Alimentação') return Icons.fastfood;
    if (text == 'Banco') return Icons.business;
    if (text == 'Compras') return Icons.shopping_cart;
    if (text == 'Dívidas') return Icons.error;
    if (text == 'Educação') return Icons.school;
    if (text == 'Impostos') return Icons.attach_money;
    if (text == 'Lazer') return Icons.brush;
    if (text == 'Presentes') return Icons.card_giftcard;
    if (text == 'Roupas') return Icons.face;
    if (text == 'Saúde') return Icons.favorite;
    if (text == 'Serviços') return Icons.local_laundry_service;
    if (text == 'Supermercado') return Icons.store_mall_directory;
    if (text == 'Viagem') return Icons.local_airport;
    if (text == 'Transporte') return Icons.directions_car;
    if (text == 'Empréstimo') return Icons.money_off;
    if (text == 'Investimento') return Icons.trending_up;
    if (text == 'Salário') return Icons.monetization_on;
    return Icons.reorder;


  }
}