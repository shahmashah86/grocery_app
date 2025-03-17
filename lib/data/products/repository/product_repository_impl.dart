import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/products/dtos/product_dto.dart';
import 'package:grocery_app/data/products/dtos/products_dto.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/repository/product_repository.dart';


import 'package:grocery_app/package/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl extends ProductRepository {
  Future<String?> readtokenFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenFromAuth = prefs.getString('tokenValue') ?? "";
    return tokenFromAuth;
  }

  @override
  Future productRegistration(ProductRegModel products, File? imageFile) async {
    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.post(
          data: products.toMap(),
          path: ApiEndpoints.productRegistration,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'response of product registration');
      if (response.statusCode == 200) {
        log("inside response");
        if (imageFile != null) {
          await uploadImage(
              id: response.data['productId'],
              imageFile: imageFile,
              productName: products.products.productName);
        }

        return response.data["message"];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
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
            .map((e) => ProductDto.fromMap(e).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  }

  @override
  Future productUpdation(ProductRegModel productsToUpdate, int id,File? imageFile) async {
    try {
      String? token = await readtokenFromPref();
      String path = '${ApiEndpoints.porductUpdate}$id';
      final Response response = await Apiservice.put(
          data: productsToUpdate.toMap(),
          path: path,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'response of product registration');
      if (response.statusCode == 200) {
        log("inside response");
         if (imageFile != null) {
          await uploadImage(
              id: id,
              imageFile: imageFile,
              productName: productsToUpdate.products.productName);
        }
        return response.data["message"];
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'response of request prod impl');
      rethrow;
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
     rethrow;
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
     rethrow;
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
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  }

  @override
  Future<List<ProductRegModel>> getproductbysearch(String prodName) async {
    try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
          queryParameters: {'productName': prodName},
          path: ApiEndpoints.searchProduct,
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'productsearch');
      if (response.statusCode == 200) {
        log("inside response of search product");
        List<dynamic> listOfproducts = response.data as List<dynamic>;
        return listOfproducts
            .map((e) => ProductDto.fromMap(e).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  }
  
  @override
  Future getProduct(int productId) async {
       try {
      String? token = await readtokenFromPref();
      final Response response = await Apiservice.get(
      
          path: '${ApiEndpoints.getAproduct}$productId',
          headers: {"Authorization": "Bearer $token"});
      log(response.toString(), name: 'productget');
      if (response.statusCode == 200) {
        log("inside response of get product");
        // List<dynamic products = response.data as List<dynamic>;
        return ProductsDto.fromJson(response.data).toModel();
            
            
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'error from repo');
      rethrow;
      // throw "Something wrong woth the request/code";
    }
  
  }
}
