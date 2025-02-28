


import 'package:grocery_app/data/products/dtos/products_dto.dart';
import 'package:grocery_app/domain/orders/model/order_product_info_model.dart';






// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderProductInfoDto  {
  final int? productId;
  final int? quantity;
  final String? soldPrice;
  final String? productName;
  final ProductsDto? products;
  final String? unit;
 const OrderProductInfoDto( {this.productId,
   
    this.quantity,
    this.soldPrice,
    this.productName,
     this.products,
     this.unit
  });


  factory OrderProductInfoDto.fromMap(Map<String, dynamic> map) {
    return OrderProductInfoDto(
      productId:map['productId'],
      quantity: map['quantity'],
      soldPrice: map['soldPrice'],
      productName: map['productName'],
      products: map['product'] != null ? ProductsDto.fromJson(map['product'] as Map<String, dynamic>) : null ,
      unit: map['unit']
    );
  }
  
    OrderProductInfoModel toModel() {
    return OrderProductInfoModel(
      productId: productId,
      quantity: quantity,
      soldPrice: soldPrice,
      productName: productName,
      products: products?.toModel()  ,
      unit: unit
      );
  }
  






}
