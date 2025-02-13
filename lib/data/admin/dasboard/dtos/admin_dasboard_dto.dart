// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/common/order_dtos.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/trendingproducts_dto.dart';
import 'package:grocery_app/data/admin/product_reg/dtos/products_dto.dart';
import 'package:grocery_app/domain/admin/dashboard/model/admindasboard_model.dart';


class AdminDasboardDto extends Equatable {

 final String usersCount;
 final String productCount;
 final String stockOutProductCount;
 final List<ProductsDto> trendingProducts;
final List<OrderDtos> allOrders;
  const AdminDasboardDto({
    required this.usersCount,
    required this.productCount,
    required this.stockOutProductCount,
    required this.trendingProducts,
    required this.allOrders,
  });
  



  factory AdminDasboardDto.fromJson(Map<String,dynamic> json) {
    return AdminDasboardDto(
      usersCount: json['usersCount'],
      productCount: json['productCount'],
      stockOutProductCount: json['stockOutProductCount'],
     trendingProducts: (json['trendingProducts'] as List ).map((e)=>ProductsDto.fromJson(e)).toList(),
      allOrders:(json['allOrders'] as List).map((e)=>OrderDtos.fromMap(e)).toList()
    );
  }
    AdmindasboardModel toModel() {
    return AdmindasboardModel(
        usersCount: usersCount,
         productCount: productCount,
        stockOutProductCount: stockOutProductCount,
       trendingProducts:trendingProducts.map((element)=>element.toModel()).toList(),
        allorders:allOrders.map((element)=>element.toModel()).toList()
        );
  }
    @override

  List<Object?> get props =>[usersCount, productCount,stockOutProductCount,trendingProducts,allOrders];


}



