import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/user/dashboard/dashboard_dtos/user_dasboard_dto.dart';
import 'package:grocery_app/domain/user/dashboard/repository/dasboard_repo.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DasboardRepoImpl implements DasboardRepo {
          Future<String?> readtokenFromPref() async {
    // log("From onboarding");
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    
    return tokenFromAuth;
  }



  @override
  Future getUserDasboard()  async{

     try {
  
      String? token= await readtokenFromPref();

      log("userDashboard");

      final Response response = await Apiservice.get(
      
          path: ApiEndpoints.userDasboard,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        
        UserDasboardDto dashboardData=UserDasboardDto.fromMap(response.data);
       
        return dashboardData.toModel();
       
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
 
  
  }
}