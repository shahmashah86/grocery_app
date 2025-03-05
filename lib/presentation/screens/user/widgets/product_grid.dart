import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/domain/cart/cart_model/cart_model.dart';
import 'package:grocery_app/domain/products/model/products_model.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:grocery_app/presentation/bloc/product/product_bloc.dart';
import 'package:grocery_app/presentation/screens/user/product_description/product_description.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductsModel>? productdetail;
  final bool? bySearch;
  const ProductGrid({super.key, this.productdetail, this.bySearch});

  @override
  Widget build(BuildContext context) {
    log('pro');
    log(productdetail.toString(), name: 'from productgrid');
    return SliverPadding(
      padding: EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductDescription();
                }));

                context
                    .read<ProductBloc>()
                    .add(Productget(productId: productdetail![index].id!));
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    bySearch == true
                        ?
                        //for showing available and unailable image
                        productdetail![index].isAvailable == true
                            ? CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.56,
                                height:
                                    MediaQuery.of(context).size.height * 0.27,
                                imageUrl: productdetail?[index].image ?? '',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: 60,
                                  color: Colors.black45,
                                ),
                                placeholder: (context, url) => SpinKitPulse(
                                  color: Colors.white,
                                ),
                              )
                            : Stack(
                                children: [
                                  CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    imageUrl: productdetail?[index].image ?? '',
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.block,
                                      size: 40,
                                    ),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SpinKitPulse(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    color: Colors.white.withOpacity(
                                        0.6), // Light overlay effect on the image
                                  ),
                                  Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.08,
                                    left: MediaQuery.of(context).size.width *
                                        0.10,
                                    child: Text(
                                      'Unavailable',
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * 0.56,
                            height: MediaQuery.of(context).size.height * 0.27,
                            imageUrl: productdetail?[index].image ?? '',
                            errorWidget: (context, url, error) => Icon(
                              Icons.block,
                              size: 40,
                            ),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SpinKitPulse(
                              color: Colors.white,
                            ),
                          ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 4, top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productdetail?[index].productName ?? '',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Text(
                                  productdetail?[index].productDescription ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                    "Price: ${productdetail?[index].price ?? ''}"),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (productdetail?[index].isAvailable == true) {
                              CartModel cartItems = CartModel(
                                id: productdetail?[index].id ?? 0,
                                prodName:
                                    productdetail?[index].productName ?? '',
                                price: productdetail?[index].price ?? 0,
                                url: productdetail?[index].image ?? '',
                              );

                              bool itemExists = cartBox.values
                                  .any((item) => item.id == cartItems.id);

                              if (!itemExists) {
                                context
                                    .read<CartBloc>()
                                    .add(CartItemAdd(cartItems: cartItems));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.lime,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Text(
                                      "Product added to cart!",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Text(
                                      "Product already in cart!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    "Product is currently unavailable!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: productdetail?.length ?? 0,
        ),
      ),
    );
  }
}
