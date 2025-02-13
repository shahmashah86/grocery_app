// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:grocery_app/data/admin/dasboard/dtos/common/order_dtos.dart';
import 'package:grocery_app/data/admin/dasboard/dtos/trendingproducts_dto.dart';

import 'package:grocery_app/domain/common/model/order_byid_model/order_byid_model.dart';

class OrderByidDto {
  final OrderDtos orders;
  final List<productsOfgetOrderDto> products;
  OrderByidDto({
    required this.orders,
    required this.products,
  });


  factory OrderByidDto.fromMap(Map<String, dynamic> map) {
    return OrderByidDto(
      orders: OrderDtos.fromMap(map['order'] as Map<String,dynamic>),
      products: (map['products'] as List).map((e) => productsOfgetOrderDto.fromMap(e)).toList()
    );
  }

  OrderByidModel toModel(){
  return OrderByidModel(order: orders.toModel(),
   product: products.map((e) => e.toModel()).toList());

}


}



  //  AdmindasboardModel toModel() {
  //   return AdmindasboardModel(
  //       usersCount: usersCount,
  //        productCount: productCount,
  //       stockOutProductCount: stockOutProductCount,
  //      trendingProducts:trendingProducts.map((element)=>element.toModel()).toList(),
  //       allorders:allOrders.map((element)=>element.toModel()).toList()
  //       );
  // }