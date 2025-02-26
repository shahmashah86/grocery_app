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
  }

  _productList(ProductList event, Emitter<ProductState> emit) async {
        final currentState = state;
    try {
      // if (state is ProductInitial) {
      //   emit(ProductLoading());
      // }

   

      if (currentState is ProductLoaded) {
        try{
            emit(currentState.copyWith(isLoading: true));
    
           final response = await productRegRepository.listAllproducts();
        emit(currentState.copyWith(productList: response,isLoading: false));

        }
        catch(e){
          emit(currentState.copyWith(isError: true));
        }
      
      } else {
        emit(ProductLoading());
        
           final response = await productRegRepository.listAllproducts();
        emit(ProductLoaded(productList: response, isLoading: false));
      }
    } catch (e) {
      log(e.toString(), name: 'error');
      emit(ProductError(msg: e.toString()));
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
        ));

        emit(currentstate.copyWith(message: response, isLoading: false));
      } else {
        emit(ProductLoaded(message: response));
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
        try{
          final response = await productRegRepository.getInventoryList();
        log('current state is product loaded');
        emit(currentstate.copyWith(
          isLoading: true,
        ));

        emit(currentstate.copyWith(stockList: response, isLoading: false));
      } 
      catch(e){
        emit(currentstate.copyWith(isError: true));
      }
      }
      else {
       
        emit(ProductLoading());
           final response = await productRegRepository.getInventoryList();
        log('product loading', name: 'bloc');
        emit(ProductLoaded(stockList: response,isLoading: false));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  _getproductbysearch(Productsearch event, Emitter<ProductState> emit) async {
    try {
      final currentstate = state;

      if (currentstate is ProductLoaded) {
        log('current state is product loaded');
        emit(currentstate.copyWith(
          isLoading: true,
        ));
        final response =
            await productRegRepository.getproductbysearch(event.productName);

        emit(currentstate.copyWith(searchList: response, isLoading: false));
      }
      // else {
      emit(ProductLoading());
      final response =
          await productRegRepository.getproductbysearch(event.productName);
      log('product loading', name: 'bloc');
      emit(ProductLoaded(searchList: response, isLoading: false));
      // }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }


  }
}
