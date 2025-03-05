// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return Center(child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator(),),);
          }
          if(state is ProductLoaded){
            if(state.isLoading){
                return Center(child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator(),),);

            }
            if(state.isError){
                  return Center(child: Text(state.errormsg.toString()));
              
            }
            if(state.product.isNotEmpty){
              ProductsModel product=state.product.first;
               return Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
              ),
              height: MediaQuery.of(context).size.height * 0.49,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: product.image ?? "",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.black38,
                ),
                placeholder: (context, url) => SpinKitPulse(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(top: 14,left: 12,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: CircleAvatar(child: Center(child: Icon(Icons.chevron_left,color: Colors.black,))))),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      // color: const Color.fromARGB(255, 255, 239, 192),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 12),
                      child: Column(
                        spacing: 13,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.productName ?? "",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                   product.price.toString() ,
                                    style: TextStyle(fontSize: 19),
                                  ),Text(
                                  '/${product.unit.toString()}' ,
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            product.productDescription ?? "",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 14),
                          ),
                        
                          // ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*.01,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.amber)),
                                onPressed: () {
                                     CartModel cartItems = CartModel(
                                            id: product.id!,
                                            prodName: product
                                                    .productName! ,
                                              
                                            price:product.price!,
                                              
                                            url: product.image
                                          );

                                          bool itemExists = cartBox.values.any(
                                              (item) =>
                                                  item.id == cartItems.id);

                                          if (!itemExists) {
                                            context.read<CartBloc>().add(
                                                CartItemAdd(
                                                    cartItems: cartItems));
                                           
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                    "Product added to cart!"),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Text(
                                                  "Product already in cart!",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                duration: Duration(seconds: 1),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
             

                                },
                                child: Center(
                                    child: Text(
                                  "Add to Cart",
                                  style: TextStyle(fontSize: 18),
                                ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]);
        

            }
            
          }
          return Center(child: Text("Loading please wait or try again"));
         
        },
      ),
    );
  }
}

class Quantity extends StatelessWidget {
  Quantity({super.key});

  final ValueNotifier<int> quantity = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: quantity,
      builder: (context, value, child) => Row(
        spacing: 3,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.amber),
              width: MediaQuery.sizeOf(context).height * 0.04,
              height: MediaQuery.sizeOf(context).height * 0.04,
              child: IconButton(
                  padding: EdgeInsets.all(3),
                  onPressed: () {
                    if (quantity.value == 0) {
                      quantity.value = 0;
                    } else {
                      quantity.value = quantity.value - 1;
                    }
                  },
                  icon: Icon(Icons.remove))),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.sizeOf(context).height * 0.04,
              height: MediaQuery.sizeOf(context).height * 0.04,
              child: Center(
                  child: Text(
                "${quantity.value.toString()}Kg",
                style: TextStyle(fontSize: 17),
              ))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.amber),
              width: MediaQuery.sizeOf(context).height * 0.04,
              height: MediaQuery.sizeOf(context).height * 0.04,
              child: IconButton(
                  padding: EdgeInsets.all(3),
                  onPressed: () {
                    quantity.value = quantity.value + 1;
                  },
                  icon: Icon(Icons.add)))
        ],
      ),
    );
  }
}
