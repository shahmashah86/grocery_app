
import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/banner/banner_model.dart';


import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';


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
