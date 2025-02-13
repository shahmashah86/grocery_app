part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class Orderssuccess extends OrdersState {
  final bool? isLoading;
  final List<OrdersModel>? allordersList;
  final List<OrdersModel>? usersorderList;
  final String? message;
  final List<int>? acknowledgedOrders;

  const Orderssuccess(
      {this.allordersList,
      this.usersorderList,
      this.isLoading = false,
      this.message = '',
      this.acknowledgedOrders
      });

  Orderssuccess copyWith(
      {List<OrdersModel>? allordersList,
      final List<OrdersModel>? usersorderList,
      bool? isLoading,
      String? message,
       List<int>?acknowledgedOrders
       }) {
    return Orderssuccess(
        allordersList: allordersList ?? this.allordersList,
        isLoading: isLoading ?? this.isLoading,
        usersorderList: allordersList ?? this.usersorderList,
        message: message ?? this.message,
        acknowledgedOrders: acknowledgedOrders ?? this.acknowledgedOrders
        );
  }
}

final class OrdersError extends OrdersState {
  final String? message;

  const OrdersError({this.message});
}
