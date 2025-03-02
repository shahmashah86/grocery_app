// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
  }) : super(key: key);

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
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.46,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: const Color.fromARGB(255, 255, 239, 192),
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
                              Text(
                               product.price.toString() ,
                                style: TextStyle(fontSize: 22),
                              )
                            ],
                          ),
                          Text(
                            product.productDescription ?? "",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height*.2,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Quantity',
                                  style: TextStyle(
                                    fontSize: 22,
                                  )),
                              Spacer(),
                              Quantity()
                            ],
                          ),
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
