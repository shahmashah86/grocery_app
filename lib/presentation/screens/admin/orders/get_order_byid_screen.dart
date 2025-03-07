import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';

import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:intl/intl.dart';

class GetOrderByidScreen extends StatefulWidget {
  final int orderId;
  const GetOrderByidScreen({super.key, required this.orderId});

  @override
  State<GetOrderByidScreen> createState() => _GetOrderByidScreenState();
}

class _GetOrderByidScreenState extends State<GetOrderByidScreen> {
  @override
  void initState() {
    context.read<OrdersBloc>().add(OrderbyId(orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is Orderssuccess) {
            log(state.isLoading.toString(),
                name: 'loading state of order by id of user');
            if (state.isLoading == true) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.isLoading == false && state.ordersbyId.isNotEmpty) {
              final OrdersModel order = state.ordersbyId.first;
              DateTime parsedDate = DateTime.parse(order.dateTime);
              String formattedDate =
                  DateFormat("dd-MMM-yyyy").format(parsedDate);
              log(order.toString(), name: 'inside getorderby id');
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Text(
                            '📅 $formattedDate',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      // Divider(thickness: .5),
                      Text(
                        'Items:',
                        style: TextStyle(fontSize: 19),
                      ),
                      ...List.generate(order.product!.length, (index) {
                        return Container(
                          decoration:
                              BoxDecoration
                              (color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(10)
                              ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Row(
                                        
                                        children: [
                                        
                                          Text(
                                            order?.product?[index].products!
                                                    .productName ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 19,
                                            ),
                                          ),
                                        ],
                                      ),
                                    
                                      Row(
                                                         
                                        children: [
                                       
                                       
                                          Text(
                                            '₹ ${order?.product?[index].soldPrice .toString()}' ,
                                                   
                                               
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                   Row(
                                     children: [   Text('Qty '),
                                       CircleAvatar(backgroundColor: Colors.amber.shade50,
                                        child: Center(child: Text(order.product?[index].quantity.toString()??''),),),
                                  ],
                                   )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Amount",
                              style: TextStyle(color: Colors.black54)),
                          Spacer(),
                          Text(
                           '₹${order?.totalAmount.toString() ?? ''}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state.iserror) {
              return Text(state.errormessage);
            }
          }
          if (state is OrdersError) {
            return Text(state.errormessage);
          }
          return Text('Please wait or try again');
        },
      ),
    );
  }
}
