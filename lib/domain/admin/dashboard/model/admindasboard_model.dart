

import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/dashboard/model/trendingproduct_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

class AdmindasboardModel  extends Equatable{
  String? usersCount;
  String? productCount;
  String? stockOutProductCount;
 List<ProductsModel> trendingProducts;
 List<OrdersModel> allorders;
  AdmindasboardModel({
    this.usersCount,
    this.productCount,
    this.stockOutProductCount,
    required this.trendingProducts,
    required this.allorders,
  });
  
  @override

  List<Object?> get props => [  usersCount,  productCount,stockOutProductCount,trendingProducts,  allorders
  ];


 
}