import 'dart:io';

import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';


abstract class ProductRegRepository {
  Future productRegistration(ProductRegModel products,File? imageFile);
  Future<List<ProductRegModel>> listAllproducts();
  Future productUpdation(ProductRegModel productsToUpdate,int id);
  Future productDeletion(int id);
  Future uploadImage({int id,String productName,File? imageFile});
  Future  getInventoryList();
  Future getproductbysearch(String prodName);
}