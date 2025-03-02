import 'dart:io';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';


abstract class ProductRepository {
  Future productRegistration(ProductRegModel products,File? imageFile);
  Future<List<ProductRegModel>> listAllproducts();
  Future productUpdation(ProductRegModel productsToUpdate,int id);
  Future productDeletion(int id);
  Future uploadImage({int id,String productName,File? imageFile});
  Future  getInventoryList();
  Future getproductbysearch(String prodName);
  Future getProduct(int productId);
}