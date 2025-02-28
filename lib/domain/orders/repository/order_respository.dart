

import 'package:grocery_app/domain/orders/model/order_model.dart';
import 'package:grocery_app/domain/place_order_model/place_order_model.dart';


abstract class OrderRespository {
Future<List<OrdersModel>> getOrdersList();
Future<List<OrdersModel>> getOrdersByUser(int userId);
Future acknowledgeOrder(int orderId);
Future placeOrder(PlaceOrderModel details);
Future<OrdersModel> getAnOrderbyId(int id);
Future<String> cancelOrder(int orderId);
}