// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

class ProductsDto extends Equatable {
  final int? id;
  final String? productName;
  final String? productDescription;
  final double? price;
  final String? image;
  final String? unit;
  final bool? isAvailable;
  final bool? isTrending;
  final double? stockQuantity;
  final int? quantity;

  ProductsDto({this.id,required this.productName, required this.productDescription, required this.price, 
   this.image, required this.unit, required this.isAvailable, required this.isTrending, required this.stockQuantity,this.quantity});
  @override

  List<Object?> get props => [id,productName,productDescription,price,image,unit,isAvailable,isTrending,stockQuantity];
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'productName': productName,
      'productDescription': productDescription,
      'price': price.toString(),
      'image': image,
      'unit': unit,
      'isAvailable': isAvailable,
      'isTrending': isTrending,
      'stockQuantity': stockQuantity,
    };
  }
factory ProductsDto.fromJson(Map<String,dynamic> json){
  return ProductsDto(id: json['id'],
    productName: json['productName'], 
  productDescription: json['productDescription'], 
  price: double.tryParse(json['price'].toString())??0.0, 
  unit: json['unit'], 
  image: json['image'],
  isAvailable: json['isAvailable'],
   isTrending:json['isTrending'],
    stockQuantity:double.tryParse(json['stockQuantity'].toString())??0.0);
}

 ProductsModel toModel() {
    return ProductsModel(
      id: id,
      productName: productName,
      productDescription: productDescription,
      price: price,
      image: image,
      unit: unit,
      isAvailable: isAvailable,
      isTrending: isTrending,
      stockQuantity: stockQuantity
      
      );
  }




factory ProductsDto.fromModel(ProductsModel product){
  return ProductsDto(productName: product.productName??'', productDescription:product.productDescription??'', 
  price: product.price??0, unit:product.unit??'', isAvailable:product.isAvailable??false, 
  isTrending:product.isTrending??false, stockQuantity:product.stockQuantity??0);
}

 
}
