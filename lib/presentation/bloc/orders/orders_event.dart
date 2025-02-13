// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersListGet extends OrdersEvent{
  
}
class OrdersbyUser extends OrdersEvent{
 final int userId;

 const OrdersbyUser({required this.userId});
}

class Orderacknowledge extends OrdersEvent {
  final int? orderId;
//  final List<int> acknowldegedOrders;
  const Orderacknowledge({
    required this.orderId,
    // required this.acknowldegedOrders,
  });
  
}
