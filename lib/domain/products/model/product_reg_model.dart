import 'package:equatable/equatable.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';


class ProductRegModel extends Equatable {

  final ProductsModel products;
  final List<int> categories;

  const ProductRegModel({
    required this.products,
    required this.categories,
  });
  
  @override
   List<Object?> get props => [products,categories];

Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': products.toMap(),
      'categories': categories,
    };
  }
}
