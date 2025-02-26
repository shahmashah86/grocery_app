import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';

import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/orders/repository/order_respository.dart';
import 'package:grocery_app/domain/place_order_model/place_order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRespository orderRepository;
  OrdersBloc(this.orderRepository) : super(OrdersInitial()) {
    on<OrdersListGet>(_getOrdersList);
    on<OrdersbyUser>(_getOrderbyUserId);
    on<Orderacknowledge>(_acknowledeOrder);
    on<OrderPlaced>(_placeanOrder);
    on<OrderbyId>(_getOrder);
  }
  _getOrdersList(OrdersListGet event, Emitter<OrdersState> emit) async {
    final currentstate = state;
    try {
      if (currentstate is Orderssuccess) {
        emit(currentstate.copyWith(isLoading: true));

        final response = await orderRepository.getOrdersList();
        log(response.toString(), name: 'from get all orders bloc event');
        emit(currentstate.copyWith(
            isLoading: false,
            allordersList: response,
            orderScreenType: OrderScreenType.allOrders));
      } else {
        emit(OrdersLoading());
        final response = await orderRepository.getOrdersList();
        emit(Orderssuccess(
            isLoading: false,
            allordersList: response,
            orderScreenType: OrderScreenType.allOrders));
      }
    } catch (e) {
      emit(OrdersError(errormessage: e.toString()));
      log("Error fetching orders: ${e.toString()}");
    }
  }

  _getOrderbyUserId(OrdersbyUser event, Emitter<OrdersState> emit) async {
    final currentstate = state;
    if (currentstate is Orderssuccess) {
      try {
        emit(currentstate.copyWith(
          isLoading: true,
          allordersList: currentstate.allordersList,
          orderScreenType: OrderScreenType.userWiseOrders,
        ));

        final response = await orderRepository.getOrdersByUser(event.userId);
        log("Fetched orders for user: ${event.userId}");

        emit(currentstate.copyWith(
          isLoading: false,
          allordersList: currentstate.allordersList,
          orderScreenType: OrderScreenType.userWiseOrders,
          usersorderList: response,
        ));

        log(response.toString(), name: 'userslist');
   
      } catch (e) {
        emit(currentstate.copyWith(
          
          orderScreenType: OrderScreenType.userWiseOrders,
          isLoading: false,
          allordersList: currentstate.allordersList,
        ));
        log("Error fetching orders by user: ${e.toString()}");
      }
    }
  }

  _acknowledeOrder(Orderacknowledge event, Emitter<OrdersState> emit) async {
    final currentstate = state;

    final response = await orderRepository.acknowledgeOrder(event.orderId);

    log("lllll");
    if (currentstate is Orderssuccess) {
      try {
        emit(currentstate.copyWith(
          usersorderList: currentstate.usersorderList,
          allordersList: currentstate.allordersList,
          orderScreenType: currentstate.orderScreenType,
          message: response,
        ));

        log(response.toString(), name: 'from usersOrder');
      } catch (e) {
        emit(currentstate.copyWith(errormessage: e.toString()));
        log(e.toString());
      }
    }
  }

  _placeanOrder(OrderPlaced event, Emitter<OrdersState> emit) async {
    try {
      emit(Orderssuccess(
        isLoading: true,
      ));
      final response = await orderRepository.placeOrder(event.orders);
      emit(Orderssuccess(
        message: response['message'],
        isLoading: false,
      ));
      log(response['message']);
    } catch (e) {
      emit(OrdersError(errormessage: e.toString()));
      log(e.toString());
    }
  }

  _getOrder(OrderbyId event, Emitter<OrdersState> emit) async {
    final currentstate = state;


    log(currentstate.toString(), name: 'currentstate of get order');
  
    if (currentstate is Orderssuccess) {
      try {
        emit(currentstate.copyWith(
          isLoading: true,
          allordersList: currentstate.allordersList,
          usersorderList: currentstate.usersorderList,
          orderScreenType: currentstate.orderScreenType,
        ));
        final response = await orderRepository.getAnOrderbyId(event.orderId);
        log(response.toString(), name: 'orderResponse>>bloc');
        emit(currentstate.copyWith(
            ordersbyId: [response],
            isLoading: false,
            usersorderList: currentstate.usersorderList,
            orderScreenType: currentstate.orderScreenType,
            allordersList: currentstate.allordersList));
      } catch (e) {
        emit(currentstate.copyWith(
          iserror: true,
          isLoading: false,
          usersorderList: currentstate.usersorderList,
          allordersList: currentstate.allordersList,
          orderScreenType: currentstate.orderScreenType,
        ));
      }
    }
  }
}
