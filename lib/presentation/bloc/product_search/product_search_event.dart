part of 'product_search_bloc.dart';

sealed class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();

  @override
  List<Object> get props => [];
}

//Product List
final class ProductList extends ProductSearchEvent {
  final String productName;
  final bool frombottomnav;
  const ProductList({required this.productName, required this.frombottomnav});
  @override
  List<Object> get props => [productName, frombottomnav];
}

//Product search
final class ProductSearch extends ProductSearchEvent {
  final String productName;
  final bool frombottomnav;
  const ProductSearch({required this.productName, required this.frombottomnav});
  @override
  List<Object> get props => [productName, frombottomnav];
}
