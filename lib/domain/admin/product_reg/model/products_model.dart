// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
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


 const  ProductsModel({this.id,this.quantity
  ,required this.productName, required this.productDescription, required this.price, this.image, required this.unit, required this.isAvailable, required this.isTrending, required this.stockQuantity});
  
  @override
  
  List<Object?> get props =>[
    id,
   productName,
 productDescription,
  price,
   image,
  unit,isAvailable, stockQuantity

  ];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productDescription': productDescription,
      'price': price,
      'image': image,
      'unit': unit,
      'isAvailable': isAvailable,
      'isTrending': isTrending,
      'stockQuantity': stockQuantity,
      'quantity': quantity,
    };
  }






  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'],
      productName: map['productName'],
      productDescription: map['productDescription'] ,
      price: map['price'],
      image: map['image'] ,
      unit: map['unit'],
      isAvailable: map['isAvailable'],
      isTrending: map['isTrending'],
      stockQuantity: map['stockQuantity'] ,
      quantity: map['quantity'] 
    );
  }

  
}
