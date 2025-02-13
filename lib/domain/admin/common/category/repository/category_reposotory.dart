
import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';

abstract class CategoryRepository {
 Future<List<CategoryModel>> getAllCategories();
 Future<String> createCategory({required String name});
 Future updateCategory({required int id,required String catgeoryToUpdate});
 Future deleteCategory({required int id});
  
}