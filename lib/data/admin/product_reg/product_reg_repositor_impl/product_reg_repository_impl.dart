import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/product_reg_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/productlist_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/repository/product_reg_repository.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:grocery_app/presentation/screens/admin/product/product_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRegRepositoryImpl extends ProductRegRepository {
  Future<String?> readtokenFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    return tokenFromAuth;
  }

  @override
  Future productRegistration(ProductRegModel products,File? imageFile) async {
    log(ProductRegDto.fromModel(products).toMap().toString(),
        name: "Product to register");

    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.post(
          data: ProductRegDto.fromModel(products).toMap(),
          path: ApiEndpoints.productRegistration,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'response of product registration');
      if (response.statusCode == 200) {
        log("inside response");
        if(imageFile!=null){
        await uploadImage(id: response.data['productId'],imageFile: imageFile,productName: products.products.productName);
          
        }
    
        return response.data["message"];
        
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  @override
  Future<List<ProductRegModel>> listAllproducts() async {
    // log("From listallproducts implementation",
    //     name: "Product to register");

    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
          path: ApiEndpoints.listAllProducts,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'list all products');
      if (response.statusCode == 200) {
        log("inside response");
        List<dynamic> listOfproducts = response.data as List<dynamic>;
        return listOfproducts
            .map((e) => ProductRegDto.fromMap(e).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  @override
  Future productUpdation(ProductRegModel productsToUpdate, int id) async {
    log(ProductRegDto.fromModel(productsToUpdate).toMap().toString(),
        name: "Product to update");

    try {
      String? token = await readtokenFromPref();
      String path = '${ApiEndpoints.porductUpdate}$id';
      final Response response = await Apiservice.put(
          data: ProductRegDto.fromModel(productsToUpdate).toMap(),
          path: path,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'response of product registration');
      if (response.statusCode == 200) {
        log("inside response");
        return response.data["message"];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  @override
  Future productDeletion(int id) async {
    log(id.toString());

    try {
      String? token = await readtokenFromPref();
      String path = '${ApiEndpoints.deleteProduct}$id';
      final Response response = await Apiservice.delete(
          path: path, headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'response of product registration');
      if (response.statusCode == 200) {
        log("inside response");
        return response.data["message"];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  @override
  Future uploadImage({int? id, String? productName, File? imageFile}) async {
    log(imageFile!.path, name: 'imagefile');

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path,
          contentType: DioMediaType("image", '*'))
    });

// filename: "product_$id.jpg"
    try {
      String? token = await readtokenFromPref();
      String path = '${ApiEndpoints.updateProductImage}$id/$productName';
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
        log("inside response");
        return response.data['message'];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }

  @override
  Future getInventoryList() async {
    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
          path: ApiEndpoints.getInventoryList,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'inventory list');
      if (response.statusCode == 200) {
        log("inside response of get inventory");
        List<dynamic> listOfproducts = response.data as List<dynamic>;
        return listOfproducts
            .map((e) => ProductsDto.fromJson(e).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      throw "Something wrong woth the request/code";
    }
  }
}
