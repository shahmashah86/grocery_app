import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/repository/product_repository.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final ProductRepository productRepository;

  ProductSearchBloc(this.productRepository)
      : super(const ProductSearchState()) {
    on<ProductList>(_productList);
    on<ProductSearch>(_getproductbysearch);
  }
  _productList(ProductList event, Emitter<ProductSearchState> emit) async {
    try {
      emit(ProductSearchLoading());
      final response = await productRepository.listAllproducts();
      emit(ProductSearchLoaded(
        productList: response,
      ));
      if (event.productName.isNotEmpty) {
        log(event.productName,name:"name in bloc");
        log(event.frombottomnav.toString(),name:"isFromBottomNav");
        add(ProductSearch(
            productName: event.productName,
            frombottomnav: event.frombottomnav));
      }
   
    } catch (e) {
      log(e.toString(), name: 'error');
      emit(ProductSearchError(msg: e.toString()));
    }
  }

  _getproductbysearch(
      ProductSearch event, Emitter<ProductSearchState> emit) async {
    final currentstate = state;
    log(currentstate.toString(),name: "current state");
    if (currentstate is ProductSearchLoaded) {
      emit(currentstate.copyWith(isLoading: true));

      List<ProductRegModel> filterProducts = currentstate.productList
          .where((product) => product.products.productName!
              .toLowerCase()
              .contains(event.productName.toLowerCase()))
          .toList();

      // final searchList =
      //     await productRepository.getproductbysearch(event.productName);
      emit(currentstate.copyWith(
          searchList: filterProducts, frombottomnav: event.frombottomnav));
    }
  }
}
