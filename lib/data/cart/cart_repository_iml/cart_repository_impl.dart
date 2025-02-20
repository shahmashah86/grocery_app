

import 'package:grocery_app/data/databases/entity/cart_entity.dart';
import 'package:grocery_app/data/databases/repository/cart_db_repository.dart';

import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/cart/cart_respository/cart_respository.dart';

class CartRepositoryImpl extends CartRespository{
  @override
  Future<void> addcartItem(CartModel products) async {
   CartdbRepository().addCart(products.toEntity());
   getAllcartItems();
  }

  @override
  Future<void> deletecartItem(int index) async {
  CartdbRepository().deleteCart(index);
  }

  @override
  Future<void> editcartItem(int index,CartModel products) async {
   CartdbRepository().updateCart(products.toEntity(), index);
  }
  
  @override
  Future<List<CartModel>>? getAllcartItems()  async{
   
List<CartEntity> items=CartdbRepository().getAllcartItems();
return items.map((toElement)=>CartModel.fromEntity(toElement)).toList();
  }

  @override
 Future<void> clearCart() async{ 

 await CartdbRepository().clearCart();
 }

  
}