import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/domain/common/model/order_byid_model/order_byid_model.dart';
import 'package:grocery_app/presentation/bloc/get_order/get_orderby_id_bloc.dart';

class GetOrderByidScreen extends StatefulWidget {
  final int orderId;
  const GetOrderByidScreen({super.key, required this.orderId});

  @override
  State<GetOrderByidScreen> createState() => _GetOrderByidScreenState();
}

class _GetOrderByidScreenState extends State<GetOrderByidScreen> {
  @override
  void initState() {
    context.read<GetOrderbyIdBloc>().add(GetOrderEvent(id: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  backgroundColor: Colors.amber.shade200,),
      body: Column(
        children: [
          BlocBuilder<GetOrderbyIdBloc, GetOrderbyIdState>(
            builder: (context, state) {
              if(state is GetAnOrderbyIdLoaded){
                final OrderByidModel order=state.orderById;
                     return Card(
                       child: Container(
                         padding: EdgeInsets.only(left: 8, right: 9,top: 8),
                         height: MediaQuery.sizeOf(context).height * .8,
                         decoration: BoxDecoration(
                           color: const Color.fromARGB(255, 251, 247, 233),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         width: double.infinity,
                         child: Column(
                           children: [
                             Row(
                               children: [
                                 Text(order.order.dateTime,
                                   style: TextStyle(
                                       fontSize: 20, ),
                                 )
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   "User Id",
                                   style: TextStyle(color: Colors.black54),
                                 ),
                                 Spacer(),
                                 Text(
                                  order.order.userId.toString(),
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
                                   order.order.totalItems.toString(),
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
                                   order.order.totalAmount,
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
                                 Text("Acknowledged",
                                     style: TextStyle(color: Colors.black54)),
                                 Spacer(),
                                 Text(
                                   order.order.acknowledged.toString(),
                                   style: TextStyle(
                                     fontSize: 20,
                                   ),
                                 ),
                               ],
                             ),
                              Divider(thickness: .5),
                             Expanded(
                               child: ListView.builder(itemCount: order.product.length,
                                itemBuilder: (context, index) => 
                                 Column(
                                   children: [
                                    
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text("Product",
                                             style: TextStyle(color: Colors.black54)),
                                         Spacer(),
                                         Text(
                                           order.product[index].products!.productName??'',
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
                                       
                                     Text("quantity",
                                         style: TextStyle(color: Colors.black54)),
                                     Spacer(),
                                     Text(
                                       order.product[index].quantity.toString(),
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
                                 Text("Price",
                                     style: TextStyle(color: Colors.black54)),
                                 Spacer(),
                                 Text(
                                   order.product[index].soldPrice.toString(),
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
                                 ),
                                 
                                 
                               ),
                             ),
                           ],
                         ),
                       ),
                     );

              }
              return Text('loading');
         
            },
          )
        ],
      ),
    );
  }
}
