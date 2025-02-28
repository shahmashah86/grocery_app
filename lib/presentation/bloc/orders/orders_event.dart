// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersListGet extends OrdersEvent {}

class OrdersbyUser extends OrdersEvent {
  final int userId;

  const OrdersbyUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class Orderacknowledge extends OrdersEvent {
  final int orderId;
//  final List<int> acknowldegedOrders;
  const Orderacknowledge({
    required this.orderId,
    // required this.acknowldegedOrders,
  });

  @override
  List<Object> get props => [orderId];
}

class OrderPlaced extends OrdersEvent {
  final PlaceOrderModel orders;

  const OrderPlaced({required this.orders});
  @override
  List<Object> get props => [orders];
}

class OrderbyId extends OrdersEvent {
  final int orderId;
  const OrderbyId({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];
}
class Ordercancel extends OrdersEvent{
  final int orderId;

 const Ordercancel({required this.orderId});
 @override
   List<Object> get props => [orderId];
}
