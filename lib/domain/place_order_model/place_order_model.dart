import 'package:equatable/equatable.dart';

import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';

class PlaceOrderModel extends Equatable {
  final String dateTime;
  final int totalItems;
  final double totalAmount;
  final List<CartModel> productdetails;

  const PlaceOrderModel({
    required this.dateTime,
    required this.totalItems,
    required this.totalAmount,
    required this.productdetails,
  });
  @override
  List<Object?> get props =>
      [dateTime, totalAmount, totalItems, productdetails];
      
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'totalItems': totalItems,
      'totalAmount': totalAmount,
      'productList': productdetails.map((x) => x.toMap()).toList(),
    };
  }
}
