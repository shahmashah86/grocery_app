import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/banner/banner_model.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';





class AdmindasboardModel extends Equatable {
  List<BannerModel>? banners;
  String? usersCount;
  String? productCount;
  String? stockOutProductCount;
  List<ProductsModel> trendingProducts;
  List<OrdersModel> allorders;
  AdmindasboardModel({
    this.banners,
    this.usersCount,
    this.productCount,
    this.stockOutProductCount,
    required this.trendingProducts,
    required this.allorders,
  });

  @override
  List<Object?> get props => [
        usersCount,
        productCount,
        stockOutProductCount,
        trendingProducts,
        allorders,
        banners
      ];
}
