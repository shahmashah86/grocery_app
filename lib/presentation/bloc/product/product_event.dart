part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
class ProductRegistration extends ProductEvent{
  final ProductRegModel products;
    final File? imageFile;

const  ProductRegistration({required this.products,this.imageFile});

  @override
  List<Object> get props => [products];
}
final class ProductList extends ProductEvent{

}
final class productUpdation extends ProductEvent{
   final ProductRegModel productsToUpdate;
   final int idToUpdate;

 const productUpdation({required this.idToUpdate, required this.productsToUpdate});
  
}

final class productDeletion extends ProductEvent{

  final int idTodelete;
  final int indexinList;

const  productDeletion({required this.indexinList, required this.idTodelete});
}

final class ProductimageUpload extends ProductEvent{

  final int idofImage;
  final String productName;
  final File? imageFile;

const  ProductimageUpload({required this.productName, required this.idofImage,required this.imageFile});
}

final class ProductstockGet extends ProductEvent{


const  ProductstockGet();
}

final class Productsearch extends ProductEvent{

 
  final String productName;
 

const  Productsearch({required this.productName,});
}

