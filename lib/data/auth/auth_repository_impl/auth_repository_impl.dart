import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/auth/auth_dtos/auth_dto.dart';
import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/domain/auth/auth_repository/auth_repository.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  String? apikey;

  Future<void> addApikeyToPref(String apikey) async {
    log("New API Key: $apikey", name: "name");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apikeys', apikey);
  }

  Future<String?> readApikeyFromPref() async {
    log("inside readapikey");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyForAuth = prefs.getString('apikeys') ?? "";

    return keyForAuth;
  }

  Future<void> addTokenTopref(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenValue', token);
  }

  Future<void> addAdminToPref(bool admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('adminValue', admin);
  }

  @override
  Future<Map<String, dynamic>> signinWithEmailandPass(
      {required String username, required String password}) async {
    log(username);
    String? apiKeyForAuth = await readApikeyFromPref();
    log("Retrieved API Key: $apiKeyForAuth", name: "name");

    if (apiKeyForAuth == null || apiKeyForAuth == "") {
      // log(apiKeyForAuth.toString(),name: "inside post if null");

      await createApikey();
        apiKeyForAuth = await readApikeyFromPref();

    }

    try {
      // log(apiKeyForAuth.toString(),name: "inside post after ap creation");

      log("post");
      Map<String, dynamic> data = {"userName": username, "password": password};
      final Response response = await Apiservice.post(
          data: data,
          path: ApiEndpoints.signinUrl,
          headers: {"Authorization": "Bearer $apiKeyForAuth"});
      log(response.data.toString());
      if (response.statusCode == 200) {
        String token = response.data['token'];
        bool admin = response.data['isAdmin'];
         addTokenTopref(token);
        addAdminToPref(admin);
            log(token,name: "authtoken");
        AuthDto dto = AuthDto.fromJson(response.data);
        
       
       
        log(dto.toString(),name: "auth response");
    
        return response.data;
      } else {
        throw "Something went wrong in response";
      }
    }
    on DioException catch(e){
      log(e.response?.statusCode.toString()?? "Other code");
      log(e.response?.data.toString()?? "Other code");
      throw "Something wrong woth the request/code";
    }
    
    
     catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  //create the apikey
  Future<void> createApikey() async {
    log("createApikey");
    try {
      final Response response = await Apiservice.get(
          path: ApiEndpoints.createApiKey, headers: {"owner": "OXDO"});
      if (response.statusCode == 200) {
        apikey = response.data;
        addApikeyToPref(apikey!);

        // log(token.toString());
      } else {
        log("Unexpected status code: ${response.statusCode}");
        throw "Something went wrong in response";
      }
    } on DioException catch(e){
      log(e.response?.statusCode.toString()?? "Other code");
      log(e.response?.data.toString()?? "Other code");
      throw "Something wrong woth the request/code";
    }
    
    catch (e) {
      log(e.runtimeType.toString());
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }


  Future<String?> readtokenFromPref() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    return tokenFromAuth;
  }



  @override
  Future<List<AuthModel>> usersList() async {
    
    try {
      String? token = await readtokenFromPref();
         String path=ApiEndpoints.listAllusers;
      final Response response = await Apiservice.get(
        
          path: path,
          headers: {"Authorization": "Bearer $token"});
      // log(response.toString(),name: 'response of list all users');
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> users=response.data as List<dynamic>;
        
    return users.map((e)=>AuthDto.fromJson(e).toModel()).toList();
    
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'error from repository');
      throw "Something wrong woth the request/code";
    }
 
  }
}
