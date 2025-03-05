import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';

import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/domain/products/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRegRepository;
  ProductBloc(this.productRegRepository) : super(ProductInitial()) {
    on<ProductRegistration>(_productegistration);
    on<ProductList>(_productList);
    on<ProductUpdation>(_productUpdation);
    on<ProductDeletion>(_productdelete);
    on<ProductimageUpload>(_uploadImage);
    on<ProductstockGet>(_getInventory);
    on<Productsearch>(_getproductbysearch);
    on<Productget>(_getproduct);
  }

//list all products
  _productList(ProductList event, Emitter<ProductState> emit) async {
    final currentState = state;

    if (currentState is ProductLoaded) {
      try {
        log('message');
        emit(currentState.copyWith(
          isLoading: true,
          isError: false,
          frombottomnav: true,
          productList: currentState.productList,
          stockList: currentState.stockList,
          searchList: currentState.searchList,
          errormsg: '',
        ));

        final response = await productRegRepository.listAllproducts();
        emit(currentState.copyWith(
            isError: false,
            isLoading: false,
            message: '',
            productList: response,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: true,
            mode: ProdCreateEditScreen.list));
      } catch (e) {
        log(currentState.frombottomnav.toString(),
            name: 'current stat eof bottomnav');
        emit(currentState.copyWith(
            isLoading: false,
            isError: true,
            errormsg: e.toString(),
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            frombottomnav: true,
            mode: ProdCreateEditScreen.list));
      }
    } else {
      try {
        emit(ProductLoading());

        final response = await productRegRepository.listAllproducts();
        emit(ProductLoaded(
            productList: response,
            isLoading: false,
            isError: false,
            errormsg: '',
            frombottomnav: true,
            mode: ProdCreateEditScreen.list));
      } catch (e) {
        log(e.toString(), name: 'error');
        emit(ProductError(msg: e.toString()));
      }
    }
  }

//product creation
  _productegistration(
      ProductRegistration event, Emitter<ProductState> emit) async {
    final currentstate = state;

    if (currentstate is ProductLoaded) {
      try {
        emit(currentstate.copyWith(
            isLoading: true,
            message: '',
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            frombottomnav: currentstate.frombottomnav,
            errormsg: '',
            mode: currentstate.mode));

        final response = await productRegRepository.productRegistration(
            event.products, event.imageFile);

        emit(currentstate.copyWith(
            isLoading: false,
            message: response,
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            frombottomnav: currentstate.frombottomnav,
            errormsg: '',
            mode: ProdCreateEditScreen.add));
      } catch (e) {
        emit(currentstate.copyWith(
            isLoading: false,
            message: '',
            isError: true,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            frombottomnav: currentstate.frombottomnav,
            errormsg: e.toString(),
            mode: ProdCreateEditScreen.add));
      }
    } else {
      try {
        emit(ProductLoading());

        final response = await productRegRepository.productRegistration(
            event.products, event.imageFile);
        emit(ProductLoaded(
            isLoading: false,
            isError: false,
            message: response,
            errormsg: '',
            mode: ProdCreateEditScreen.add));
      } catch (e) {
        log(e.toString(), name: 'error from server to bloc');
        emit(ProductError(msg: e.toString()));
      }
    }
  }

//update a product
  _productUpdation(ProductUpdation event, Emitter<ProductState> emit) async {
    final currentState = state;
    if (currentState is ProductLoaded) {
      try {
        log('update');
        emit(currentState.copyWith(
            isLoading: true,
            message: '',
            isError: false,
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: currentState.frombottomnav,
            mode: currentState.mode));

        final response = await productRegRepository.productUpdation(
            event.productsToUpdate, event.idToUpdate, event.imageFile);
        emit(currentState.copyWith(
            isError: false,
            isLoading: false,
            message: response,
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: currentState.frombottomnav,
            mode: ProdCreateEditScreen.edit));
      } catch (e) {
        log(currentState.frombottomnav.toString(), name: 'nnn');
        emit(currentState.copyWith(
            isLoading: false,
            message: '',
            isError: true,
            errormsg: e.toString(),
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            frombottomnav: currentState.frombottomnav,
            mode: ProdCreateEditScreen.edit));
      }
    }
  }

