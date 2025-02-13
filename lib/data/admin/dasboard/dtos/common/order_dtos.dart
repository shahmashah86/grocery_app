// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';


class OrderDtos extends Equatable {
 final int? id;
  final String dateTime;
 final int totalItems;
 final String totalAmount;
 final bool? acknowledged;
 final int userId;
 const  OrderDtos({
    required this.id,
    required this.dateTime,
    required this.totalItems,
    required this.totalAmount,
    required this.acknowledged,
    required this.userId,
  });

    factory OrderDtos.fromMap(dynamic json) {
    return OrderDtos(
      id: json['id']??0,
      dateTime: json['dateTime'],
      totalItems: json['totalItems'],
      totalAmount: json['totalAmount'],
      acknowledged: json['acknowledged'],
      userId: json['userId']
    );
  }

     OrdersModel toModel() {
    return OrdersModel(
      id: id,
      dateTime: dateTime,
      totalItems: totalItems,
      totalAmount: totalAmount,
      acknowledged: acknowledged,
      userId: userId
       
        );
  }
  
  @override

  List<Object?> get props => [id,dateTime,totalItems,totalAmount,acknowledged,userId];

  
}
