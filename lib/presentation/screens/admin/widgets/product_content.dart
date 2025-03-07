import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/common/enums/enums.dart';
import 'package:grocery_app/domain/products/model/product_reg_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/admin/product/product_description.dart';
import 'package:grocery_app/presentation/screens/admin/product/productcreate.dart';

class ProductContent extends StatelessWidget {
  final List<ProductRegModel> products;
  const ProductContent({super.key,required this.products});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
                      child: ListView.builder(
                        itemCount: products?.length ?? 0,
                        itemBuilder: (context, index) {
                          // log(products![index].products.image ?? '');
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AdminProductDescription();
                                }));
                                context.read<ProductBloc>().add(Productget(
                                    productId: products[index].products.id!));
                              },
                              child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.16,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // spacing: 20,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
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
                                              end: Alignment.bottomCenter),
                                        ),
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .14,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .35,
                                        clipBehavior: Clip.hardEdge,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              products![index].products.image ??
                                                  '',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child: SpinKitThreeBounce(
                                            size: 20,
                                            color: Color.fromARGB(
                                                255, 220, 215, 215),
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/adminicon/Not-Found.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index]
                                                  .products
                                                  .productName ??
                                              '',
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Price:${products[index].products.price}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "Unit: ${products[index].products.unit}",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
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
                                                productDescription:
                                                    products[index]
                                                        .products
                                                        .productDescription,
                                                price: products[index]
                                                    .products
                                                    .price,
                                                unit: products[index]
                                                    .products
                                                    .unit,
                                                isAvailable: products[index]
                                                    .products
                                                    .isAvailable,
                                                isTrending: products[index]
                                                    .products
                                                    .isTrending,
                                                stockQuantity: products[index]
                                                    .products
                                                    .stockQuantity,
                                                //  image:products[index].products.image==null?null:products[index].products.image
                                              );

                                              ProductRegModel productsToupdate =
                                                  ProductRegModel(
                                                      products: productsToEdit,
                                                      categories:
                                                          products[index]
                                                              .categories);

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Productcreate(
                                                  buttonMode:
                                                      ProductButtonMode.edit,
                                                  productToEdit:
                                                      productsToupdate,
                                                  productIdToupdate:
                                                      products[index]
                                                          .products
                                                          .id,
                                                  productimage: products[index]
                                                      .products
                                                      .image,
                                                );
                                              }));
                                            },
                                            value: "Option1",
                                            child: Text("Edit"),
                                          ),
                                          PopupMenuItem<String>(
                                            onTap: () {
                                              context.read<ProductBloc>().add(
                                                  ProductDeletion(
                                                      idTodelete:
                                                          products[index]
                                                              .products
                                                              .id!,
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
                      ),
                    );
  }
}