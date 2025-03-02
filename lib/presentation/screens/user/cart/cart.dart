import 'dart:developer';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/place_order_model/place_order_model.dart';
import 'package:grocery_app/presentation/bloc/auth/auth_bloc.dart';

import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/user/order_success/order_successful.dart';
import 'package:grocery_app/presentation/screens/user/pdoduct_description/product_description.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initSta
    context.read<CartBloc>().add(CartitemsGet());
    super.initState();
  }

  Future<String?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final phone = prefs.getString('user_phone');
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          title: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.amber.shade200,
        ),
        body:
            // final List<CartEntity> cartlist = cartitemBox.values.toList();

            // log(cartlist.toString());
            BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return CircleAvatar(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartLoaded && state.isLoading == true) {
              return Center(
                  child: CircleAvatar(
                child: CircularProgressIndicator(),
              ));
            }
            if (state is CartLoaded && state.cartItems!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Image.asset(
                      'assets/images/emptycart.png',
                      height: MediaQuery.sizeOf(context).height * .25,
                    ),
                    Text(
                      "Your cart is currently empty!",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Add you favourite products… and we can change the empty cart! 😉",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CartLoaded && (state.cartItems?.isNotEmpty ?? false)) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(state.cartItems?.length ?? 0, (index) {
                      ValueNotifier<int> quantityselected =
                          ValueNotifier(state.cartItems![index].quantity);
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Card(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.17,
                            decoration: BoxDecoration(
                                // color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            child: Row(
                              spacing: 20,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 9,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ProductDescription();
                                      }));
                                      context.read<ProductBloc>().add(Productget(productId: state.cartItems![index].id));
                                    },
                                    
                                    child: Container(clipBehavior: Clip.hardEdge,
                                         decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),),
                                      child: CachedNetworkImage(
                                        height:
                                            MediaQuery.sizeOf(context).height * .15,
                                        width:
                                            MediaQuery.sizeOf(context).width * .3,
                                            imageUrl: state.cartItems?[index].url ?? '' ,
                                               fit: BoxFit.cover,
                                                errorWidget: (context, url, error) => Icon(
                                        Icons.error,
                                        size: 60,
                                        color: Colors.black45,
                                      ),
                                      placeholder: (context, url) => SpinKitPulse(
                                        color: Colors.white,
                                      ),
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(10),
                                      
                                        //   image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(
                                        //         state.cartItems?[index].url ?? ''),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                  ),
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.cartItems![index].prodName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        state.cartItems![index].price
                                            .toString(),
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Row(
                                        spacing: 2,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.amber.shade300),
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.035,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.035,
                                              child: IconButton(
                                                  padding: EdgeInsets.all(3),
                                                  onPressed: () {
                                                    if (quantityselected.value >
                                                        1) {
                                                      quantityselected.value =
                                                          quantityselected
                                                                  .value -
                                                              1;
                                                    } else {
                                                      return;
                                                    }
                                                    final cartModel = state
                                                        .cartItems![index]
                                                        .copyWith(
                                                            quantity:
                                                                quantityselected
                                                                    .value);

                                                    context
                                                        .read<CartBloc>()
                                                        .add(CartItemToupdate(
                                                            itemtoUpdate:
                                                                cartModel,
                                                            indextoUpdate:
                                                                index));
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                  ))),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.04,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.04,
                                              child: ValueListenableBuilder(
                                                valueListenable:
                                                    quantityselected,
                                                builder:
                                                    (context, value, child) =>
                                                        Center(
                                                            child: Text(
                                                  quantityselected.value
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                              )),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.amber.shade300),
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.035,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.035,
                                              child: IconButton(
                                                  padding: EdgeInsets.all(3),
                                                  onPressed: () {
                                                    quantityselected.value =
                                                        quantityselected.value +
                                                            1;
                                                    CartModel cart = CartModel(
                                                        id: state
                                                            .cartItems![index]
                                                            .id,
                                                        prodName: state
                                                            .cartItems![index]
                                                            .prodName,
                                                        price: state
                                                            .cartItems![index]
                                                            .price,
                                                        url: state
                                                            .cartItems![index]
                                                            .url,
                                                        quantity:
                                                            quantityselected
                                                                .value);
                                                    context
                                                        .read<CartBloc>()
                                                        .add(CartItemToupdate(
                                                            itemtoUpdate: cart,
                                                            indextoUpdate:
                                                                index));
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 20,
                                                  )))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    padding: EdgeInsets.only(right: 9),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                          CartItemDelete(indextoDelete: index));
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 30,
                                      color: Colors.black54,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bill Summary',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal:'),
                              Text('₹${state.subtotal!.toStringAsFixed(2)}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax (2%):'),
                              Text('₹${state.tax!.toStringAsFixed(2)}')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('Delivery Charge:'), Text('₹50')],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('₹${state.total!.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 10),
                          BlocListener<OrdersBloc, OrdersState>(
                            listener: (context, state) {
                              if (state is Orderssuccess &&
                                  state.message ==
                                      'Added to cart successfully') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Orderssuccessful();
                                }));
                                context.read<CartBloc>().add(CartItemclear());
                              }

                              if (state is Orderssuccess &&
                                  state.errormessage.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'something is wrong please try again!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              if (state is OrdersError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'something is wrong please try again!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              //  return;
                            },
                            child: ElevatedButton(
                              onPressed: () async {
                                final mobno = await loadUserData();
                                log(mobno.toString(),
                                    name:
                                        'phone number not null checking in cart screen');
                                if (mobno == null || mobno == '') {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Contact Required"),
                                          icon: Icon(
                                            Icons.warning,
                                            color: Colors.amber,
                                            size: 40,
                                          ),
                                          content: Text(
                                              'Please enter a vaild phone number in profile to proceed with your order'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.black12)),
                                            )
                                          ],
                                        );
                                      });
                                }

                                int totalItems = state.cartItems!.length;
                                double totalAmount = double.parse(
                                    state.subtotal!.toStringAsFixed(2));
                                // final orderdetails=OrdersModel(dateTime: DateTime.now().toString(), totalItems: totalItems, totalAmount: state.total!.toStringAsFixed(2),);
                                final productdetails = state.cartItems;
                                final orderitems = PlaceOrderModel(
                                    dateTime: DateTime.now().toIso8601String(),
                                    totalItems: totalItems,
                                    totalAmount: totalAmount,
                                    productdetails: productdetails!);
                                log(orderitems.toString());

                                context
                                    .read<OrdersBloc>()
                                    .add(OrderPlaced(orders: orderitems));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lime.shade400,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                minimumSize: Size(double.infinity, 40),
                              ),
                              child: BlocBuilder<OrdersBloc, OrdersState>(
                                builder: (context, state) {
                                  if(state is OrdersLoading){
                                    return Center(child: SizedBox(height: 20,width: 20,
                                      child: CircularProgressIndicator()),);
                                  }
                                  if(state is Orderssuccess && state.isLoading){
                                     return Center(child: SizedBox(height: 20,width: 20,
                                      child: CircularProgressIndicator()),);

                                  }
                                  return Text('Proceed to Checkout',
                                      style: TextStyle(fontSize: 16));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Text("loading");
          },
        ));
  }
}
