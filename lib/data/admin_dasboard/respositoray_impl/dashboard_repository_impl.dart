import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin_dasboard/admin_dasboard_dto/admin_dasboard_dto.dart';
import 'package:grocery_app/domain/admindashboard/model/admindasboard_model.dart';
import 'package:grocery_app/domain/admindashboard/repository/dashboard_repository.dart';

import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  Future<String?> readtokenFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";

    return tokenFromAuth;
  }

//load admin dashboard
  @override
  Future<AdmindasboardModel> getAdminDashboardData() async {
    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
          path: ApiEndpoints.adminDasboard,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        AdminDasboardDto dashboardData =
            AdminDasboardDto.fromJson(response.data);
        return dashboardData.toModel();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//create banner
  @override
  bannercreation(List<File?> imageFile) async {
    //banners are sending in list.
    List<MultipartFile> fileList = [];
    for (var file in imageFile) {
      fileList.add(await MultipartFile.fromFile(file!.path,
          contentType: DioMediaType("image", '*')));
    }
    log(fileList.toString());
    FormData formData = FormData.fromMap({
      'banners': fileList,
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
        return 'succesfully uploaded';
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  //user dasboard loading for banner listing to admin for deleting banner 
  @override
  Future getUserDasboard() async {
    try {
      String? token = await readtokenFromPref();

      // log("userDashboard in admin");

      final Response response = await Apiservice.get(
          path: ApiEndpoints.userDasboard,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");

        AdminDasboardDto dashboardData =
            AdminDasboardDto.fromJson(response.data);

        return dashboardData.toModel();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //banner delete by admin.

  @override
  Future bannerDelete(int indextoDelete) async {
    try {
      String? token = await readtokenFromPref();

      final Response response = await Apiservice.delete(
          path: '${ApiEndpoints.bannerdelete}$indextoDelete',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        return response;
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
