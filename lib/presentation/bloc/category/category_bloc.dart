import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/domain/category/model/category_model.dart';
import 'package:grocery_app/domain/category/repository/category_reposotory.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<CategoryGet>(_getCategory);
    on<CategoryCreate>(_createCategory);
    on<CategoryUpdate>(_updateCategory);
    on<CategoryDelete>(_deleteAcategory);
    on<CategorylistbyId>(_productByCategory);
  }
  _getCategory(CategoryGet event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      final response = await categoryRepository.getAllCategories();
      log(response.toString());
      emit(CategoryLoaded(
        categoryList: response,
      ));
    } catch (e) {
      emit(CategoryError(e.toString()));
      log(e.toString(), name: 'category error from bloc');
    }
  }

  _createCategory(CategoryCreate event, Emitter<CategoryState> emit) async {
    final currentState = state;

    if (currentState is CategoryLoaded) {
      try {
        emit(currentState.copyWith(
            categoryList: currentState.categoryList,
            isLoading: true,
            message: '',
            errorMsg: '',
            produnderCategory: currentState.produnderCategory));

        final response = await categoryRepository.createCategory(
          name: event.categeoryName,
        );
        emit(currentState.copyWith(
            message: response,
            isLoading: false,
            produnderCategory: currentState.produnderCategory));
        log(response.toString());
      } catch (e) {
        log('error');
        emit(currentState.copyWith(isLoading: false, errorMsg: e.toString()));
      }
    }
  }

  _updateCategory(CategoryUpdate event, Emitter<CategoryState> emit) async {
    final currentState = state;
    if (currentState is CategoryLoaded) {
      try {
        emit(currentState.copyWith(
            message: '',
            isLoading: true,
            errorMsg: '',
            produnderCategory: currentState.produnderCategory));
        final response = await categoryRepository.updateCategory(
            id: event.id, catgeoryToUpdate: event.categoryName);
        emit(currentState.copyWith(
            categoryList: currentState.categoryList,
            message: response,
            isLoading: false,
            errorMsg: '',
            produnderCategory: currentState.produnderCategory));
        log(response.toString());
      } catch (e) {
        log('error');
        currentState.copyWith(
            categoryList: currentState.categoryList,
            errorMsg: e.toString(),
            produnderCategory: currentState.produnderCategory);
      }
    }
  }

  _deleteAcategory(CategoryDelete event, Emitter<CategoryState> emit) async {
    final currentstate = state;
    if (currentstate is CategoryLoaded) {
      try {
        emit(currentstate.copyWith(
            categoryList: currentstate.categoryList,
            message: '',
            isLoading: true,
            errorMsg: '',
            produnderCategory: currentstate.produnderCategory));
        final response = await categoryRepository.deleteCategory(id: event.id);
        log(response.toString());
        emit(currentstate.copyWith(
            message: response,
            isLoading: false,
            errorMsg: '',
            produnderCategory: currentstate.produnderCategory));
      } catch (e) {
        log('error');
        currentstate.copyWith(
            categoryList: currentstate.categoryList,
            errorMsg: e.toString(),
            produnderCategory: currentstate.produnderCategory);
      }
    }
  }

  _productByCategory(
      CategorylistbyId event, Emitter<CategoryState> emit) async {
    final currentState = state;
    if (currentState is CategoryLoaded) {
      try {
        emit(currentState.copyWith(
            categoryList: currentState.categoryList,
            isLoading: true,
            message: '',
            errorMsg: '',
            produnderCategory: currentState.produnderCategory));
        final response = await categoryRepository.listallCategories(event.id);
        emit(currentState.copyWith(
            produnderCategory: response, isLoading: false));
        log(response.toString());
      } catch (e) {
        log('error');
        currentState.copyWith(
            categoryList: currentState.categoryList,
            errorMsg: e.toString(),
            produnderCategory: currentState.produnderCategory);
      }
    }
  }
}
