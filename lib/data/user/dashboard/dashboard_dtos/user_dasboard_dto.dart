// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:grocery_app/data/admin/dasboard/dtos/common/order_dtos.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/data/common/banner/banner_dto/banner_dto.dart';
import 'package:grocery_app/domain/user/dashboard/model/user_dashboard_model.dart';
import 'package:grocery_app/presentation/screens/admin/product/trending_products.dart';

class UserDasboardDto {
  List<BannerDto> banner;
  List<ProductsDto> trendingProducts;
  List<OrderDtos> orders;
  UserDasboardDto({
    required this.banner,
    required this.trendingProducts,
    required this.orders,
  });






  factory UserDasboardDto.fromMap(Map<String, dynamic> map) {
    return UserDasboardDto(
      banner: List<BannerDto>.from((map['banners'] as List<dynamic>).map<BannerDto>((x) => BannerDto.fromMap(x as Map<String,dynamic>),),),
      trendingProducts: List<ProductsDto>.from((map['trendingProducts'] as List<dynamic>).map<ProductsDto>((x) => ProductsDto.fromJson(x as Map<String,dynamic>),),),
      orders: List<OrderDtos>.from((map['recentOrders'] as List<dynamic>).map<OrderDtos>((x) => OrderDtos.fromMap(x as Map<String,dynamic>),),),
    );
  }

  UserDashboardModel toModel() {
    return UserDashboardModel(
       banners: banner.map((toElement)=>toElement.toModel()).toList()
       ,trendingProducts:trendingProducts.map((element)=>element.toModel()).toList(),
      recentorders:orders.map((element)=>element.toModel()).toList()
        );
  }


 
}

