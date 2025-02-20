// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/adapters.dart';
part 'cart_entity.g.dart';

@HiveType(typeId: 1)
class CartEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String prodName;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final String url;
  CartEntity(
      {required this.id,
      required this.prodName,
      required this.price,
      this.quantity = 1,
      required this.url});

  CartEntity copyWith(
      {int? id, String? prodName, double? price, int? quantity, String? url}) {
    return CartEntity(
        id: id ?? this.id,
        prodName: prodName ?? this.prodName,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        url: url ?? this.url);
  }
}
