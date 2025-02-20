
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';

import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("My cart") ,
        backgroundColor: Colors.amber.shade200,
      ),
      body:
          // final List<CartEntity> cartlist = cartitemBox.values.toList();

          // log(cartlist.toString());
           BlocBuilder<CartBloc, CartState>(
             builder: (context, state) {
               if(state is CartLoading){
                return CircleAvatar(child: CircularProgressIndicator(),);
              }
             
              if(state is CartLoaded && state.isLoading==true){
         
     return Center(child: CircleAvatar(child: CircularProgressIndicator(),));
              }
              if(state is CartLoaded && state.cartItems!.isEmpty){
                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                    children: [

                      Image.asset('assets/images/emptycart.png',         height: MediaQuery.sizeOf(context).height * .25,),
                      Text("Your cart is currently empty!",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500),),
                                            Text(textAlign: TextAlign.center,"Add you favourite products… and we can change the empty cart! 😉",style: TextStyle(fontSize: 15,color: Colors.black54,),),
                    ],
                  ),
                );
              }
              if(state is CartLoaded  && state.cartItems!.isNotEmpty){
         
                return SingleChildScrollView(
                  child: Column(children: [...List.generate(state.cartItems?.length??0, (index){
                      ValueNotifier<int> quantityselected =
                               ValueNotifier(state.cartItems![index].quantity);
               return      Padding(
                       padding: const EdgeInsets.only(left: 5,right: 5),
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
                                       child: Container(
                                         height: MediaQuery.sizeOf(context).height * .15,
                                         width: MediaQuery.sizeOf(context).width * .3,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           image: DecorationImage(
                                             fit: BoxFit.cover,
                                             image: NetworkImage(state.cartItems![index].url),
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
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                            state.cartItems![index].prodName,
                                             style: TextStyle(
                                                 fontSize: 23, fontWeight: FontWeight.w500),
                                           ),
                                           Text(
                                             state.cartItems![index].price.toString(),
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
                                                   width: MediaQuery.sizeOf(context).height *
                                                       0.035,
                                                   height:
                                                       MediaQuery.sizeOf(context).height *
                                                           0.035,
                                                   child: IconButton(
                                                       padding: EdgeInsets.all(3),
                                                       onPressed: () {
                                                         if (quantityselected.value > 1) {
                                                           quantityselected.value =
                                                               quantityselected.value - 1;
                                                         }
                                                         else{
                                                          return;
                                                         }
                                  
                                                         CartModel cart = CartModel(
                                                             id:state.cartItems![index].id,
                                                             prodName:
                                                                 state.cartItems![index].prodName,
                                                             price: state.cartItems![index].price,
                                                             url: state.cartItems![index].url,
                                                             quantity:
                                                                 quantityselected.value);
                                  
                                                       
                                                        context.read<CartBloc>().add(CartItemToupdate(itemtoUpdate: cart,indextoUpdate: index));
                                                       },
                                                       icon: Icon(
                                                         Icons.remove,
                                                         size: 20,
                                                       ))),
                                               Container(
                                                   decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(10),
                                                   ),
                                                   width: MediaQuery.sizeOf(context).height *
                                                       0.04,
                                                   height:
                                                       MediaQuery.sizeOf(context).height *
                                                           0.04,
                                                   child: ValueListenableBuilder(
                                                     valueListenable: quantityselected,
                                                     builder: (context, value, child) =>
                                                         Center(
                                                             child: Text(
                                                       quantityselected.value.toString(),
                                                       style: TextStyle(fontSize: 15),
                                                     )),
                                                   )),
                                               Container(
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                           BorderRadius.circular(10),
                                                       color: Colors.amber.shade300),
                                                   width: MediaQuery.sizeOf(context).height *
                                                       0.035,
                                                   height:
                                                       MediaQuery.sizeOf(context).height *
                                                           0.035,
                                                   child: IconButton(
                                                       padding: EdgeInsets.all(3),
                                                       onPressed: () {
                                                         quantityselected.value =
                                                             quantityselected.value + 1;
                                                         CartModel cart = CartModel(
                                                             id: state.cartItems![index].id,
                                                             prodName:
                                                                 state.cartItems![index].prodName,
                                                             price: state.cartItems![index].price,
                                                             url: state.cartItems![index].url,
                                                             quantity:
                                                                 quantityselected.value);
                                                                 context.read<CartBloc>().add(CartItemToupdate(itemtoUpdate: cart,indextoUpdate: index));
                                   
                                                        
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
                                        context.read<CartBloc>().add(CartItemDelete(indextoDelete: index));
                                         
                       
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

                  })
                  ,
                  Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 10),
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bill Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Subtotal:'), Text('₹${state.subtotal!.toStringAsFixed(2)}')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Tax (2%):'), Text('₹${state.tax!.toStringAsFixed(2)}')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Delivery Charge:'), Text('₹50')],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('₹${state.total.toString()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {

                           context.read<CartBloc>().add(CartItemclear());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime.shade400,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      child: Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),


                  

                  ],),

                );
            
              }
              return Text("loading");
             },
           )
        
      
    );
  }
}
