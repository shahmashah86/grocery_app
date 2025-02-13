
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




 



}
