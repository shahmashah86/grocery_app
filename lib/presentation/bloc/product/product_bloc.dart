import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/admin/product_reg/repository/product_reg_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRegRepository productRegRepository;
  ProductBloc(this.productRegRepository) : super(ProductInitial()) {
    on<ProductRegistration>(_productegistration);
    on<ProductList>(_productList);
    on<productUpdation>(_productUpdation);
    on<productDeletion>(_productdelete);
    on<ProductimageUpload>(_uploadImage);
    on<ProductstockGet>(_getInventory);
  }

  _productList(ProductList event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductInitial) {
        emit(ProductLoading());
      }

      final response = await productRegRepository.listAllproducts();

      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(currentState.copyWith(productList: response));
      } else {
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
      final response =
          await productRegRepository.productRegistration(event.products,event.imageFile);
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
          isLoading: true,
            
        ));

        emit(currentstate.copyWith(message: response, isLoading: false));
      } else {
        emit(ProductLoaded(message: response));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }

  _productUpdation(productUpdation event, Emitter<ProductState> emit) async {
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

  _productdelete(productDeletion event, Emitter<ProductState> emit) async {
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

    _uploadImage(
      ProductimageUpload event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      final response =
          await productRegRepository.uploadImage(id: event.idofImage,productName: event.productName,imageFile: event.imageFile);
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
          isLoading: true,
        ));

        emit(currentstate.copyWith(message: response, isLoading: false));
      } else {
        emit(ProductLoaded(message: response['message'],productId: response['productId']));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }
  _getInventory(
      ProductstockGet event, Emitter<ProductState> emit) async {
    final currentstate = state;

    try {
      final response =
          await productRegRepository.getInventoryList();
      if (currentstate is ProductLoaded) {
        emit(currentstate.copyWith(
          isLoading: true,
        ));

        emit(currentstate.copyWith(stockList: response, isLoading: false));
      } else {
        emit(ProductLoaded(stockList: response));
      }
    } catch (e) {
      emit(ProductError(msg: e.toString()));
    }
  }
  



  
}
