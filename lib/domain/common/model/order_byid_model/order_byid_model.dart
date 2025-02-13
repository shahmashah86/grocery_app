import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/domain/admin/dashboard/model/trendingproduct_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';

class OrderByidModel {
  final OrdersModel order;
  final List<productOfgetOrder>product;

  OrderByidModel({required this.order, required this.product});


}