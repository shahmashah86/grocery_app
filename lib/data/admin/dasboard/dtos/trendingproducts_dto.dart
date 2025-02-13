

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/domain/admin/dashboard/model/trendingproduct_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class productsOfgetOrderDto extends Equatable {
  final int? quantity;
  final String? soldPrice;
  final String? productName;
  final ProductsDto? products;
 const productsOfgetOrderDto({
    this.products,
    this.quantity,
    this.soldPrice,
    this.productName,
  });


  factory productsOfgetOrderDto.fromMap(Map<String, dynamic> map) {
    return productsOfgetOrderDto(
      quantity: map['quantity'],
      soldPrice: map['soldPrice'],
      productName: map['productName'],
      products: map['product'] != null ? ProductsDto.fromJson(map['product'] as Map<String, dynamic>) : null 
    );
  }
    productOfgetOrder toModel() {
    return productOfgetOrder(
      quantity: quantity,
      soldPrice: soldPrice,
      productName: productName,
      products: products?.toModel()
 
      
      );
  }
  





  @override
  // TODO: implement props
  List<Object?> get props =>[    products,
   quantity,
  soldPrice,
    productName,];
}
