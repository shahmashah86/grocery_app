
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';

abstract class CartRespository {

Future<void> addcartItem(CartModel products);
Future<void> deletecartItem(int index);
 Future<void> editcartItem(int index,CartModel products);
Future<List<CartModel>>? getAllcartItems();
Future<void> clearCart();
}