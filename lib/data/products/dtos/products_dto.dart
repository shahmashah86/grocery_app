

import 'package:grocery_app/domain/products/model/products_model.dart';

class ProductsDto {
  final int? id;
  final String? productName;
  final String? productDescription;
  final double? price;
  final String? image;
  final String? unit;
  final bool? isAvailable;
  final bool? isTrending;
  final double? stockQuantity;
  // final int? quantity;

  ProductsDto(
      {this.id,
      required this.productName,
      required this.productDescription,
      required this.price,
      this.image,
      required this.unit,
      required this.isAvailable,
      required this.isTrending,
      required this.stockQuantity,
      // this.quantity
      });

  factory ProductsDto.fromJson(Map<String, dynamic> json) {
    return ProductsDto(
        id: json['id'],
        productName: json['productName'],
        productDescription: json['productDescription'],
        price: double.tryParse(json['price'].toString()) ?? 0.0,
        unit: json['unit'],
        image: json['image'],
        isAvailable: json['isAvailable'],
        isTrending: json['isTrending'],
        stockQuantity:
            double.tryParse(json['stockQuantity'].toString()) ?? 0.0);
  }

  ProductsModel toModel() {
    return ProductsModel(
        id: id,
        productName: productName,
        productDescription: productDescription,
        price: price,
        image: image,
        unit: unit,
        isAvailable: isAvailable,
        isTrending: isTrending,
        stockQuantity: stockQuantity);
  }
}
