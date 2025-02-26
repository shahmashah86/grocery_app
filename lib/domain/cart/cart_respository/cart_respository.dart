
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';

abstract class CartRespository {

Future<void> addcartItem(CartModel cartModel);
Future<void> deletecartItem(int index);
 Future<void> editcartItem(int index,CartModel cartModel);
Future<List<CartModel>>? getAllcartItems();
Future<void> clearCart();
}