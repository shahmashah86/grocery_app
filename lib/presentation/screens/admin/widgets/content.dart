import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/orders/model/order_model.dart';

import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';

import 'package:grocery_app/presentation/screens/admin/orders/get_order_byid_screen.dart';
import 'package:intl/intl.dart';

class Content extends StatefulWidget {
  const Content(
      {super.key, required this.order, this.fromallordersScreen = false});
  final List<OrdersModel> order;

  final bool fromallordersScreen;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {


    late ValueNotifier<List<bool>> isAcknowledged;

  @override
  void initState() {
    super.initState();
    widget.fromallordersScreen==true?
    isAcknowledged = ValueNotifier(widget.order.map((o) => o.acknowledged!).toList()):null;
  }

  @override
  Widget build(BuildContext context) {
   


    //  List<int> acknowldegedId=[];
    return ListView.builder(
      itemCount: widget.order.length,
      itemBuilder: (context, index) {
             DateTime parsedDate = DateTime.parse(widget.order[index].dateTime);
                String formattedDate = DateFormat("dd-MM-yy").format(parsedDate);
        // log(acknowldegedId.toString());
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
          child: InkWell(
            onTap: () {
              if (widget.fromallordersScreen == true) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  log(widget.order[index].id.toString());
                  return GetOrderByidScreen(orderId: widget.order[index].id!);
                }));
              }
              return;
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 9),
                // height: MediaQuery.sizeOf(context).height * 0.345,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 247, 233),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.fromallordersScreen
                              ? widget.order[index].id.toString()
                              : widget.order[index].userId.toString(),
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.fromallordersScreen ? "User Id" : "Order Id",
                          style: TextStyle(color: Colors.black54),
                        ),
                        Spacer(),
                        Text(
                          widget.fromallordersScreen
                              ? widget.order[index].userId.toString()
                              : widget.order[index].id.toString(),
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
                        Text("Total Items",
                            style: TextStyle(color: Colors.black54)),
                        Spacer(),
                        Text(
                          widget.order[index].totalItems.toString(),
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
                          widget.order[index].totalAmount.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: .5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date", style: TextStyle(color: Colors.black54)),
                        Spacer(),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                   
                      //    if(state is Orderssuccess && state.message!=null){
                      //     log('sucess');
                      //   return Row(
                      //     children: [
                      //       Spacer(),
                      //       TextButton(
                      //           style: ButtonStyle(),
                      //           onPressed: () {
                      //             context.read<OrdersBloc>().add(
                      //                 Orderacknowledge(
                      //                     orderId: order![index].id));
                      //           },
                      //           child: Text("Acknowldeged"))
                      //     ],
                      //   );
                      // }
                      widget.fromallordersScreen == true?
                        
                        //  BlocBuilder<OrdersBloc, OrdersState>(
                        //   builder: (context, state) {
                        //     if(state is Orderssuccess && state.orderScreenType==OrderScreenType.allOrders ){
                        //       if(state.message!=''){
                        //          return ValueListenableBuilder(
                        //       valueListenable: isAcknowledged,
                        //       builder: (context, value, child) => Row(
                        //         children: [
                        //           Spacer(),
                        //           TextButton(
                        //               style: ButtonStyle(),
                        //               onPressed: () {
                        //                 if (!value[index]) {
                        //                   List<bool> updatedList =
                        //                       List.from(value);
                        //                   updatedList[index] = true;
                        //                   isAcknowledged.value = updatedList;
                        //                   context.read<OrdersBloc>().add(
                        //                       Orderacknowledge(
                        //                           orderId: order[index].id!));
                        //                 }
                        //               },
                        //               child: Text(
                        //                 value[index]
                        //                     ? "Acknowledged"
                        //                     : 'Acknowledge',
                        //                 style: TextStyle(
                        //                     color: value[index] == true
                        //                         ? Colors.green
                        //                         : Colors.red),
                        //               ))
                        //         ],
                        //       ),
                        //     );

                        //       }

                        //     }

                            ValueListenableBuilder(
                              valueListenable: isAcknowledged,
                              builder: (context, value, child) => Row(
                                children: [
                                  Spacer(),
                                  TextButton(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        if (!value[index]) {
                                          List<bool> updatedList =
                                              List.from(value);
                                          updatedList[index] = true;
                                          isAcknowledged.value = updatedList;
                                          context.read<OrdersBloc>().add(
                                              Orderacknowledge(
                                                  orderId: widget.order[index].id!));
                                        }
                                      },
                                      child: Text(
                                        value[index]
                                            ? "Acknowledged"
                                            : 'Acknowledge',
                                        style: TextStyle(
                                            color: value[index] == true
                                                ? Colors.green
                                                : Colors.red),
                                      ))
                                ],
                              ),
                            ):
                        //   },
                        // ):
                
                        SizedBox.shrink()
                      
                    
                    
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
