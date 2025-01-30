import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
//  String token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkZXZlbG9wZXIiOiJBYmR1bCBMYXRoZWVlZiIsImlhdCI6MTczNjUwMzIxMiwiZXhwIjoxNzQ0Mjc5MjEyLCJpc3MiOiJveGRvdGVjaG5vbG9naWVzLmNvbSJ9.kipkwHCADCDvqq-gD48YIUpR0I0AgMT8Fgl1GKrLGGI';
      
class Apiservice {
   
  static final _instance=Apiservice();
  factory Apiservice()=>_instance;
 
  static Dio dio=Dio()
  ..options=BaseOptions(
    baseUrl: ApiEndpoints.baseurl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: Duration(seconds: 60)
  );
  static Future<Response> post(
      {required String path, Map<String, dynamic>? queryParameters,Map<String,dynamic>? data,Map<String,dynamic>? headers}) async {
      

    try {
      final Response response =
          await dio.post(path,data: data,options: Options(headers: headers) );
     
      return response;
      
    } on DioException catch (e) {
      log("ttt");
      throw Exception(e);
    }
  }

  static Future<Response> get({required String path,Map<String,dynamic>? queryParameters,Map<String,dynamic>? headers}) async{
    try{
      final Response response =
      await dio.get(path,queryParameters: queryParameters,options: Options(headers: headers));
      // log(response.toString());
      return response;
      
    }
    on DioException catch (e) {
      throw Exception(e);
    }
  }
  }

