


import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';

abstract class CategoryRepository {
 Future<List<CategoryModel>> getAllCategories();
 Future<String> createCategory({required String name});
 Future updateCategory({required int id,required String catgeoryToUpdate});
 Future deleteCategory({required int id});
 Future<List<ProductsModel>> listallCategories(int id);
  
}