// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery_app/data/databases/entity/cart_entity.dart';

class CartModel {

  final int id;
    final String prodName;
 
  final double price;
 
  final int quantity;

  final String url;


  CartModel({required this.id, required this.prodName, required this.price, this.quantity=1, required this.url});
  
  
  CartEntity toEntity(){
    return CartEntity(id: id,
    prodName: prodName,
    price: price,
    quantity: quantity,
    url: url
    );
  }

  CartModel fromEntity(CartEntity entity){
    return CartModel(id: id, prodName: prodName, price: price, url: url);
  }


  factory CartModel.fromEntity(CartEntity entity)
{
  return CartModel(id: entity.id, prodName: entity.prodName, price: entity.price, url:entity.url,quantity: entity.quantity);
}  
  
  

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
  }
