import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/admin/product_reg/model/product_reg_model.dart';
import 'package:grocery_app/domain/admin/product_reg/model/products_model.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';

import 'package:grocery_app/presentation/screens/admin/product/product_description.dart';
import 'package:grocery_app/presentation/screens/admin/product/productcreate.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
 

  @override
  void didChangeDependencies() {
    context.read<ProductBloc>().add(ProductList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade200,
        ),
        body:
            // BlocBuilder<ProductBloc, ProductState>(

            BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoaded &&
                state.message == 'Product deleted successfully') {
                  
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.amber.shade200,
                  content: Text(
                    'product deleted succesfully',
                    style: TextStyle(color: Colors.black87),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if ((state is ProductLoaded &&
                    state.message == 'Product is updated successfully') ||
                (state is ProductLoaded &&
                    state.isLoading == false &&
                    state.message == 'Product is updated successfully')) {
              log("inside success state", name: 'product create screen');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Products updated successfully!',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
              // context.read<ProductBloc>().add(ProductList());
            }
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              log("loading", name: 'productlist screen');
              return SpinKitThreeBounce(
                color: Colors.amberAccent,
              );
            }
            if (state is ProductLoaded) {
              log('listview from productlist screen');

              List<ProductRegModel>? products = state.productList;
              log(products.toString());
              

              return ListView.builder(
                itemCount: products?.length ?? 0,
                itemBuilder: (context, index) {
                      log(products![index].products.image??'');
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdminProductDescription(
                          // imgpath:,
                          description:
                              products[index].products.productDescription,
                          price: products[index].products.price.toString(),
                          producName: products[index].products.productName,
                          stockQuantity:
                              products[index].products.stockQuantity.toString(),
                          unit: products[index].products.unit,
                        );
                      })),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.amber.shade100,
                                  Colors.amber.shade50,
                                  Colors.amber.shade100,
                                ],
                                stops: [
                                  0.1,
                                  0.5,
                                  0.8
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.lime)),
                        width: double.infinity,
                        child: Row(
                          spacing: 20,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(
                                colors: [
                                  Colors.amber.shade200,
                                  Colors.amber.shade50,
                                  Colors.amber.shade200,
                                ],
                                stops: [
                                  0.1,
                                  0.5,
                                  0.8
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),),
                                height: MediaQuery.sizeOf(context).height * .18,
                                width: MediaQuery.sizeOf(context).width * .37,
                                clipBehavior: Clip.hardEdge,
                                // child: Container(),
                                                         child:       CachedNetworkImage(
                                  imageUrl: products[index].products.image ??'',
                                  
                                      
                                  placeholder: (context, url) => const Center(
                                      child: SpinKitThreeBounce(
                                    size: 20,
                                    color: Color.fromARGB(255, 220, 215, 215),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/adminicon/Not-Found.jpg',fit: BoxFit.cover,),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].products.productName??'',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Price:${products[index].products.price}",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    "Unit: ${products[index].products.unit}",
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            // Spacer(),
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    onTap: () {
                                      log(products[index]
                                          .products
                                          .id
                                          .toString());
                                      ProductsModel productsToEdit =
                                          ProductsModel(
                                        id: products[index].products.id,
                                        productName: products[index]
                                            .products
                                            .productName,
                                        productDescription: products[index]
                                            .products
                                            .productDescription,
                                        price: products[index].products.price,
                                        unit: products[index].products.unit,
                                        isAvailable: products[index]
                                            .products
                                            .isAvailable,
                                        isTrending:
                                            products[index].products.isTrending,
                                        stockQuantity: products[index]
                                            .products
                                            .stockQuantity,
                                        //  image:products[index].products.image==null?null:products[index].products.image
                                      );

                                      ProductRegModel productsToupdate =
                                          ProductRegModel(
                                              products: productsToEdit,
                                              categories:
                                                  products[index].categories);

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Productcreate(
                                          buttonMode: ProductButtonMode.edit,
                                          productToEdit: productsToupdate,
                                          productIdToupdate:
                                              products[index].products.id,
                                        );
                                      }));
                                    },
                                    value: "Option1",
                                    child: Text("Edit"),
                                  ),
                                  PopupMenuItem<String>(
                                    onTap: () {
                                      context.read<ProductBloc>().add(
                                          productDeletion(
                                              idTodelete:
                                                  products[index].products.id!,
                                              indexinList: index));
                                    },
                                    value: "Option2",
                                    child: Text(
                                      "Delete",
                                    ),
                                  )
                                ];
                              },
                              icon: Icon(Icons.more_vert),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is ProductError) {
              return Center(
                child: Text("Something is wrong while loading"),
              );
            }
            return Text("please wait or try again");
          },
        ));
  }
}
