part of 'product_search_bloc.dart';

class ProductSearchState extends Equatable {
  const ProductSearchState();

  @override
  List<Object> get props => [];
}

final class ProductSearchLoading extends ProductSearchState {}

final class ProductSearchLoaded extends ProductSearchState {
  final bool isLoading;
  final bool isError;
  final List<ProductRegModel> productList;
  final List<ProductRegModel> searchList;
  final bool frombottomnav;
  final String errormsg;

  const ProductSearchLoaded(
      {this.isLoading = false,
      this.isError = false,
      this.productList = const [],
      this.searchList = const [],
      this.frombottomnav = true,
      this.errormsg = ""});
  ProductSearchLoaded copyWith({
    bool? isLoading,
    bool? isError,
    List<ProductRegModel>? productList,
    List<ProductRegModel>? searchList,
    bool? frombottomnav,
    String? errormsg,
  }) {
    return ProductSearchLoaded(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      productList: productList ?? this.productList,
      searchList: searchList ?? this.searchList,
      frombottomnav: frombottomnav ?? this.frombottomnav,
      errormsg: errormsg ?? this.errormsg,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isError, productList, searchList, frombottomnav, errormsg];
}

final class ProductSearchError extends ProductSearchState {
  final String msg;

  const ProductSearchError({required this.msg});
}
