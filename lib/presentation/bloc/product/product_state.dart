part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductLoaded extends ProductState {
final String message;
final int? productId;
final List<ProductRegModel>? productList;
final List<ProductsModel>? stockList;
 final bool isLoading;
 final bool isError;

 const ProductLoaded({this.productId,this.productList, this.message='',this.isLoading=false,this.isError=false,this.stockList});

  @override
  List<Object?> get props => [message, productList, isLoading, isError,stockList];

ProductLoaded copyWith(
      {String? message, bool? isLoading,bool? isError,List<ProductRegModel>? productList,List<ProductsModel>? stockList,int? productId}) {
    return ProductLoaded(
      stockList: stockList??this.stockList,
      productId:productId??this.productId,
      productList: productList??this.productList,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading,
        isError: isError??this.isError);
  }
  
}






final class ProductError extends ProductState {
  final String? msg;

  ProductError({this.msg});
  
}
