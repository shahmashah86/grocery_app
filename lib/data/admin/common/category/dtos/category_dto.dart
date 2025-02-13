// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:grocery_app/domain/admin/common/category/model/category_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';

class CategoryDto extends Equatable {

 final int id;
 final String name;

  const CategoryDto({required this.id, required this.name});

  @override
  List<Object?> get props => [id,name];
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

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
