part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel>? categoryList;
  final String? message;
  final bool isLoading;
  final bool isError;
  final String? errorMsg;
  final List<ProductsModel>? produnderCategory;

  const CategoryLoaded({
    this.categoryList,
    this.message,
    this.isLoading = false,
    this.isError = false,
    this.errorMsg,
    this.produnderCategory,
  });

  @override
  List<Object?> get props =>
      [categoryList, message, isLoading, isError, errorMsg, produnderCategory];

  CategoryLoaded copyWith(
      {List<CategoryModel>? categoryList,
      String? message,
      bool? isLoading,
      bool? isError,
      String? errorMsg,
      List<ProductsModel>? produnderCategory}) {
    return CategoryLoaded(
      categoryList: categoryList ?? this.categoryList,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      isError: isError ?? this.isError,
      produnderCategory: produnderCategory ?? this.produnderCategory,
    );
  }
}

final class CategoryError extends CategoryState {
  final String msg;

  const CategoryError(this.msg);
  @override
  List<Object> get props => [msg];
}
