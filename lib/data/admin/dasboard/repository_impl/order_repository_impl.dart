import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/common/order_dtos.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/dashboard/common/repository/order_respository.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:grocery_app/presentation/screens/admin/acknowledge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepositoryImpl extends OrderRespository  {

     Future<String?> readtokenFromPref() async {
    // log("From onboarding");
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    
    return tokenFromAuth;
  }


  @override
 Future<List<OrdersModel>> getOrdersList()  async{
   try {
  
      String? token= await readtokenFromPref();

      log("Orders");

      final Response response = await Apiservice.get(
      
          path: ApiEndpoints.allorders,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> jsonresponse=response.data;
        // List<OrderDtos> orderList=(response.data as List<Map<String,dynamic>>).map((element)=>OrderDtos.fromMap(element)).toList();
        
        // List<OrderDtos> orderList=OrderDtos.fromMap(response.data);
       
        return jsonresponse.map((toElement)=>OrderDtos.fromMap(toElement).toModel()).toList();
       
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
 
  }
  
  @override
  Future<List<OrdersModel>> getOrdersByUser(int userId) async {

    try{
       String? token= await readtokenFromPref();

      log("Orders");

      final Response response = await Apiservice.get(
      
          path:'${ApiEndpoints.getOrderbyUserId}$userId',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> jsonresponse=response.data;

        return jsonresponse.map((toElement)=>OrderDtos.fromMap(toElement).toModel()).toList(); 
      } else {
        throw "Something went wrong in response";
      }
    }
    catch (e) {
      log(e.toString());
      log("Something went wrong in request/code");
      rethrow;
    }
      
    }
    @override
  Future acknowledgeOrder(int orderId) async {
      try{
       String? token= await readtokenFromPref();

      log("from implementation of acknowldege order");

      final Response response = await Apiservice.patch(
      data:{'acknowledged':true},
          path:'${ApiEndpoints.acknowledgeOrder}$orderId',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
     
     return response.data;
        // return
      } else {
        throw "Something went wrong in response";
      }
    }
    catch (e) {
      log(e.toString());
      log("Something went wrong in request/code");
      rethrow;
    }
  
  }
}