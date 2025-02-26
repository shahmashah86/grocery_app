
import 'package:grocery_app/data/products/dtos/products_dto.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';


class ProductDto {
  final ProductsDto product;
  final List<int> categories;

  const ProductDto({required this.product, required this.categories});

 

  ProductRegModel toModel() {
    return ProductRegModel(products: product.toModel(), categories: categories);
  }


  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      product: ProductsDto.fromJson(map['product'] as Map<String, dynamic>),
      categories:
          (map['categories'] as List<dynamic>).map((e) => e as int).toList(),
    );
  }
}
