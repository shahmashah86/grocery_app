import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_app/core/constant/api_endpoints.dart';
import 'package:grocery_app/data/admin/common/category/dtos/category_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/product_reg_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';
import 'package:grocery_app/domain/admin/common/category/repository/category_reposotory.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/package/apiservice.dart';
import 'package:grocery_app/presentation/bloc/category/category_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  Future<String?> readtokenFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenFromAuth = prefs.getString('tokenValue') ?? "";

    return tokenFromAuth;
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      String? token = await readtokenFromPref();

      // log("category");

      final Response response = await Apiservice.get(
          path: ApiEndpoints.listAllCategories,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response of category");

        List<dynamic> jsonresponse = response.data;
        return jsonresponse
            .map((toElement) => CategoryDto.fromMap(toElement).toModel())
            .toList();
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'exception from impl');
      rethrow;
    }
  }

  @override
  Future<String> createCategory({required String name}) async {
    try {
      String? token = await readtokenFromPref();
      log(name);

      log("category");
      Map<String, dynamic> data = {"name": name};
      final Response response = await Apiservice.post(
          data: data,
          path: ApiEndpoints.createCategory,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        log("inside response of categoryCreation");
        return 'successful';
           
      } else {
        throw "Something went wrong in response";
      }
    } catch (e) {
      log(e.toString(),name: 'dio exception catched from implementation');
      throw "Something wrong woth the request/code";
    }
  }
  
  @override
  Future<void> updateCategory({required int id,required String catgeoryToUpdate}) async{
  try{
      String? token = await readtokenFromPref();
         Map<String, dynamic> dataToUpdate = {"id":id,"name": catgeoryToUpdate};
         String path='${ApiEndpoints.updateCategory}$id';
         final Response response= await Apiservice.put(path:path,
         data: dataToUpdate,headers:  {"Authorization": "Bearer $token"}      
         );

         if(response.statusCode==200){

              log("inside response of categoryupdation");
        return response.data;
           
         }
          else {
        throw "Something went wrong in response";
      }

  }
  catch(e){
          log(e.toString());
      throw "Something wrong woth the request/code";

  }
}

  @override
  Future deleteCategory({required int id})async {
     try{
      String? token = await readtokenFromPref();
        //  Map<String, dynamic> categoryDelete = {"id":id};
         String path='${ApiEndpoints.deleteCategory}$id';
         final Response response= await Apiservice.delete(path:path,
        //  data: categoryDelete,
         headers:  {"Authorization": "Bearer $token"}      
         );

         if(response.statusCode==200){

              log("inside response of categorydeletion");
        return response.data;
           
         }
          else {
        throw "Something went wrong in response";
      }

  }
  catch(e){
          log(e.toString());
      throw "Something wrong woth the request/code";

  }
    

  }
  
  @override
  Future<List<ProductsModel>> listallCategories(int id)  async{
     try{
      String? token = await readtokenFromPref();
        //  Map<String, dynamic> categoryDelete = {"id":id};
         String path='${ApiEndpoints.listproductundercategory}$id';
         final Response response= await Apiservice.get(path:path,
        headers:  {"Authorization": "Bearer $token"}      
         );

         if(response.statusCode==200){

              log("inside response of productsunderacategory");
        List<dynamic> productofCategory=(response.data);
        return productofCategory.map((e)=>ProductsDto.fromJson(e).toModel()).toList();
           
         }
          else {
        throw "Something went wrong in response";
      }

  }
  catch(e){
          log(e.toString());
      throw "Something wrong woth the request/code";

  }
   
  }
}