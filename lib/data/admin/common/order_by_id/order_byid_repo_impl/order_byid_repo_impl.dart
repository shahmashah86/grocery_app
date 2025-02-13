import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin/common/order_by_id/order_byid_dto.dart';
import 'package:grocery_app/domain/common/model/order_byid_model/order_byid_model.dart';
import 'package:grocery_app/domain/common/model/repository/orde_by_id_repo.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderByidRepoImpl extends OrdeByIdRepo{
   Future<String?> readtokenFromPref() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    return tokenFromAuth;
  }

  @override
  Future<OrderByidModel> getAnOrderbyId(int id) async {
        try {
          log('inside try');
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
       
          path: '${ApiEndpoints.getOrderbyId}$id',
          headers: {"Authorization": "Bearer $token"});
  
      if (response.statusCode == 200) {
   
    //  \response.data;
      return OrderByidDto.fromMap(response.data).toModel();
            } else {
        throw "Something went wrong in response";
      }
    }
     catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }

 
  }


 
}
