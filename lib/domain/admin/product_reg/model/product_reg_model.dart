import 'package:equatable/equatable.dart';


import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductRegModel extends Equatable {

  final ProductsModel products;
  final List<int> categories;

  const ProductRegModel({
    required this.products,
    required this.categories,
  });
  
  @override
   List<Object?> get props => [products,categories];


}
