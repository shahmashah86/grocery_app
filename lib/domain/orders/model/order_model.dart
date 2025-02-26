// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/orders/model/order_product_info_model.dart';










class OrdersModel extends Equatable {

 final int? id;
  final String dateTime;
 final int totalItems;
 final String? totalAmount;
 final bool? acknowledged;
 final int? userId;
  final List<OrderProductInfoModel>? product;

 const OrdersModel({
    this.id,
    required this.dateTime,
    required this.totalItems,
    required this.totalAmount,
    this.acknowledged,
    this.userId,
    required this.product
  });
  @override
  List<Object?> get props => [id,  dateTime,  totalItems,  totalAmount,  acknowledged,  userId,product];






  



}





 



