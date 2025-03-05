import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:intl/intl.dart';

class UserOrderCancel extends StatelessWidget {
  const UserOrderCancel({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (BuildContext context, state) {
          if (state is Orderssuccess && state.ordersbyId.isEmpty) {
            //dialog saying order cancelled
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Order got cancelled "),
                    title: Row(
                      children: [
                        Text('Cancel '),
                        Icon(
                          Icons.remove_shopping_cart,
                          size: 30,
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black12),
                          ),
                          child: Text("Ok"))
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          if (state is Orderssuccess) {
            if (state.isLoading) {
              return Center(
                  child: CircleAvatar(
                child: CircularProgressIndicator(),
              ));
            }

            if (state.ordersbyId.isNotEmpty) {
              final orderlistofUser = state.ordersbyId.first;
              DateTime parsedDate = DateTime.parse(orderlistofUser.dateTime);
              String formattedDate =
                  DateFormat("dd MMM yyyy").format(parsedDate);
              log(orderlistofUser.toString());

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Order $orderId',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      ),
                      Card(
                        color: Colors.grey.shade200,
                        // margin: EdgeInsets.all(8),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.23,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Orderplaced succesfully 😍",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  spacing: 7,
                                  children: [
                                    Text("Orders date: ",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        )),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 7,
                                  children: [
                                    Text("Orders total: ",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        )),
                                    Text(
                                      '₹${orderlistofUser.totalAmount}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Changed your mind! want to cancel?',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black45)),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            icon: Icon(
                                              Icons.info,
                                              size: 50,
                                              color: Colors.amber,
                                            ),
                                            contentTextStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black38),
                                            content: Text(
                                              "Are you sure you want to cancel the order?",
                                              textAlign: TextAlign.center,
                                            ),
                                            title: Text(
                                              "Cancel Order",
                                              textAlign: TextAlign.center,
                                            ),
                                            titleTextStyle: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.black12)),
                                                  child: Text("Go back")),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<OrdersBloc>()
                                                      .add(Ordercancel(
                                                          orderId: orderId));
                                                  Navigator.pop(context);
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.redAccent)),
                                                child: Text(
                                                  "Yes,cancel",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6))),
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.white)),
                                  child: Text('cancel'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(orderlistofUser.product!.length,
                          (index) {
                        return Card(
                          color: Colors.grey.shade200,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            decoration: BoxDecoration(
                                // color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            child: Row(spacing: 20, children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 9,
                                ),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    height:
                                        MediaQuery.sizeOf(context).height * .13,
                                    width:
                                        MediaQuery.sizeOf(context).width * .22,
                                    imageUrl: orderlistofUser
                                            .product?[index].products?.image ??
                                        '',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 60,
                                      color: Colors.black45,
                                    ),
                                    placeholder: (context, url) => SpinKitPulse(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    orderlistofUser
                                        .product![index].productName!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        '₹${orderlistofUser.product![index].soldPrice.toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '●',
                                        style: TextStyle(
                                            color: Colors.amber, fontSize: 20),
                                      ),
                                      Text(
                                          '${orderlistofUser.product![index].quantity.toString()}${orderlistofUser.product![index].products!.unit}'),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Do you really want to cancel this product?"),
                                                    icon: Icon(
                                                      Icons.dangerous,
                                                      size: 55,
                                                      color: Colors.deepOrange,
                                                    ),
                                                    title:
                                                        Text("Cancel product"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStatePropertyAll(
                                                                    Colors
                                                                        .black12)),
                                                        child: Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                        
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStatePropertyAll(
                                                                    Colors.amber
                                                                        .shade200)),
                                                        child: Text('Yes'),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.delete_sharp))
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              );
            }
            if (state.iserror) {
              return Center(
                child: Text(state.errormessage),
              );
            }
          }
          return Center(
            child: Text('Loading'),
          );
        },
      ),
    );
  }
}
