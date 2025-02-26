
import 'package:grocery_app/domain/category/model/category_model.dart';

class CategoryDto  {

 final int id;
 final String name;

  const CategoryDto({required this.id, required this.name});


  

 

  factory CategoryDto.fromMap(Map<String, dynamic> map) {
    return CategoryDto(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }


 CategoryModel toModel(){
  return CategoryModel(id: id, name: name);
}

}
