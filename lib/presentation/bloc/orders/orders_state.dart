part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class Orderssuccess extends OrdersState {
  final bool isLoading;
  final List<OrdersModel> allordersList;
  final List<OrdersModel> usersorderList;
  final List<OrdersModel> ordersbyId;
  final String message;
  final String errormessage;
  final List<int> acknowledgedOrders;
  final bool iserror;
  final OrderScreenType orderScreenType;

  const Orderssuccess(
      {this.allordersList = const [],
      this.usersorderList = const [],
      this.isLoading = false,
      this.message = '',
      this.errormessage = '',
      this.acknowledgedOrders = const [],
      this.ordersbyId = const [],
      this.iserror = false,
      this.orderScreenType = OrderScreenType.allOrders});

  Orderssuccess copyWith(
      {List<OrdersModel>? allordersList,
      List<OrdersModel>? usersorderList,
      bool? isLoading,
      String? message,
      String? errormessage,
      List<int>? acknowledgedOrders,
      List<OrdersModel>? ordersbyId,
      bool? iserror,
      OrderScreenType? orderScreenType}) {
    return Orderssuccess(
        errormessage: errormessage ?? this.errormessage,
        allordersList: allordersList ?? this.allordersList,
        usersorderList: usersorderList ?? this.usersorderList,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        acknowledgedOrders: acknowledgedOrders ?? this.acknowledgedOrders,
        ordersbyId: ordersbyId ?? this.ordersbyId,
        iserror: iserror ?? this.iserror,
        orderScreenType: orderScreenType ?? this.orderScreenType);
  }

  @override
  List<Object> get props => [
        isLoading,
        iserror,
        acknowledgedOrders,
        ordersbyId,
        usersorderList,
        allordersList,
        message,
        errormessage,
        orderScreenType
      ];
}

final class OrdersError extends OrdersState {
  final String errormessage;

  const OrdersError({this.errormessage = ''});
  @override
  List<Object> get props => [errormessage];
}
