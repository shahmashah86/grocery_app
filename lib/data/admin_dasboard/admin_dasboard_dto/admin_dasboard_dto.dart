// ignore_for_file: public_member_api_docs, sort_constructors_first




import 'package:grocery_app/data/banner/banner_dto/banner_dto.dart';
import 'package:grocery_app/data/order/dtos/order_dtos.dart';
import 'package:grocery_app/data/products/dtos/products_dto.dart';
import 'package:grocery_app/domain/admindashboard/model/admindasboard_model.dart';

class AdminDasboardDto {
   List<BannerDto>? banner;
  // List<ProductsDto>? trendingProducts;
  List<OrderDtos>? orders;

 final String? usersCount;
 final String? productCount;
 final String? stockOutProductCount;
 final List<ProductsDto> trendingProducts;
final List<OrderDtos>? allOrders;
   AdminDasboardDto({
    this.banner,
   this.orders,
   required this.trendingProducts,
    required this.usersCount,
    required this.productCount,
    required this.stockOutProductCount,
   this.allOrders=const[],
  });
  



  factory AdminDasboardDto.fromJson(Map<String,dynamic> json) {
    return AdminDasboardDto(
       banner: json['banners']!=null?List<BannerDto>.from((json['banners'] as List<dynamic>).map<BannerDto>((x) => BannerDto.fromMap(x as Map<String,dynamic>),),):null,
      usersCount: json['usersCount'],
      productCount: json['productCount'],
      stockOutProductCount: json['stockOutProductCount'],
     trendingProducts: (json['trendingProducts'] as List ).map((e)=>ProductsDto.fromJson(e)).toList(),
      allOrders: json['allOrders'] != null
    ? (json['allOrders'] as List)
        .map((e) => OrderDtos.fromMap(e as Map<String, dynamic>))
        .toList()
    : []

    );
  }
    AdmindasboardModel toModel() {
    return AdmindasboardModel(
         banners: banner?.map((toElement)=>toElement.toModel()).toList()??[],
        usersCount: usersCount,
         productCount: productCount,
        stockOutProductCount: stockOutProductCount,
       trendingProducts:trendingProducts.map((element)=>element.toModel()).toList(),
        allorders:allOrders?.map((element)=>element.toModel()).toList()??[]
        );
  }
 


}



