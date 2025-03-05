
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_app/data/databases/entity/cart_entity.dart';

import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/screens/user/cart/cart.dart';

class CartdbRepository {
  Future<void> addCart(CartEntity cartItems) async {
  
    log("inside add");
    await cartBox.add(cartItems);
  }

  void deleteCart(int index1) async {
    await cartBox.deleteAt(index1);
  }

  void updateCart(CartEntity todotask, int indextoUpdate) async {
    await cartBox.putAt(indextoUpdate, todotask);
  
  }
 List<CartEntity> getAllcartItems(){
  return  cartBox.values.toList();
 }
 Future<void> clearCart() async{
  await cartBox.clear();
 }
}
