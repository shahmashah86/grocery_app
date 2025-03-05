// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

class AdminProductDescription extends StatelessWidget {
  const AdminProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade200,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              
             
              if(state is ProductLoaded){
               if(state.isLoading){
                    
                   return Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(),),);
              }

              
              if(state.isError){
                   return Center(child: Text(state.errormsg.toString()));
              }
              if (state.product.isNotEmpty) {
                return Column(crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Container(clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: state.product.first.image ?? '',
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/adminicon/Not-Found.jpg',
                          fit: BoxFit.cover,
                        ),
                        placeholder: (context, url) => SpinKitCircle(
                          color: Colors.white,
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black38, width: 3),
                          color: Colors.amber.shade50),
                      padding: EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 35,
                        children: [
                          Row(children: [
                            Text("Product Name:"),
                            Spacer(),
                            Text(state.product.first.productName!)
                          ]),
                         
                          Row(children: [
                            Text("Price:"),
                            Spacer(),
                            Text(state.product.first.price.toString())
                          ]),
                          Row(children: [
                            Text("Unit:"),
                            Spacer(),
                            Text(state.product.first.unit.toString())
                          ]),
                          Row(children: [
                            Text("Stock Quantity:"),
                            Spacer(),
                            Text(state.product.first.stockQuantity.toString())
                          ]),
                                    Text("description:"),
                            
                            Text(state.product.first.productDescription!,textAlign: TextAlign.justify,style: TextStyle(),)
                           
                          
                           
                      
                        ]
                      ),
                    ),


                    
                  
                  ],
                );
              }
              }
              return Text("Please wait or try again");
              
            },
          ),
        ));
  }
}
