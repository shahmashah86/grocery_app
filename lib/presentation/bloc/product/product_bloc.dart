import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  _productList(ProductList event, Emitter<ProductState> emit) async {
    final currentState = state;

    if (currentState is ProductLoaded) {
      try {
        log('message');
        emit(currentState.copyWith(
            isLoading: true,
            isError: false,
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: true));

        final response = await productRegRepository.listAllproducts();
        emit(currentState.copyWith(
            isError: false,
            isLoading: false,
            productList: response,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            errormsg: '',
            frombottomnav: true));
      } catch (e) {
        log(currentState.frombottomnav.toString(),name: 'nnn');
        emit(currentState.copyWith(
            isLoading: false,
            isError: true,
            errormsg: e.toString(),
            productList: currentState.productList,
            stockList: currentState.stockList,
            searchList: currentState.searchList,
            frombottomnav: currentState.frombottomnav));
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
            frombottomnav: true));
      } catch (e) {
        log(e.toString(), name: 'error');
        emit(ProductError(msg: e.toString()));
      }
    }
  }

  _productegistration(
      ProductRegistration event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      final response = await productRegRepository.productRegistration(
          event.products, event.imageFile);
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
            isLoading: true,
          
            message: '',
            productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: currentstate.frombottomnav));

        emit(currentstate.copyWith(
         isLoading: false,
           isError: false,
         message: response,
         productList: currentstate.productList,
            stockList: currentstate.stockList,
            searchList: currentstate.searchList,
            errormsg: '',
            frombottomnav: currentstate.frombottomnav
         
         ));
      } else {
        
        emit(ProductLoaded(
         
                 isLoading: false,
            isError: false,
               message: response,
            errormsg: '',
            frombottomnav: true));
      }
    } catch (e) {
      log("error: e.toString()");
      emit(ProductError(msg: e.toString()));
    }
  }

  _productUpdation(ProductUpdation event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      final response = await productRegRepository.productUpdation(
          event.productsToUpdate, event.idToUpdate);
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
          isLoading: true,
          // message: '',
        ));

        emit(currentstate.copyWith(message: response, isLoading: false));
      } else {
        emit(ProductLoaded(message: response));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  _productdelete(ProductDeletion event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      log(event.idTodelete.toString());
      final response =
          await productRegRepository.productDeletion(event.idTodelete);
      if (currentstate is ProductLoaded) {
        log('dddddd');
        emit(currentstate.copyWith(
          isLoading: true,
          message: '',
        ));

        emit(currentstate.copyWith(
            message: response,
            isLoading: false,
            productList:
                List.from(currentstate.productList as List<ProductRegModel>)
                  ..removeWhere(
                      (element) => element.products.id == event.idTodelete)));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  _uploadImage(ProductimageUpload event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      final response = await productRegRepository.uploadImage(
          id: event.idofImage,
          productName: event.productName,
          imageFile: event.imageFile);
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
          isLoading: true,
        ));

        emit(currentstate.copyWith(message: response, isLoading: false));
      } else {
        emit(ProductLoaded(
            message: response['message'], productId: response['productId']));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  _getInventory(ProductstockGet event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      if (currentstate is ProductLoaded) {
        try {
          log('current state is product loaded');
          emit(currentstate.copyWith(
            isLoading: true,
          ));
          final response = await productRegRepository.getInventoryList();

          emit(currentstate.copyWith(stockList: response, isLoading: false));
        } catch (e) {
          emit(currentstate.copyWith(isError: true));
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

  _getproductbysearch(Productsearch event, Emitter<ProductState> emit) async {
    final currentstate = state;

    if (currentstate is ProductLoaded) {
      try {
        log('current state is product loaded', name: 'from search bloc');
        emit(currentstate.copyWith(
            message: '',
            isLoading: true,
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
          message: '',
          isLoading: false,
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
          message: '',
          isLoading: false,
          isError: true,
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: [],
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


  
  _getproduct(Productget event, Emitter<ProductState> emit) async {
    final currentstate = state;

    if (currentstate is ProductLoaded) {
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
        final response =
            await productRegRepository.getProduct(event.productId);
        log(response.toString(), name: 'response og product get event');

        emit(currentstate.copyWith(
          message: '',
          isLoading: false,
          isError: false,
          
          productList: currentstate.productList,
          stockList: currentstate.stockList,
          searchList: currentstate.searchList,
          errormsg: '',
          frombottomnav: false,
          product: [response]
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
        final response =
            await productRegRepository.getProduct(event.productId);
        // log('product loading', name: 'from bloc');
        emit(
          ProductLoaded(
              
              product: [response], isLoading: false,),
        );
      } catch (e) {
        emit(ProductError(msg: e.toString()));
      }
    }
  }
}
