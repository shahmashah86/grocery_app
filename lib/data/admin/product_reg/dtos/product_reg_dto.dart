import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:grocery_app/data/admin/common/category/dtos/category_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductRegDto extends Equatable {
   final ProductsDto product;
  final List<int> categories;

  ProductRegDto({required this.product, required this.categories});
  

factory ProductRegDto.fromModel(ProductRegModel productData){
  return ProductRegDto(product: ProductsDto.fromModel(productData.products), categories: productData.categories);
}

 ProductRegModel toModel() {
    return ProductRegModel(
    
    products: product.toModel(),
    categories: categories
      
      );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[product,categories];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'categories': categories,
    };
  }


  factory ProductRegDto.fromMap(Map<String, dynamic> map) {
    return ProductRegDto(
      product: ProductsDto.fromJson(map['product'] as Map<String,dynamic>),
      categories: (map['categories'] as List<dynamic>).map((e)=>e as int).toList(),
    );
  }

  }
