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
      {required String path, Map<String, dynamic>? queryParameters,dynamic data,Map<String,dynamic>? headers}) async {
      

    try {
      final Response response =
          await dio.post(path,data: data,options: Options(headers: headers,responseType: ResponseType.json),
           );
     
      return response;
      
    } on DioException catch (e) {
      log(e.response?.statusCode.toString()?? "Other code");
      log(e.response?.statusMessage.toString()?? "Other code");
      log(e.response?.data.toString()?? "Other code");
      log("ttt");
      throw Exception(e.response!.data);
    }
  }


   static Future<Response> put( 
      {required String path, Map<String, dynamic>? queryParameters,Map<String,dynamic>? data,Map<String,dynamic>? headers}) async {
      

    try {
      log(path);
      final Response response =
          await dio.put(path,data: data,options: Options(headers: headers) );
     
      return response;
      
    } 
    on DioException catch (e) {
      log("inside put apiservice");
      throw Exception(e);
    }
  }





  static Future<Response> get({required String path,Map<String,dynamic>? queryParameters,Map<String,dynamic>? headers}) async{
    try{
      
      final Response response =
      await dio.get(path,queryParameters: queryParameters,options: Options(headers: headers));
      log(response.toString(),name: 'direct dio repsonse');
      return response;
      
    }
    on DioException catch (e) {
      log(e.toString(),name: 'eror');
      if(e.type==DioExceptionType.connectionError){
        return Future.error("Connnection error:Please check your internet connection");
      }
        if(e.type==DioExceptionType.connectionTimeout){
        return Future.error("Please check your internet connection and try again");
      }
         log(e.response?.statusCode.toString()?? "Other code");
      log(e.response?.statusMessage.toString()?? "Other code");
      log(e.response?.data.toString()?? "Other code");
      throw Exception(e.response?.data);
    }
  }

   static Future<Response> delete( 
      {required String path, Map<String, dynamic>? queryParameters,Map<String,dynamic>? data,Map<String,dynamic>? headers}) async {
      

    try {
      log(path);
      final Response response =
          await dio.delete(path,data: data,options: Options(headers: headers) );
     
      return response;
      
    } 
    on DioException catch (e) {
      log("inside delete apiservice");
      throw Exception(e);
    }
  }
   static Future<Response> patch( 
      {required String path, Map<String, dynamic>? queryParameters, dynamic data,Map<String,dynamic>? headers}) async {
      

    try {
      log(path);
      //log(data,name: "formdata");
      log(headers.toString(),name: 'headers');
      final Response response =
          await dio.patch(path,data: data,options: Options(headers: headers,responseType: ResponseType.json) );
     
      return response;
      
    } 
    on DioException catch (e) {
      log(
        e.response?.data.toString() ?? "data is null",name: "message from server"
      );

      log(
        e.response?.statusMessage. toString() ?? "status message is null",name: 'message from server'
      );
      log("inside patch apiservice");
      throw Exception(e);
    }
  }


  }

