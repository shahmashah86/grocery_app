// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/common/model/banner/banner_model/banner_model.dart';
import 'package:grocery_app/presentation/screens/admin/product/trending_products.dart';

class UserDashboardModel extends Equatable {
List<ProductsModel> trendingProducts;
List<BannerModel> banners;
List<OrdersModel> recentorders;




  UserDashboardModel({
    required this.trendingProducts,
    required this.banners,
    required this.recentorders,
  });
  
  @override

  List<Object?> get props => [trendingProducts, recentorders,banners 
  ];


 
}
