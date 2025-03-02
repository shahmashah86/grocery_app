part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final bool isLoading;
  final String message;
  final bool isError;
  final int? productId;
  final List<ProductRegModel>? productList;
  final List<ProductsModel>? stockList;
  final List<ProductsModel>? searchList;

  final bool frombottomnav;
  final String? errormsg;

  const ProductLoaded(
      {this.isLoading = false,
      this.message = '',
      this.isError = false,
      this.productId,
      this.productList,
      this.stockList,
      this.searchList = const [],
      this.frombottomnav = false,
      this.errormsg = ''});

  @override
  List<Object?> get props => [
        isLoading,
        message,
        isError,
        productId,
        productList,
        stockList,
        searchList,
        frombottomnav,
        errormsg
      ];

  ProductLoaded copyWith({
    bool? isLoading,
    String? message,
    bool? isError,
    int? productId,
    List<ProductRegModel>? productList,
    List<ProductsModel>? stockList,
    List<ProductsModel>? searchList,
    bool? frombottomnav,
    String? errormsg,
  }) {
    return ProductLoaded(
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        productList: productList ?? this.productList,
        stockList: stockList ?? this.stockList,
        searchList: searchList ?? this.searchList,
        productId: productId ?? this.productId,
        frombottomnav: frombottomnav ?? this.frombottomnav,
        errormsg: errormsg ?? this.errormsg);
  }
}

final class ProductError extends ProductState {
  final String? msg;

const  ProductError({this.msg});
}
