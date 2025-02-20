// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrdersModel extends Equatable {
  int? id;
  String dateTime;
  int totalItems;
  String totalAmount;
  bool? acknowledged;
  int userId;
  OrdersModel({
    required this.id,
    required this.dateTime,
    required this.totalItems,
    required this.totalAmount,
    required this.acknowledged,
    required this.userId,
  });
  
  @override

  List<Object?> get props => [id,  dateTime,  totalItems,  totalAmount,  acknowledged,  userId];




 




  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime': dateTime,
      'totalItems': totalItems,
      'totalAmount': totalAmount,
      'acknowledged': acknowledged,
      'userId': userId,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      id: map['id'] != null ? map['id'] as int : null,
      dateTime: map['dateTime'] as String,
      totalItems: map['totalItems'] as int,
      totalAmount: map['totalAmount'] as String,
      acknowledged: map['acknowledged'] != null ? map['acknowledged'] as bool : null,
      userId: map['userId'] as int,
    );
  }


}
