import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/auth/auth_dtos/auth_dto.dart';
import 'package:grocery_app/domain/auth/auth_model/auth_model.dart';
import 'package:grocery_app/domain/auth/auth_repository/auth_repository.dart';
import 'package:grocery_app/package/apiservice.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  String? apikey;

//using shared preference to store apikey,token,isadmin for login prurpose
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

  Future<void> addUsername(String userName) async {
    log("user_Name: $userName", name: "username");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
  }

  Future<void> addTokenTopref(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenValue', token);
  }

  Future<String?> readtokenFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    return tokenFromAuth;
  }

  Future<void> addAdminToPref(bool admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('adminValue', admin);
  }

//use sharedprefs for update userdetails and upload profilr image
  Future<void> saveUserData({
    String? name,
    required String email,
    String? phone,
    String? imageUrl,
    required int id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (name != null) {
      await prefs.setString('name', name);
    }

    await prefs.setString('user_email', email); // Email is always required

    if (prefs.getString('name') == null) {
      String defaultName =
          email.split('@')[0]; //if name not provided use it from email
      await prefs.setString('name', defaultName);
    }

    if (phone != null) {
      // log(phone);
      await prefs.setString('user_phone', phone);
    }

    if (imageUrl != null) {
      await prefs.setString('user_image_url', imageUrl);
    }

    await prefs.setInt('user_id', id);
  }

//Log in by user
  @override
  Future<Map<String, dynamic>> signinWithUserandPass(
      {required String username, required String password}) async {
    // log(username);

    String? apiKeyForAuth = await readApikeyFromPref();
    log("Retrieved API Key: $apiKeyForAuth", name: "name");

    if (apiKeyForAuth == null || apiKeyForAuth == "") {
      await createApikey();
      apiKeyForAuth = await readApikeyFromPref();
    }

    try {
      Map<String, dynamic> data = {"userName": username, "password": password};
      final Response response = await Apiservice.post(
          data: data,
          path: ApiEndpoints.signinUrl,
          headers: {"Authorization": "Bearer $apiKeyForAuth"});
      log(response.data.toString());
      if (response.statusCode == 200) {
        await addUsername(username);

        String token = response.data['token'];
        bool admin = response.data['isAdmin'];
        addTokenTopref(token);
        addAdminToPref(admin);

        saveUserData(
            name: response.data['name'],
            email: response.data['email'],
            phone: response.data['phoneNumber'],
            imageUrl: response.data['profileImage'],
            id: response.data['id']);
        log(token, name: "authtoken");
        AuthDto dto = AuthDto.fromJson(response.data);

        log(dto.toString(), name: "auth response");
        return response.data;
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(), name: 'error from impl');
      rethrow;
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
    } on DioException catch (e) {
      log(e.response?.statusCode.toString() ?? "Other code");
      log(e.response?.data.toString() ?? "Other code");
      throw "Something wrong with the request or code";
    } catch (e) {
      log(e.runtimeType.toString());
      log(e.toString());
      throw "Something wrong with the request or code";
    }
  }

//list all users by admin
  @override
  Future<List<AuthModel>> usersList() async {
    try {
      String? token = await readtokenFromPref();
      String path = ApiEndpoints.listAllusers;
      final Response response = await Apiservice.get(
          path: path, headers: {"Authorization": "Bearer $token"});
      // log(response.toString(),name: 'response of list all users');
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> users = response.data as List<dynamic>;

        return users.map((e) => AuthDto.fromJson(e).toModel()).toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(), name: 'error from repository');
      rethrow;
    }
  }

  //user registration

  @override
  Future signupWithUserandPass(
      {required email, required username, required password}) async {
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
      Map<String, dynamic> data = {
        "email": email,
        "userName": username,
        "password": password,
        'isAdmin': false
      };
      final Response response = await Apiservice.post(
          data: data,
          path: ApiEndpoints.signupUrl,
          headers: {"Authorization": "Bearer $apiKeyForAuth"});
      log(response.data.toString());
      if (response.statusCode == 200) {
        String token = response.data['token'];
        bool admin = response.data['isAdmin'];

        addTokenTopref(token);
        addAdminToPref(admin);
        log(token, name: "authtoken");
        saveUserData(
            name: response.data['name'],
            email: response.data['email'],
            phone: response.data['phoneNumber'],
            imageUrl: response.data['profileImage'],
            id: response.data['id']);

        AuthDto dto = AuthDto.fromJson(response.data);

        log(dto.toString(), name: "auth response");

        return response.data;
      } else {
        throw "Something went wrong in response";
      }
    } on DioException catch (e) {
      log(e.response?.statusCode.toString() ?? "Other code");
      log(e.response?.data.toString() ?? "Other code");
      throw "Something wrong woth the request/code";
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  }

  //upload profile image
  @override
  Future uploadprofileImage({File? profileImage, int? id}) async {
    log(profileImage!.path, name: 'imagefile');
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(profileImage.path,
          contentType: DioMediaType("image", '*'))
    });
    try {
      String? token = await readtokenFromPref();
      String path = '${ApiEndpoints.profileImage}$id';
      final Response response = await Apiservice.patch(
        data: formData,
        path: path,
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'multipart/form-data'
        },
      );
      log(response.toString(), name: 'response of image registration');
      if (response.statusCode == 200) {
        // log("inside response");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? currentEmail = prefs.getString('user_email');
        int? id = prefs.getInt('user_id');

        await saveUserData(
            email: currentEmail!, imageUrl: response.data['image'], id: id!);

        return response.data['image'];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

//delete a user
  @override
  Future deleteUser({required int userid}) async {
    try {
      String? token = await readtokenFromPref();

      log("userDashboard in admin");

      final Response response = await Apiservice.delete(
          path: '${ApiEndpoints.deleteuser}$userid',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");

        return response.toString();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//reset password
  @override
  Future resetPassword({required String userName}) async {
    try {
      String? token = await readtokenFromPref();

      final Response response = await Apiservice.post(
          path: '${ApiEndpoints.foregetpassword}$userName',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response");

        return response.toString();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//update a user
  @override
  Future updateUser({required int userIdforupdate, AuthModel? authinfo}) async {
    try {
      // log(authinfo!.toMap().toString());
      String? token = await readtokenFromPref();
      log(authinfo.toString(),name:"User info To Update");
      final Response response = await Apiservice.put(
          path: '${ApiEndpoints.updateUser}$userIdforupdate',
          data: authinfo?.toMap(),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        log(response.data['user'].toString(), name: 'response update user');
        await saveUserData(
            email: response.data['user']['email'],
            id: response.data['user']['id'],
            name: response.data['user']['name'],
            phone: response.data['user']['phoneNumber']);
        final responsedata = AuthDto.fromJson(response.data['user']).toModel();
        final responseUpdated={'message':response.data['message'],'updatedinfo':responsedata};

        return responseUpdated;
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(), name: 'error response');
      rethrow;
    }
  }
}
