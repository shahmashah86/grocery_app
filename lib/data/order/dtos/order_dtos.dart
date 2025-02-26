

import 'package:grocery_app/data/order/dtos/order_product_info_dto.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';

class OrderDtos {
  final int? id;
  final String? dateTime;
  final int? totalItems;
  final String? totalAmount;
  final bool? acknowledged;
  final int? userId;
  final List<OrderProductInfoDto>? products;
  const OrderDtos({
    required this.id,
    this.dateTime,
    this.totalItems,
    required this.totalAmount,
    required this.acknowledged,
    required this.userId,
    this.products,
  });

  OrdersModel toModel() {
    return OrdersModel(
        dateTime: dateTime ?? '',
        totalAmount: totalAmount,
        totalItems: totalItems ?? 0,
        id: id,
        acknowledged: acknowledged,
        userId: userId,
        product: products?.map((e) => e.toModel()).toList());
  }

  factory OrderDtos.fromMap(Map<String, dynamic> map) {
    return OrderDtos(
      id: map['id'],
      dateTime: map['dateTime'],
      totalItems: map['totalItems'],
      totalAmount: map['totalAmount'],
      acknowledged: map['acknowledged'],
      userId: map['userId'],
      products: map['products'] != null
          ? List<OrderProductInfoDto>.from(
              (map['products'] as List<dynamic>).map<OrderProductInfoDto?>(
                (x) => OrderProductInfoDto.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
