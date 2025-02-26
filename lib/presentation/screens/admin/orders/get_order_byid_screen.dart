import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';

import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';

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
            log(state.isLoading.toString(),name: 'loading state of order by id of user');
            if (state.isLoading==true) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.isLoading==false&& state.ordersbyId.isNotEmpty) {
              final OrdersModel order = state.ordersbyId.first;
              log(order.toString(), name: 'inside getorderby id');
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                order.dateTime,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                       
                          Divider(thickness: .5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Items",
                                  style: TextStyle(color: Colors.black54)),
                              Spacer(),
                              Text(
                                order.totalItems.toString() ,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: .5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Amount",
                                  style: TextStyle(color: Colors.black54)),
                              Spacer(),
                              Text(
                                order?.totalAmount.toString() ?? '',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                                   
                          Divider(thickness: .7),
                         ...List.generate( order!.product!.length, (index){
                          return  Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Product",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                      Spacer(),
                                      Text(
                                        order?.product?[index].products!
                                                .productName ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("quantity",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                      Spacer(),
                                      Text(
                                        order?.product?[index].quantity
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Price",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                      Spacer(),
                                      Text(
                                        order?.product?[index].soldPrice
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: .5,
                                  ),
                                ],
                              );
                                    
                         })
                         
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
             if(state.iserror ){
              return Text(state.errormessage);
            }
           
           
          }
         if(state is OrdersError){
              return Text(state.errormessage);
            }
          return Text('Please wait or try again');
        },
      ),
    );
  }
}
