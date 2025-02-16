
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/dashboard/common/repository/order_respository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  
  final  OrderRespository orderRepository;
  OrdersBloc(this.orderRepository) : super(OrdersInitial()) {
    on<OrdersListGet>(_getOrdersList);
    on<OrdersbyUser>(_getOrderbyUserId);
    on<Orderacknowledge>(_acknowledeOrder);
  
  }

  _getOrdersList(OrdersListGet event,Emitter<OrdersState> emit) async{
      
      try{
        log("lllll");
       final response=await orderRepository.getOrdersList();
    log(response.toString());
    
    emit(Orderssuccess(allordersList: response,usersorderList: [],isLoading: false));
      }

     catch(e){
       emit(OrdersError(errormessage: e.toString()));
      log(e.toString());

  }
  
  }

   _getOrderbyUserId(OrdersbyUser event,Emitter<OrdersState> emit) async{
     final currentstate=state;
      try{
           final response=await orderRepository.getOrdersByUser(event.userId);
        log("lllll");
        if(currentstate is Orderssuccess){
      emit(currentstate.copyWith(isLoading: true,allordersList: []));
        
    
    log(response.toString(),name: 'from usersOrder');
    emit(Orderssuccess(usersorderList: response,isLoading: false,allordersList: []));
        }
         emit(Orderssuccess(usersorderList: response,isLoading: false,allordersList: []));
      }

     catch(e){
       emit(OrdersError(errormessage: e.toString()));
      log(e.toString());

  }
  
  }
  _acknowledeOrder(Orderacknowledge event,Emitter<OrdersState> emit) async{
       final currentstate=state;
      try{
         final response=await orderRepository.acknowledgeOrder(event.orderId!);
   
        log("lllll");
        if(currentstate is Orderssuccess){
        
                  // final response=await orderRepository.acknowledgeOrder(event.orderId!);
      // emit(currentstate.copyWith(isLoading: true,));
            emit(currentstate.copyWith(message: response,
            // acknowledgedOrders: [...event.acknowldegedOrders,event.orderId!]
            )
            );
        
  
    log(response.toString(),name: 'from usersOrder');
  
        }
        emit(Orderssuccess(message: response,));
       
      }

     catch(e){
       emit(OrdersError(errormessage: e.toString()));
      log(e.toString());

  }
    


  }
  
}
