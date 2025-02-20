// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/cart/cart_respository/cart_respository.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRespository cartRespository;
  CartBloc(this.cartRespository) : super(CartInitial()) {
    on<CartitemsGet>(_getAllcartItems);
    on<CartItemAdd>(_addcartItem);

    on<CartItemDelete>(_deletecartItem);
    on<CartItemToupdate>(_updatecarteItem);
    on<CartItemclear>(_clearcartItem);
  }

  //get all cart Items.
  _getAllcartItems(CartitemsGet event, Emitter<CartState> emit) async {
    log('getcart');

    final response = await cartRespository.getAllcartItems();
    double subtotal =
        response!.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double tax = subtotal * 0.02;
    double deliveryCharge = 50;
    double total = subtotal + tax + deliveryCharge;
   emit(CartLoading());
    emit(CartLoaded(
        cartItems: response, subtotal: subtotal, total: total, tax: tax));
  }

//add cart Items.
  _addcartItem(CartItemAdd event, Emitter<CartState> emit) async {
    final currentstate = state;
    await cartRespository.addcartItem(event.cartItems);
    final updatedCartItems = await cartRespository.getAllcartItems();
       double subtotal =
        updatedCartItems!.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double tax = subtotal * 0.02;
    double deliveryCharge = 50;
    double total = subtotal + tax + deliveryCharge;
    if (currentstate is CartLoaded) {
      emit(currentstate.copyWith(isLoading: true));
      log(updatedCartItems.toString());

      emit(currentstate.copyWith(
          cartItems: List.from(
            updatedCartItems,
          ),
          isLoading: false));
    } else {
      emit(CartLoaded(subtotal: subtotal, total: total, tax: tax,
          cartItems: List.from(
        updatedCartItems,
      )));
    }
  }

  _deletecartItem(CartItemDelete event, Emitter<CartState> emit) async {
    final currentstate = state;
    await cartRespository.deletecartItem(event.indextoDelete);
    final cartafterDelete = List<CartModel>.from(
        await cartRespository.getAllcartItems() as List<CartModel>);
           double subtotal =
        cartafterDelete.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double tax = subtotal * 0.02;
    double deliveryCharge = 50;
    double total = subtotal + tax + deliveryCharge;
    if (currentstate is CartLoaded) {
      //        await cartRespository.deletecartItem(event.indextoDelete);
      //  final cartafterDelete=List<CartModel>.from(cartRespository.getAllcartItems() as List<CartModel>);
      emit(currentstate.copyWith(isLoading: true));
      log(cartafterDelete.toString(), name: 'cartafterDeleted');
      emit(currentstate.copyWith(cartItems: cartafterDelete, isLoading: false,subtotal: subtotal, total: total, tax: tax));
    } 
  }

  _updatecarteItem(CartItemToupdate event, Emitter<CartState> emit) async {
    final currentstate = state;
    await cartRespository.editcartItem(event.indextoUpdate, event.itemtoUpdate);
    final cartafterUpdate = List<CartModel>.from(
        await cartRespository.getAllcartItems() as List<CartModel>);
           double subtotal =
        cartafterUpdate.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double tax = subtotal * 0.02;
    double deliveryCharge = 50;
    double total = subtotal + tax + deliveryCharge;
    if (currentstate is CartLoaded) {
  
      emit(currentstate.copyWith(isLoading: true));
      log('inside update event');
      emit(currentstate.copyWith(cartItems: cartafterUpdate, isLoading: false,subtotal: subtotal, total: total, tax: tax));
    } 
  }
  _clearcartItem(CartItemclear event, Emitter<CartState> emit) async{
        final currentstate = state;
    await cartRespository.clearCart();
    final cartafterClear = List<CartModel>.from(
        await cartRespository.getAllcartItems() as List<CartModel>);
     
    if (currentstate is CartLoaded) {
  
      emit(currentstate.copyWith(isLoading: true));
      log('inside clear event');
      emit(currentstate.copyWith(cartItems: cartafterClear, isLoading: false));
    } 

  }

}
