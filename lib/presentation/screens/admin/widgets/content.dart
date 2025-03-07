import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    widget.fromallordersScreen == true
        ? isAcknowledged =
            ValueNotifier(widget.order.map((o) => o.acknowledged!).toList())
        : null;
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                // height: MediaQuery.sizeOf(context).height * 0.345,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 247, 233),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * .3,
                          height: MediaQuery.sizeOf(context).height * .04,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text(
                              widget.fromallordersScreen
                                  ? 'Order Id:${widget.order[index].id.toString()}'
                                  : 'User Id:${widget.order[index].userId.toString()}',
                              style: TextStyle(
                                  fontSize: 19, color: Colors.indigo.shade500),
                            ),
                          ),
                        ),
                        Text('📅  $formattedDate',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    Divider(thickness: .5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Item count: ${widget.order[index].totalItems.toString()}",
                            style: TextStyle(color: Colors.black54)),
                        Text(
                          "₹${widget.order[index].totalAmount.toString()}",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                   
                    widget.fromallordersScreen == true
                        ? 
                        Column(
                          children: [ Divider(
                      thickness: .5,
                    ),
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
                                                    orderId:
                                                        widget.order[index].id!));
                                          }
                                        },
                                        child: Text(
                                          value[index] ? "Approved ✔️" : 'Approve ',
                                          style: TextStyle(
                                              color: value[index] == true
                                                  ? Colors.green
                                                  : Colors.red),
                                        ))
                                  ],
                                ),
                              ),
                          ],
                        )
                        : SizedBox.shrink()
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
