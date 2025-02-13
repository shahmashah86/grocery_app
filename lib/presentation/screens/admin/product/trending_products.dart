import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';


class TrendingProducts extends StatelessWidget {

  final List<ProductsModel> products;


  const TrendingProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  const Color.fromARGB(255, 252, 250, 245),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade100,
      ),
      body:products.isNotEmpty?
       ListView.builder(
        itemCount:products.length,
        itemBuilder: (context, index) {
      
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              // onTap: () =>
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return AdminProductDescription(
     
              //   );
              // })),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(color: Colors.amber.shade50,
             
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.lime)),
                width: double.infinity,
                child: Column(
                  spacing: 10,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                     top: 4
                      ),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .18,
                        width: MediaQuery.sizeOf(context).width * .94,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        
                      
                        ),
                        child:  Container(  decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                       Colors.grey.shade50,
                    Colors.grey.shade100,
                    Colors.black45,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
             

                borderRadius: BorderRadius.circular(16),
              ),
              
                          child: CachedNetworkImage(imageUrl:
                          
                           products[index].image!=null?products[index].image!:'assets/adminicon/Not-Found.jpg',
                            placeholder: (context, url) => const Center(child: SpinKitThreeBounce(size: 20,color:  Color.fromARGB(255, 220, 215, 215),)),
                                          errorWidget: (context, url, error) => Container(decoration: BoxDecoration(
                                          gradient: LinearGradient(stops: [0.1,0.5,0.9],
                                            colors: [
                                              
                                              Colors.grey.shade50,
                                              Colors.grey.shade100,
                                              Colors.black26,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                      
                          
                                          borderRadius: BorderRadius.circular(16),
                                        ),child:Image.asset('assets/adminicon/Not-Found.jpg',fit: BoxFit.cover,) ,),
                                          fit: BoxFit.cover,
                          
                          ),
                        ),
                      ),
                    ),
                    Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            children: [
                              Text(products[index].productName!,
                            
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w500),
                              ),Spacer(),
                               Text( "${products[index].price} / ${products[index].unit}",
                         
                            style: TextStyle(fontSize: 17),
                          ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(products[index].productDescription!,  style: TextStyle(fontSize: 17,overflow: TextOverflow.ellipsis),),
                          
                        )
                       
                      
                      ],
                    ),
                   
                  ],
                ),
              ),
            ),
          );
        },
      ):Center(child: Text("trending products is empty"),)
    );
  }
}