//delete a product
  _productdelete(ProductDeletion event, Emitter<ProductState> emit) async {
    final currentState = state;
    if (currentState is ProductLoaded) {
      try {
        log('update');
        emit(currentState.copyWith(
            isLoading: true,
            message: '',
            isError: false,
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: currentState.frombottomnav));

        final response =
            await productRegRepository.productDeletion(event.idTodelete);
        emit(currentState.copyWith(
            isError: false,
            isLoading: false,
            message: response.toString(),
            productList:
                List.from(currentState.productList as List<ProductRegModel>)
                  ..removeWhere(
                      (element) => element.products.id == event.idTodelete),
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: currentState.frombottomnav));
      } catch (e) {
        log(currentState.frombottomnav.toString(), name: 'nnn');
        emit(currentState.copyWith(
            isLoading: false,
            message: '',
            isError: true,
            errormsg: e.toString(),
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            frombottomnav: currentState.frombottomnav));
      }
    }
  }
 
 //upload product image
  _uploadImage(ProductimageUpload event, Emitter<ProductState> emit) async {
    final currentstate = state;
    if (currentstate is ProductLoaded) {
      try {
        emit(currentstate.copyWith(
            isLoading: true,
            message: '',
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: currentstate.frombottomnav,
            mode: currentstate.mode));
        final response = await productRegRepository.uploadImage(
            id: event.idofImage,
            productName: event.productName,
            imageFile: event.imageFile);

        emit(currentstate.copyWith(
            isLoading: false,
            message: response,
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: currentstate.frombottomnav,
            mode: currentstate.mode));
      } catch (e) {
        emit(currentstate.copyWith(
            isLoading: false,
            message: '',
            isError: true,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: e.toString(),
            frombottomnav: currentstate.frombottomnav,
            mode: currentstate.mode));
      }
    }
  }


//get product inventory
  _getInventory(ProductstockGet event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      if (currentstate is ProductLoaded) {
        try {
          log('current state is product loaded');
          emit(currentstate.copyWith(
              isLoading: true,
              message: '',
              isError: false,
              productList: currentstate.productList,
              stockList: currentstate.stockList,
              searchList: currentstate.searchList,
              errormsg: '',
              frombottomnav: currentstate.frombottomnav,
              mode: currentstate.mode));
          final response = await productRegRepository.getInventoryList();

          emit(currentstate.copyWith(
              isLoading: false,
              message: '',
              isError: false,
              productList: currentstate.productList,
              stockList: response,
              searchList: currentstate.searchList,
              errormsg: '',
              frombottomnav: currentstate.frombottomnav,
              mode: currentstate.mode));
        } catch (e) {
          emit(currentstate.copyWith(
              isLoading: false,
              message: '',
              isError: true,
              productList: currentstate.productList,
              stockList: currentstate.stockList,
              searchList: currentstate.searchList,
              errormsg: e.toString(),
              frombottomnav: currentstate.frombottomnav,
              mode: currentstate.mode));
        }
      } else {
        emit(ProductLoading());
        final response = await productRegRepository.getInventoryList();
        log('product loading', name: 'bloc');
        emit(ProductLoaded(stockList: response, isLoading: false));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  //get product by search

  _getproductbysearch(Productsearch event, Emitter<ProductState> emit) async {
    final currentstate = state;

    if (currentstate is ProductLoaded) {
      try {
        log('current state is product loaded', name: 'from search bloc');
        emit(currentstate.copyWith(
            isLoading: true,
            message: '',
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: false));

        final response =
            await productRegRepository.getproductbysearch(event.productName);
        log(response.toString(), name: 'response');

        emit(currentstate.copyWith(
          isLoading: false,
          message: '',
          isError: false,
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: response,
          errormsg: '',
          frombottomnav: false,
        ));

        log('current state is product loaded', name: 'from search bloc');
      } catch (e) {
        log(e.toString(), name: 'error from bloc');
        emit(currentstate.copyWith(
          isLoading: false,
          isError: true,
          message: '',
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: currentstate.searchList,
          errormsg: e.toString(),
          frombottomnav: currentstate.frombottomnav,
        ));
      }
    } else {
      try {
        emit(ProductLoading());
        final response =
            await productRegRepository.getproductbysearch(event.productName);
        log('product loading', name: 'bloc');
        emit(
          ProductLoaded(
              searchList: response, isLoading: false, frombottomnav: false),
        );
      } catch (e) {
        emit(ProductError(msg: e.toString()));
      }
    }
  }

//get product by id
  _getproduct(Productget event, Emitter<ProductState> emit) async {
    final currentstate = state;

    if (currentstate is ProductLoaded) {
      log('get product');
      try {
        emit(currentstate.copyWith(
            message: '',
            isLoading: true,
            isError: false,
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: currentstate.frombottomnav));
        final response = await productRegRepository.getProduct(event.productId);
        log(response.toString(), name: 'response og product get event');

        emit(currentstate.copyWith(
          message: '',
          isLoading: false,
          isError: false,
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: currentstate.searchList,
          product: [response],
          errormsg: '',
          frombottomnav: currentstate.frombottomnav,
        ));
      } catch (e) {
        log(e.toString(), name: 'error from bloc');
        emit(currentstate.copyWith(
          message: '',
          isLoading: false,
          isError: true,
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: currentstate.searchList,
          errormsg: e.toString(),
          frombottomnav: currentstate.frombottomnav,
        ));
      }
    } else {
      try {
        emit(ProductLoading());
        final response = await productRegRepository.getProduct(event.productId);
        log('product loading', name: 'from bloc');
        emit(
          ProductLoaded(
            product: [response],
            isLoading: false,
          ),
        );
      } catch (e) {
        emit(ProductError(msg: e.toString()));
      }
    }
  }
}
