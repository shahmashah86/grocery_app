

import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';


// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderProductInfoModel extends Equatable {
 final int? productId;
 final int? quantity;
 final String? productName;
 final String? soldPrice;
 final ProductsModel? products;
 final String? unit;

 const  OrderProductInfoModel({
  this.productId,
 
    this.quantity,
    this.productName,
    this.soldPrice,
       this.products,
       this.unit
  });
  
  @override

  List<Object?> get props => [productName,quantity,soldPrice,products,productId,unit
 ];






}
