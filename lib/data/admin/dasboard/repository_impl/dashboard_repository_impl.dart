import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/admin_dasboard_dto.dart';
import 'package:grocery_app/domain/admin/dashboard/model/admindasboard_model.dart';
import 'package:grocery_app/domain/admin/dashboard/repository/dashboard_repository.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardRepositoryImpl implements DashboardRepository {

    Future<String?> readtokenFromPref() async {
    // log("From onboarding");
    
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    
    return tokenFromAuth;
  }



  @override
  Future<AdmindasboardModel> getAdminDashboardData()async {
     try {
  
      String? token= await readtokenFromPref();

      log("AdminDashboard");

      final Response response = await Apiservice.get(
      
          path: ApiEndpoints.adminDasboard,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");
        
        AdminDasboardDto dashboardData=AdminDasboardDto.fromJson(response.data);
       
        return dashboardData.toModel();
       
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }




  @override
  bannercreation(List<File?> imageFile)  async{
     List<MultipartFile> fileList = [];
     for (var file in imageFile) {
      fileList.add(await MultipartFile.fromFile(file!.path,contentType:DioMediaType("image", '*') ));
    }
    log(fileList.toString());
    FormData formData = FormData.fromMap({

      
      'banners':fileList,
      // [await MultipartFile.fromFile(imageFile!.path,
      //     contentType: DioMediaType("image", '*')
      
      //     ),
      //     await MultipartFile.fromFile(imageFile!.path,
      //     contentType: DioMediaType("image", '*')
      
      //     ),
          
      //     ]
    });


    try {
      String? token = await readtokenFromPref();
      String path = ApiEndpoints.bannerCraetion;
      final Response response = await Apiservice.post(
          data: formData,
          path: path,
          headers: {
            "Authorization": "Bearer $token",
            'Content-Type': 'multipart/form-data'
          },
          );


      log(response.toString(), name: 'response of image registration');
      if (response.statusCode == 200) {
        log("inside response");
        return response.data;
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
 
  }
 
}