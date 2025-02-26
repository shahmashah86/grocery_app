


import 'package:grocery_app/data/banner/banner_dto/banner_dto.dart';
import 'package:grocery_app/data/order/dtos/order_dtos.dart';
import 'package:grocery_app/data/products/dtos/products_dto.dart';
import 'package:grocery_app/domain/userdashboard/model/user_dashboard_model.dart';





class UserDashboardDto {
  List<BannerDto> banner;
  List<ProductsDto> trendingProducts;
  List<OrderDtos> orders;
  UserDashboardDto({
    required this.banner,
    required this.trendingProducts,
    required this.orders,
  });



  factory UserDashboardDto.fromMap(Map<String, dynamic> map) {
    return UserDashboardDto(
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

