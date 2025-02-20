// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartItemAdd extends CartEvent {
  final CartModel cartItems;
  const CartItemAdd({
    required this.cartItems,
  });
  @override
  List<Object> get props => [cartItems];
}

class CartitemsGet extends CartEvent {}

class CartItemDelete extends CartEvent {
  final int indextoDelete;
  const CartItemDelete({
    required this.indextoDelete,
  });
  
  @override
  List<Object> get props => [indextoDelete];
}

class CartItemToupdate extends CartEvent {
  final CartModel itemtoUpdate;
  final int indextoUpdate;
  const CartItemToupdate(
      {required this.itemtoUpdate, required this.indextoUpdate});
      
  @override
  List<Object> get props => [indextoUpdate,itemtoUpdate];
}
class CartItemclear extends CartEvent{
  
  
}