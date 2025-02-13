import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';

abstract class OrderRespository {
Future<List<OrdersModel>> getOrdersList();
Future<List<OrdersModel>> getOrdersByUser(int userId);
Future acknowledgeOrder(int orderId);
}