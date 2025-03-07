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
  final List<ProductRegModel>? searchList;
  final List<ProductsModel> product;

  final bool frombottomnav;
  final String? errormsg;
  final ProdCreateEditScreen mode;
  

  const ProductLoaded(
      {this.isLoading = false,
      this.message = '',
      this.isError = false,
      this.productId,
      this.productList,
      this.stockList,
      this.searchList = const [],
      this.frombottomnav = false,
      this.product=const [],
      this.errormsg = '',
      this.mode=ProdCreateEditScreen.list,
      });

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
        product,
        errormsg,
        mode

      ];

  ProductLoaded copyWith({
    bool? isLoading,
    String? message,
    bool? isError,
    int? productId,
    List<ProductRegModel>? productList,
    List<ProductsModel>? stockList,
    List<ProductRegModel>? searchList,
    List<ProductsModel>? product,
    bool? frombottomnav,
    String? errormsg,
    ProdCreateEditScreen? mode
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
        errormsg: errormsg ?? this.errormsg,
        product: product??this.product,
        mode: mode??this.mode
        
        );
  }
}

final class ProductError extends ProductState {
  final String? msg;

const  ProductError({this.msg});
}
