

import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class productOfgetOrder extends Equatable {

 final int? quantity;
 final String? productName;
 final String? soldPrice;
 final ProductsModel? products;

  productOfgetOrder({
    this.products,
    this.quantity,
    this.productName,
    this.soldPrice,
  });
  
  @override

  List<Object?> get props => [productName,quantity,soldPrice,products
 ];






}
