import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/order/dtos/order_dtos.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/orders/repository/order_respository.dart';
import 'package:grocery_app/domain/place_order_model/place_order_model.dart';

import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepositoryImpl extends OrderRespository {
  Future<String?> readtokenFromPref() async {
    // log("From onboarding");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";

    return tokenFromAuth;
  }

  @override
  Future<List<OrdersModel>> getOrdersList() async {
    try {
      String? token = await readtokenFromPref();

      final Response response = await Apiservice.get(
          path: ApiEndpoints.allorders,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> jsonresponse = response.data;
        // List<OrderDtos> orderList=(response.data as List<Map<String,dynamic>>).map((element)=>OrderDtos.fromMap(element)).toList();

        // List<OrderDtos> orderList=OrderDtos.fromMap(response.data);

        return jsonresponse
            .map((toElement) => OrderDtos.fromMap(toElement).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<OrdersModel>> getOrdersByUser(int userId) async {
    try {
      String? token = await readtokenFromPref();

      final Response response = await Apiservice.get(
          path: '${ApiEndpoints.getOrderbyUserId}$userId',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> jsonresponse = response.data;

        return jsonresponse
            .map((toElement) => OrderDtos.fromMap(toElement).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      log("Something went wrong in request/code");
      rethrow;
    }
  }

  @override
  Future acknowledgeOrder(int orderId) async {
    try {
      String? token = await readtokenFromPref();

      log("from implementation of acknowldege order");

      final Response response = await Apiservice.patch(
          data: {'acknowledged': true},
          path: '${ApiEndpoints.acknowledgeOrder}$orderId',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        return response.data;
        // return
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      log("Something went wrong in request/code");
      rethrow;
    }
  }

  @override
  Future placeOrder(PlaceOrderModel details) async {
    try {
      String? token = await readtokenFromPref();

      log("from implementation of place order");

      final Response response = await Apiservice.post(
          data: details.toMap(),
          path: ApiEndpoints.placeOrder,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        // log(response.data.toString());
        return response.data['message'];
      
        // return
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'exception');
      log("Something went wrong in request/code");
      rethrow;
    }
  }

  @override
  Future<OrdersModel> getAnOrderbyId(int id) async {
    try {
      log('inside try');
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
          path: '${ApiEndpoints.getOrderbyId}$id',
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        log('kkk');

        //  return response.data;
        //  \response.data;
        final orderdata = OrderDtos.fromMap(response.data).toModel();
        log(orderdata.toString());
        return orderdata;
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  }
  
  @override
  Future<String> cancelOrder(int orderId) async {
        try {
      log('inside try');
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.delete(
          path: '${ApiEndpoints.cancelOrder}$orderId',
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        log('reponse of cancel',name: 'cancel order');

        //  return response.data;
        //  \response.data;
   
        return response.toString();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }

  }
  
  @override
  Future<String> updateOrder(int orderId) async {
            try {
  
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.put(
          path: '${ApiEndpoints.updateOrder}$orderId',
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        log('reponse of cancel',name: 'update order');
   
        return response.toString();
        
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  
  }
}
