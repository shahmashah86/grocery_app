import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/admin/dashboard/common/model/order_model.dart';
import 'package:grocery_app/presentation/bloc/orders/orders_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/acknowledge.dart';
import 'package:grocery_app/presentation/screens/admin/orders/get_order_byid_screen.dart';

class Content extends StatelessWidget {
  const Content({super.key, this.order, this.fromallordersScreen = false});
  final List<OrdersModel>? order;
  // final List<OrdersModel>? ordersList;
  final bool fromallordersScreen;

  @override
  Widget build(BuildContext context) {
       List<int> acknowldegedId=[];
    return ListView.builder(
      itemCount: order!.length,
      itemBuilder: (context, index) {
        if(order![index].acknowledged==true){
          acknowldegedId.add(index);
        
        }
          log(acknowldegedId.toString());
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
          child: InkWell(
            onTap: () {
           
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GetOrderByidScreen(orderId: order![index].id!);
              }));
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 9),
                height: fromallordersScreen
                    ? MediaQuery.sizeOf(context).height * 0.3
                    : MediaQuery.sizeOf(context).height * 0.25,
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
                          fromallordersScreen
                              ? order![index].id.toString()
                              : order![index].userId.toString(),
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fromallordersScreen ? "User Id" : "Order Id",
                          style: TextStyle(color: Colors.black54),
                        ),
                        Spacer(),
                        Text(
                          fromallordersScreen
                              ? order![index].userId.toString()
                              : order![index].id.toString(),
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
                          order![index].totalItems.toString(),
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
                          order![index].totalAmount.toString(),
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
                          order![index].dateTime,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<OrdersBloc, OrdersState>(
                     
                      builder: (context, state) {

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
                  return    Row(
                          children: [
                            Spacer(),
                            TextButton(focusNode: FocusNode(),
                                style: ButtonStyle(),
                                onPressed: () {
                                  context.read<OrdersBloc>().add(
                                      Orderacknowledge(
                                          orderId: order![index].id));
                                  
                                },
                                child:Text(order![index].acknowledged==true?"Acknowledged":'Acknowledge',style: TextStyle(
                      color:  order![index].acknowledged==true?Colors.green:Colors.red
                                ),))
                          ],
                        );
                      
                      
                      }
                    )
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
