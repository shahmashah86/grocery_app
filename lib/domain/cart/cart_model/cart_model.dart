import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final String prodName;
  final double price;
  final int quantity;
  final String? url;

  CartModel(
      {required this.id,
      required this.prodName,
      required this.price,
      this.quantity = 1,
      this.url});

  CartModel copyWith({
    int? id,
    String? prodName,
    double? price,
    int? quantity,
    String? url,
  }) {
    return CartModel(
      id: id ?? this.id,
      prodName: prodName ?? this.prodName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': id,
      'productName': prodName,
      'soldPrice': price,
      'quantity': quantity,
      "imageUrl": url
    };
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,price,prodName,quantity,url];
}
