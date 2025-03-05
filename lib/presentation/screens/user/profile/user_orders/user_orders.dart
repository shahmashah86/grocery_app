import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/user/profile/user_orders/user_order_cancel.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
        title: Text("Order History"),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            log('loading');
            return Center(
              child: CircleAvatar(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is Orderssuccess) {
            if (state.isLoading == true) {
              return Center(
                child: CircleAvatar(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state.usersorderList.isEmpty) {
              return Center(
                child: Text("no orders placed yet"),
              );
            }
            if (state.usersorderList.isNotEmpty) {
              log(state.usersorderList.toString(), name: 'usersorderlist');
              return ListView.builder(
                itemBuilder: (context, index) {
                  final orderlistofUser = state.usersorderList;
                  DateTime parsedDate =
                      DateTime.parse(orderlistofUser[index].dateTime);
                  String formattedDate =
                      DateFormat("dd MMM yyyy").format(parsedDate);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Order Id ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(orderlistofUser[index].id.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        context.read<OrdersBloc>().add(
                                            OrderbyId(
                                                orderId: orderlistofUser[index]
                                                    .id!));
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UserOrderCancel(
                                            orderId: orderlistofUser[index].id!,
                                          );
                                        }));
                                      },
                                      icon: Icon(Icons.chevron_right))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(formattedDate),
                                  //  Text('4:58pm')
                                ],
                              ),
                              Divider(),
                              Row(
                                spacing: 8,
                                children: [
                                  Text(
                                      '${orderlistofUser[index].totalItems.toString()}Items'),
                                  Text(
                                    '●',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 18),
                                  ),
                                  Text(
                                      '₹${orderlistofUser[index].totalAmount}'),
                                  Spacer(),
                                  Text(
                                    orderlistofUser[index].acknowledged == true
                                        ? "Acknowledged"
                                        : 'Acknowledge',
                                    style: TextStyle(
                                        color: orderlistofUser[index]
                                                    .acknowledged ==
                                                true
                                            ? Colors.green.shade700
                                            : Colors.indigo),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                },
                itemCount: state.usersorderList.length,
              );
            }
            if (state.iserror) {
              return Center(
                child: Text(state.errormessage),
              );
            }
            if (state is OrdersError) {
              return Center(
                child: Text(state.errormessage),
              );
            }
          }
          return Center(child: Text('loading'));
        },
      ),
    );
  }
}
