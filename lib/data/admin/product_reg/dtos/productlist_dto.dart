// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:grocery_app/data/admin/product_reg/dtos/product_reg_dto.dart';

class ProductlistDto extends Equatable {
  List<ProductRegDto> productlist;
  ProductlistDto({
   required this.productlist,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

 

  factory ProductlistDto.fromMap(List<dynamic> responseList) {
    return ProductlistDto(
    productlist:responseList.map((toElement)=>ProductRegDto.fromMap(toElement)).toList()

    );
  }



}
