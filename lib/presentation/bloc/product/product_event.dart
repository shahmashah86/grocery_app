part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductRegistration extends ProductEvent {
  final ProductRegModel products;
  final File? imageFile;

  const ProductRegistration({required this.products, this.imageFile});

  @override
  List<Object?> get props => [products, imageFile];
}

final class ProductList extends ProductEvent {}

final class ProductUpdation extends ProductEvent {
  final ProductRegModel productsToUpdate;
  final int idToUpdate;
   final File? imageFile;

  const ProductUpdation(
      {required this.idToUpdate, required this.productsToUpdate,this.imageFile});
  @override
  List<Object> get props => [idToUpdate, productsToUpdate];
}

final class ProductDeletion extends ProductEvent {
  final int idTodelete;
  final int indexinList;

  const ProductDeletion({required this.indexinList, required this.idTodelete});
  @override
  List<Object> get props => [indexinList, idTodelete];
}

final class ProductimageUpload extends ProductEvent {
  final int idofImage;
  final String productName;
  final File imageFile;

  const ProductimageUpload(
      {required this.productName,
      required this.idofImage,
      required this.imageFile});
  @override
  List<Object> get props => [productName, idofImage, imageFile];
}

final class ProductstockGet extends ProductEvent {
  const ProductstockGet();
}

final class Productsearch extends ProductEvent {
  final String productName;

  const Productsearch({
    required this.productName,
  });
  @override
  List<Object> get props => [productName];
}

final class Productget extends ProductEvent {
  final int productId;

  const Productget({required this.productId});
}
