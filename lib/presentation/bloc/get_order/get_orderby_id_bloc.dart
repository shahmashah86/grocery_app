import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/common/model/order_byid_model/order_byid_model.dart';
import 'package:grocery_app/domain/common/model/repository/orde_by_id_repo.dart';

part 'get_orderby_id_event.dart';
part 'get_orderby_id_state.dart';

class GetOrderbyIdBloc extends Bloc<GetOrderbyIdEvent, GetOrderbyIdState> {
  final OrdeByIdRepo orderbyidrepo;
  GetOrderbyIdBloc(this.orderbyidrepo) : super(GetOrderbyIdInitial()) {
    on<GetOrderEvent>(_getOrder);
  }
  _getOrder(GetOrderEvent event,Emitter<GetOrderbyIdState> emit) async{

    try {
      //  emit(CategoryLoaded(isLoading: true));
      final response = await orderbyidrepo.getAnOrderbyId(event.id);
      log(response.toString());
      emit(GetAnOrderbyIdLoaded(orderById: response));
    } catch (e) {
      // emit(CategoryError(e.toString()));
      log(e.toString(),name: 'getorderbuyid error from bloc');
    }
  }
  }

