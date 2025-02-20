// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

class PlaceOrderModel extends Equatable {

  final OrdersModel orderdetails;
  final List<ProductsModel> productdetails;

  PlaceOrderModel(this.orderdetails, this.productdetails);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();




  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderdetails': orderdetails.toMap(),
      'productdetails': productdetails.map((x) => x.toMap()).toList(),
    };
  }

  factory PlaceOrderModel.fromMap(Map<String, dynamic> map) {
    return PlaceOrderModel(
      OrdersModel.fromMap(map['orderdetails'] as Map<String,dynamic>),
      List<ProductsModel>.from((map['productdetails'] as List<int>).map<ProductsModel>((x) => ProductsModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

}
