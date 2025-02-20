part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  final List<CartModel>? cartItems;
  final bool isLoading;
  final double? subtotal;
  final double? total;
  final double? tax;

  const CartLoaded(
      {this.subtotal,
      this.total,
      this.cartItems,
      this.isLoading = false,
      this.tax});
  CartLoaded copyWith(
      {bool? isLoading,
      List<CartModel>? cartItems,
      double? subtotal,
      double? total,
      double? tax}) {
    return CartLoaded(
        cartItems: cartItems ?? this.cartItems,
        isLoading: isLoading ?? this.isLoading,
        tax: tax ?? this.tax,
        subtotal: subtotal ?? this.subtotal,
        total: total ?? this.total);
  }

  @override
  List<Object?> get props => [isLoading,cartItems,total,tax,subtotal];
}

final class CartLoading extends CartState {}
